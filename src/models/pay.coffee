###
# 微信支付接口的工具类
# date 2015-03-11
# auther YuanXiangDong
###

debuglog = require("debug")("weixin_tools")
assert = require "assert"
_ = require 'underscore'
crypto = require 'crypto'
request = require 'request'
RequestUrls =  require "../enums/request_urls"
helps = require "../utils/helps"

PAY_DEFAULT_PARAMS = null

# 微信支付的签名算法
makePaySignature = (args, signType="md5") ->
  #console.dir args
  str = helps.raw args
  #console.log "str: #{str}"
  str += "&key=#{@payOptions.partnerKey}"
  #console.log "str: #{str}"
  digest = crypto.createHash(signType)
    .update(str)
    .digest("hex")
  return digest.toUpperCase()

###
获取JSAPI支付参数

order = {
  body: '吮指原味鸡 * 1',
  #attach: '{"部位":"三角"}',
  out_trade_no: 'kfc001',
  total_fee: 10 * 100,
  spbill_create_ip: req.ip,
  openid: req.user.openid,
  trade_type: 'JSAPI'
}
###
getBrandWCPayRequestParams = (args, callback) ->
  args.appid = @appid
  args.trade_type = args.trade_type || "JSAPI"
  args.mch_id = @payOptions.mchId
  args.notify_url = @payOptions.notifyUrl
  args.nonce_str = @generateNonceStr()
  args.sign = @makePaySignature(args)
  #console.dir args
  xml = helps.json2xml(args)
  #console.log "xml: #{xml}"
  options =
    url: RequestUrls.PAY_UNIFIED_ORDER
    method: "POST"
    body: xml
  #console.dir options
  request options, (err, res, body) =>
    #console.dir body
    return callback err if err?
    helps.xml2json body, (err, data) =>
      return callback err if err?
      return callback new Error("result data is error") if _.isEmpty(data)
      return callback new Error("errCode:#{data.return_code} message:#{data.return_msg}") unless data.return_code? and data.return_code == 'SUCCESS'
      return callback new Error("errCode: #{data.err_code} message:#{data.err_code_des}") unless data.result_code? and data.result_code == 'SUCCESS'
      results =
        appId: @appid
        timeStamp: @generateTimestamp()
        nonceStr: @generateNonceStr()
        signType: "MD5"
        package: "prepay_id=#{data.prepay_id}"
      sign = makePaySignature results
      results.paySign = sign
      return callback null,results



module.exports =
  makePaySignature: makePaySignature
  getBrandWCPayRequestParams:getBrandWCPayRequestParams

