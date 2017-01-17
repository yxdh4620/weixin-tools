debuglog = require("debug")("weixin_tools")
assert = require "assert"
_ = require 'underscore'

###
# 微信的工具类
###
class WeixinTools

  constructor: (options) ->
    debuglog "LOG [weixin_tools::constructor] start"
    #console.dir options
    @appid = options.appid
    @secret = options.secret
    @isDebug = options.isDebug || false
    @jsApiList = options.jsApiList || []
    assert @appid, "missing weixin appid"
    assert @secret, "missing weixin secret"

    #支付用参数
    @payOptions = options.payOptions
    assert @payOptions, "missing weixin payOptions"
    @payOptions.passphrase = @payOptions.passphrase || @payOptions.mchId

    @originalID = options.originalID

    @sslCert = options.sslCert
    @sslKey = options.sslKey
    @sslCa = options.sslCa
    @sslPfx = options.sslPfx
    @agentOptions =
      cert: @sslCert
      key: @sslKey
      ca: @sslCa


    #@payOptions.mchId = options.mchId
    #@payOptions.partnerKey = options.partnerKey
    #@payOptions.subMchId = options.subMchId
    #@payOptions.notifyUrl = options.notifyUrl
    #@payOptions.pfx = options.pfx

    @mixins()
    #console.dir @
    return


  mixins: ->
    #获取TOKEN jsapi_ticket 的模块
    @mixin(require("./models/token"))
    #签名验证模块
    @mixin(require("./models/signature"))
    #自定义菜单模块
    @mixin(require("./models/menus"))
    # oauth2 模块
    @mixin(require("./models/oauth"))
    # 支付模块
    @mixin(require("./models/pay"))
    # 发送消息模块
    @mixin(require("./models/message"))
    # 接收消息模块
    @mixin(require("./models/receive"))
    # 素材管理模块
    @mixin(require("./models/material"))
    # 二维码模块（生成）
    @mixin(require("./models/qrcode"))
    # 企业付款功能接口
    @mixin(require("./models/promotion"))
    return

  mixin: (obj) ->
    for key, v of obj
      @[key] = v
    return

  # 创建一个用于签名的随机字符串
  generateNonceStr : () ->
    return Math.random().toString(36).substr(2,15)
  # 生成一个时间戳（单位：秒）
  generateTimestamp : () ->
    return parseInt(Date.now()/1000)

  # 生成提供给微信js-apk 使用的config
  # param: 访问地址的url,
  # param: jsapi_ticket
  generateConfig: (url, jsapi_ticket) ->
    noncestr = @generateNonceStr()
    timestamp = @generateTimestamp()
    #sign = @makeSignature url, jsapi_ticket, noncestr, timestamp
    args =
      url:url
      jsapi_ticket:jsapi_ticket
      noncestr:noncestr
      timestamp:timestamp
    sign = @makeSignature args
    result =
      debug:@isDebug
      appId:@appid
      jsapi_ticket:jsapi_ticket
      nonceStr: noncestr
      timestamp:timestamp
      signature: sign
      jsApiList: @jsApiList || []
    return result

  QRCODE_ACTION_NAME : require('./enums/qrcode_action_name')

  PROMOTION_CHECK_NAME : require './enums/promotion_check_name'

  ############################ 支付相关 start ##########################################
  makePaySignature : (args) ->

  ############################ 支付相关 end ##########################################

module.exports = WeixinTools


