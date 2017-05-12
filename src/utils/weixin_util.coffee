###
# TODO 废弃！已经被拆分到各个models 中去了。
# 微信的工具类
# author: YuanXiangDong
# date: 2015-03-03
###

logger = require 'dev-logger'
crypto = require 'crypto'
_ = require 'underscore'
request = require 'request'
assert = require "assert"
{redis} = require '../utils/redis_db'

# 缓存与redis中得微信票据的数据的key
REDIS_WEIXIN_KEYS =
  access_token:"weixin_access_token"
  jsapi_ticket:"weixin_jsapi_ticket"

WEIXIN_INTERFACE_URLS =
  GET_ACCESS_TOKEN_URL : "https://api.weixin.qq.com/cgi-bin/token"
  GET_JSAPI_TICKET_URL : "https://api.weixin.qq.com/cgi-bin/ticket/getticket"
  GET_MENUS_URL: "https://api.weixin.qq.com/cgi-bin/menu/get"
  POST_MENUS_URL: "https://api.weixin.qq.com/cgi-bin/menu/create"
  DELETE_MENUS_URL: "https://api.weixin.qq.com/cgi-bin/menu/delete"


WEIXIN_APP_ID = null
WEIXIN_SECRET = null

# 读取redis中指定key得微信票据数据
_loadCacheTicket = (key, callback) ->
  redis.get key, (err, value) ->
    if err?
      logger.error "[weixin_util::_loadCacheTicket] error:#{err}"
      return callback err
    return callback null, value
  return

# 将制定key 的微信票据缓存redis， 缓存时间seconds
_cacheTicket = (key, seconds, value, callback) ->
  #console.log "key:#{key} seconds:#{seconds} value:#{value}"
  redis.setex key, seconds, value, (err) ->
    logger.error "[weixin_util::_cacheTicket] error#{err}" if err?
    callback err
    return
  return

_raw = (args)  ->
  keys = _.keys(args)
  keys = keys.sort()
  newArgs = {}
  keys.forEach (key) ->
    newArgs[key.toLowerCase()] = args[key]
  str = ""
  console.dir newArgs
  for k,v of newArgs
    str += "&"+k+"="+v
  return str.substr(1)

init = (options) ->
  logger.log "LOG [weixin_util::init] start"
  assert options, "missing optinos"
  WEIXIN_APP_ID = options.appid
  WEIXIN_SECRET = options.secret
  assert WEIXIN_APP_ID, "missing weixin appid"
  assert WEIXIN_SECRET, "missing weixin secret"
  return

# 获得微信的access_token
getAccessToken = (callback) ->
  _loadCacheTicket REDIS_WEIXIN_KEYS.access_token, (err, result) ->
    return callback null, result if not err and result?
    url = "#{WEIXIN_INTERFACE_URLS.GET_ACCESS_TOKEN_URL}?grant_type=client_credential&appid=#{WEIXIN_APP_ID}&secret=#{WEIXIN_SECRET}"
    options =
      url: url
      method: "GET"
      json: true
    request options, (err,res,body)->
      return callback err if err?
      return callback new Error("result data is error") if _.isEmpty(body)
      return callback new Error("errCode#{body.errcode} #{body.errmsg}") if body.errcode? and parseInt(body.errcode) != 0
      return callback new Error("get access_token is null") unless body.access_token?
      seconds = parseInt(body.expires_in) - 600
      _cacheTicket REDIS_WEIXIN_KEYS.access_token, seconds, body.access_token, (err) ->
        return callback err if err?
        return callback(null, body.access_token)
      return
    return
  return

#获得微信的jsapi_ticket
getJsapiTicket = (callback) ->
  _loadCacheTicket REDIS_WEIXIN_KEYS.jsapi_ticket, (err, result) ->
    return callback null, result if not err and result?
    getAccessToken (err, access_token) ->
      return callback err if err?
      url = "#{WEIXIN_INTERFACE_URLS.GET_JSAPI_TICKET_URL}?access_token=#{access_token}&type=jsapi"
      options =
        url: url
        method: "GET"
        json: true
      request options, (err,res,body)->
        return callback err if err?
        return callback new Error("result data is error") if _.isEmpty(body)
        return callback new Error("errCode#{body.errcode} #{body.errmsg}") if body.errcode? and parseInt(body.errcode) != 0
        return callback new Error("get access_token is null") unless body.ticket?
        seconds = parseInt(body.expires_in) - 600
        _cacheTicket REDIS_WEIXIN_KEYS.jsapi_ticket, seconds, body.ticket, (err) ->
          return callback err if err?
          return callback(null, body.ticket)
        return
      return
    return
  return

# 创建自定义菜单的接口
# param: menus 自定义菜单的json 数据
createMenus = (menus, callback) ->
  getAccessToken (err, access_token) ->
    return callback err if err?
    url = "#{WEIXIN_INTERFACE_URLS.POST_MENUS_URL}?access_token=#{access_token}"
    options =
      url: url
      json: true
      method:"POST"
      body: menus
    request options, (err, res, body) ->
      return callback err if err?
      return callback null, body

# 获取自定义菜单JSON的接口
loadMenus = (callback) ->
  getAccessToken (err, access_token) ->
    return callback err if err?
    url = "#{WEIXIN_INTERFACE_URLS.GET_MENUS_URL}?access_token=#{access_token}"
    options =
      url: url
      json: true
      method:"GET"
    request options, (err, res, body) ->
      return callback err if err?
      return callback null, body

deleteMenus = (callback) ->
  getAccessToken (err, access_token) ->
    return callback err if err?
    url = "#{WEIXIN_INTERFACE_URLS.DELETE_MENUS_URL}?access_token=#{access_token}"
    options =
      url: url
      json: true
      method:"GET"
    request options, (err, res, body) ->
      return callback err if err?
      return callback null, body

# 创建一个用于签名的随机字符串
generateNonceStr = () ->
  return Math.random().toString(36).substr(2,15)
# 生成一个时间戳（单位：秒）
generateTimestamp = () ->
  return parseInt(Date.now()/1000)

# 计算签名
makeSignature = (url, jsapi_ticket, noncestr, timestamp) ->
  args =
    url:url
    jsapi_ticket:jsapi_ticket
    noncestr:noncestr
    timestamp:timestamp
  str = _raw args
  console.log "str:#{str}"
  digest = crypto.createHash("sha1")
    .update(str)
    .digest("hex")
  return digest

# 验证签名
checkSignature = (signature, url, jsapi_ticket, noncestr, timestamp) ->
  sign = makeSignature(url, jsapi_ticket, noncestr, timestamp)
  return sign == signature

# 获得微信的config
generateConfig = (jsapi_ticket, url) ->
  noncestr = generateNonceStr()
  timestamp = generateTimestamp()
  sign = makeSignature url, jsapi_ticket, noncestr, timestamp
  result =
    appId: WEIXIN_APP_ID
    jsapi_ticket:jsapi_ticket
    noncestr: noncestr
    timestamp:timestamp
    url:url
    signature: sign
  return result

module.exports =
  init: init
  getAccessToken: getAccessToken
  getJsapiTicket: getJsapiTicket
  loadMenus: loadMenus
  createMenus: createMenus
  deleteMenus: deleteMenus
  makeSignature:makeSignature
  checkSignature:checkSignature
  generateConfig:generateConfig




