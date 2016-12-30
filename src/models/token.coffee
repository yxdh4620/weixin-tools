###
# 用于获得 access_token, jsapi_ticket 的工具
# 这里只负责从微信接口取，不负责本地的缓存
###
debuglog = require("debug")("weixin-tools::token")
assert = require "assert"
request = require 'request'
_ = require 'underscore'
RequestUrls =  require "../enums/request_urls"

#获取access_token , 有访问次数限制， 获得后需要本地缓存
# param: callback 回调函数， （err, token）
# 正常token是一个json对象， 如下:
# { access_token: 'f5MOW9CXcxrJxEPNoLI431iG-SEvBlwCWbGMfrATF8-6_gMC6_6-Ipqmy2OnYS1M20MB5XZXAE7vAHCbyU1tFqvcJ6pWrYaSbndsraO5ZmA',
#   expires_in: 7200 }
loadAccessToken = (callback) ->
  console.log "appid: #{@appid}"
  url = "#{RequestUrls.GET_ACCESS_TOKEN_URL}?grant_type=client_credential&appid=#{@appid}&secret=#{@secret}"
  options =
    url: url
    method: "GET"
    json: true
  console.dir callback
  request options, (err, res, body)->
    return callback err if err?
    return callback new Error("result data is error") if _.isEmpty(body)
    return callback new Error("errCode#{body.errcode} #{body.errmsg}") if body.errcode? and parseInt(body.errcode) != 0
    return callback new Error("get access_token is null") unless body.access_token?
    return callback null, body
  return

#获取jsapi_ticket, 有访问次数限制， 获得后需要本地缓存
# param: access_token
# param: callback 回调函数， （err, ticket）
# 正常token是一个json对象， 如下:
# { errcode: 0,
#   errmsg: 'ok',
#   ticket: 'sM4AOVdWfPE4DxkXGEs8VFXzXlm0blQsLfNUpWD-79wW-qQt4bbntT_ej_zUtj3BrLltJGJDuB0s-_BRivFo5Q',
#   expires_in: 7200 }
loadJsapiTicket = (access_token, callback) ->
  url = "#{RequestUrls.GET_JSAPI_TICKET_URL}?access_token=#{access_token}&type=jsapi"
  options =
    url: url
    method: "GET"
    json: true
  request options, (err,res,body)->
    return callback err if err?
    return callback new Error("result data is error") if _.isEmpty(body)
    return callback new Error("errCode#{body.errcode} #{body.errmsg}") if body.errcode? and parseInt(body.errcode) != 0
    return callback new Error("get access_token is null") unless body.ticket?
    return callback(null, body)
    return
  return


module.exports =
  loadAccessToken:loadAccessToken
  loadJsapiTicket:loadJsapiTicket




