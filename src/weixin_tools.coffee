debuglog = require("debug")("weixin_tools")
assert = require "assert"
token = require "./utils/token"
menus = require "./utils/menus"
signature = require "./utils/signature"
oauth = require "./utils/oauth"

###
# 微信的工具类
###

class WeixinTools

  constructor: (appid, secret, jsApiList, isDebug) ->
    debuglog "LOG [weixin_tools::constructor] start"
    @appid = appid
    @secret = secret
    @isDebug = isDebug || false
    @jsApiList = jsApiList || []
    assert @appid, "missing weixin appid"
    assert @secret, "missing weixin secret"
    return

  #获取access_token , 有访问次数限制， 获得后需要本地缓存
  # param: callback 回调函数， （err, token）
  # 正常token是一个json对象， 如下:
  # { access_token: 'f5MOW9CXcxrJxEPNoLI431iG-SEvBlwCWbGMfrATF8-6_gMC6_6-Ipqmy2OnYS1M20MB5XZXAE7vAHCbyU1tFqvcJ6pWrYaSbndsraO5ZmA',
  #   expires_in: 7200 }
  loadAccessToken:(callback)->
    token.loadAccessToken @appid, @secret, callback

  #获取jsapi_ticket, 有访问次数限制， 获得后需要本地缓存
  # param: access_token
  # param: callback 回调函数， （err, ticket）
  # 正常token是一个json对象， 如下:
  # { errcode: 0,
  #   errmsg: 'ok',
  #   ticket: 'sM4AOVdWfPE4DxkXGEs8VFXzXlm0blQsLfNUpWD-79wW-qQt4bbntT_ej_zUtj3BrLltJGJDuB0s-_BRivFo5Q',
  #   expires_in: 7200 }
  loadJsapiTicket:token.loadJsapiTicket

  # 获取自定义菜单， 有访问限制
  # param： access_token
  # param:  callback
  loadMenus: menus.loadMenus
  # 删除自定义菜单
  # param： access_token
  # param:  callback
  deleteMenus: menus.deleteMenus
  # 创建自定义菜单的接口
  # param： access_token
  # param:  callback
  createMenus: menus.createMenus


  # 创建一个用于签名的随机字符串
  generateNonceStr : () ->
    return Math.random().toString(36).substr(2,15)
  # 生成一个时间戳（单位：秒）
  generateTimestamp : () ->
    return parseInt(Date.now()/1000)

  # 签名计算方法
  # param: url 访问的http地址
  # param: jsapi_ticket
  # param: noncestr 一个随机字符串
  # param: timestamp 时间戳（miao）
  makeSignature: signature.makeSignature
  # 验证签名
  # param: signature 要验证的签名
  # param: url 访问的http地址
  # param: jsapi_ticket
  # param: noncestr 一个随机字符串
  # param: timestamp 时间戳（miao）
  checkSignature: signature.checkSignature

  # 生成提供给微信js-apk 使用的config
  # param: 访问地址的url,
  # param: jsapi_ticket
  generateConfig: (url, jsapi_ticket) ->
    noncestr = @generateNonceStr()
    timestamp = @generateTimestamp()
    sign = @makeSignature url, jsapi_ticket, noncestr, timestamp
    result =
      debug:@isDebug
      appId:@appid
      jsapi_ticket:jsapi_ticket
      nonceStr: noncestr
      timestamp:timestamp
      signature: sign
      jsApiList: @jsApiList || []
    return result

  # 生成一个带回调http_url 的链接
  # param redirect 回调地址
  # param state 用户定义的数据
  # param scope 作用范围，值为snsapi_userinfo和snsapi_base，
  #   前者请求用户信息，会弹出确认绑定，后者只请求openid
  generateAuthorizeURL:(redirect, state, scope) ->
    return oauth.generateAuthorizeURL @appid, redirect, state, scope

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
  loadAuthorzeToken: (code, callback) ->
    return oauth.loadAuthorzeToken @appid, @secret, code, callback

  # 根据loadAuthorzeToken中获得的refresh_token 刷新authorze_token
  refreshAuthorzeToken : (refresh_token, callback) ->
    return oauth.refreshAuthorzeToken @appid, refresh_token, callback

  #根据openid，获取用户信息
  #
  loadUserInfo: (openid, authorze_token, lang, callback) ->
    return oauth.loadUserInfo openid, authorze_token, lang, callback

module.exports = WeixinTools


