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
generateAuthorizeURL = (appid, redirect, state, scope) ->
  info =
    appid: appid
    redirect_uri: redirect
    response_type: RESPONSE_TYPE
    scope: scope || SCOPEN_TYPES.base
    state: state || ''
  return RequestUrls.GET_AUTHORIZE_URL + '?' + querystring.encode(info) + '#wechat_redirect';


loadAuthorzeToken = (appid, secret, code, callback) ->
  url = "#{RequestUrls.GET_AUTHORIZE_TOKEN_URL}?appid=#{appid}&secret=#{secret}&code=#{code}&grant_type=authorization_code"
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

refreshAuthorzeToken = (appid, refresh_token, callback) ->
  url = "#{RequestUrls.GET_RE_AUTHORIZE_TOKEN_URL}?appid=#{appid}&refresh_token=#{refresh_token}&grant_type=refresh_token"
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

module.exports =
  generateAuthorizeURL: generateAuthorizeURL
  loadAuthorzeToken:loadAuthorzeToken
  refreshAuthorzeToken:refreshAuthorzeToken
  loadUserInfo:loadUserInfo


