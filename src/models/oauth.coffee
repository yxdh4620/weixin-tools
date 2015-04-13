###
# 微信的oauth 登录方式实现工具
###
debuglog = require("debug")("utils::oauth")
assert = require "assert"
request = require 'request'
_ = require 'underscore'
querystring = require "querystring"

RequestUrls =  require "../enums/request_urls"

RESPONSE_TYPE = 'code'
SCOPEN_TYPES =
  base:"snsapi_base"
  userinfo:"snsapi_userinfo"

# 生成一个带回调http_url 的链接
# param redirect 回调地址
# param state 用户定义的数据
# param scope 作用范围，值为snsapi_userinfo和snsapi_base，
#   前者请求用户信息，会弹出确认绑定，后者只请求openid
generateAuthorizeURL = (redirect, state, scope) ->
  info =
    appid: @appid
    redirect_uri: redirect
    response_type: RESPONSE_TYPE
    scope: scope || SCOPEN_TYPES.base
    state: state || ''
  return RequestUrls.GET_AUTHORIZE_URL + '?' + querystring.encode(info) + '#wechat_redirect';

# 根据在generateAuthorizeURL 中的那个回调地址 redirect 中获得的query.code
# 得到 一个access_token 和openid(格式如下)， 可以用这个access_token和openid 获得用户的信息
# param code 回调地址redirect 获得的code
# {
#   "access_token": "OezXcEiiBSKSxW0eoylIeAsR0GmYd1awCffdHgb4fhS_KKf2CotGj2cBNUKQQvj-oJ9VmO-0Z-_izfnSAX_s0aqDsYkW4s8W5dLZ4iyNj5Y6vey3dgDtFki5C8r6D0E6mSVxxtb8BjLMhb-mCyT_Yg",
#   "expires_in": 7200,
#   "refresh_token": "OezXcEiiBSKSxW0eoylIeAsR0GmYd1awCffdHgb4fhS_KKf2CotGj2cBNUKQQvj-oJ9VmO-0Z-_izfnSAX_s0aqDsYkW4s8W5dLZ4iyNj5YBkF0ZUH1Ew8Iqea6x_itq13sYDqP1D7ieaDy9u2AHHw",
#   "openid": "oLVPpjqs9BhvzwPj5A-vTYAX3GLc",
#   "scope": "snsapi_base"
# }
# {
#   "access_token":"ACCESS_TOKEN",
#   "expires_in":7200,
#   "refresh_token":"REFRESH_TOKEN",
#   "openid":"OPENID",
#   "scope":"SCOPE"
# };
loadAuthorzeToken = (code, callback) ->
  url = "#{RequestUrls.GET_AUTHORIZE_TOKEN_URL}?appid=#{@appid}&secret=#{@secret}&code=#{code}&grant_type=authorization_code"
  options =
    url: url
    method: "GET"
    json: true
  request options, (err, res, body)->
    console.dir body
    return callback err if err?
    return callback new Error("result data is error") if _.isEmpty(body)
    return callback new Error("errCode#{body.errcode} #{body.errmsg}") if body.errcode? and parseInt(body.errcode) != 0
    return callback new Error("get authorze_token is null") unless body.access_token?
    return callback null, body

# 根据loadAuthorzeToken中获得的refresh_token 刷新authorze_token
refreshAuthorzeToken = (refresh_token, callback) ->
  url = "#{RequestUrls.GET_RE_AUTHORIZE_TOKEN_URL}?appid=#{@appid}&refresh_token=#{refresh_token}&grant_type=refresh_token"
  options =
    url: url
    method: "GET"
    json: true
  request options, (err, res, body)->
    console.dir body
    return callback err if err?
    return callback new Error("result data is error") if _.isEmpty(body)
    return callback new Error("errCode#{body.errcode} #{body.errmsg}") if body.errcode? and parseInt(body.errcode) != 0
    return callback new Error("get authorze_token is null") unless body.access_token?
    return callback null, body

#根据openid，获取用户信息
loadUserInfo = (openid, authorze_token, lang='zh_CN', callback) ->
  url = "#{RequestUrls.GET_USER_INFO_URL}?access_token=#{authorze_token}&openid=#{openid}&lang=#{lang}"
  console.log "loadUserInfo:: url:: #{url}"
  options =
    url: url
    method: "GET"
    json: true
  request options, (err, res, body)->
    console.dir body
    return callback err if err?
    return callback new Error("result data is error") if _.isEmpty(body)
    return callback new Error("errCode#{body.errcode} #{body.errmsg}") if body.errcode? and parseInt(body.errcode) != 0
    #return callback new Error("get access_token is null") unless body.access_token?
    return callback null, body

loadUserInfoUnion = (openid, access_token, lang='zh_CN', callback) ->
  url = "#{RequestUrls.GET_USER_INFO_UNIONID_URL}?access_token=#{access_token}&openid=#{openid}&lang=#{lang}"
  console.log "loadUserInfo:: url:: #{url}"
  options =
    url: url
    method: "GET"
    json: true
  request options, (err, res, body)->
    #console.dir body
    return callback err if err?
    return callback new Error("result data is error") if _.isEmpty(body)
    return callback new Error("errCode#{body.errcode} #{body.errmsg}") if body.errcode? and parseInt(body.errcode) != 0
    return callback null, body

module.exports =
  generateAuthorizeURL: generateAuthorizeURL
  loadAuthorzeToken:loadAuthorzeToken
  refreshAuthorzeToken:refreshAuthorzeToken
  loadUserInfo:loadUserInfo
  loadUserInfoUnion:loadUserInfoUnion

