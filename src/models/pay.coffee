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
  pkg = _.clone(args)
  delete pkg.sign
  str = helps.raw pkg
  str += "&key=#{@payOptions.partnerKey}"
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
  args = helps.rankAndEncode(args)
  args.sign = @makePaySignature(args)
  xml = helps.json2xml(args)
  options =
    url: RequestUrls.PAY_UNIFIED_ORDER
    method: "POST"
    body: xml
  request options, (err, res, body) =>
    return callback err if err?
    @payValidate body, (err, data) =>
      return callback err if err?
      results =
        appId: @appid
        timeStamp: @generateTimestamp()
        nonceStr: @generateNonceStr()
        signType: "MD5"
        package: "prepay_id=#{data.prepay_id}"
      sign = makePaySignature results
      results.paySign = sign
      return callback null,results

# 验证返回的xml数据，并转为JSON 数据
payValidate = (xml, callback) ->
  #console.log xml
  helps.xml2json xml, (err, data) =>
    #console.dir data
    #console.log "mch_id:#{@payOptions.mchId} appId:#{@appid} sign:#{@makePaySignature(data)} "
    return callback err if err?
    return callback new Error("result data is error") if _.isEmpty(data)
    return callback new Error("errCode: #{data.return_code} message: #{data.return_msg}") unless data.return_code? and data.return_code == 'SUCCESS'
    return callback new Error("errCode: #{data.err_code} message: #{data.err_code_des}") unless data.result_code? and data.result_code == 'SUCCESS'
    return callback new Error("Invalid appId") unless data.appid? and data.appid == @appid
    return callback new Error("Invalid mch_id") unless data.mch_id? and data.mch_id == @payOptions.mchId
    return callback new Error("Invalid Signature") unless data.sign? and data.sign == @makePaySignature(data)
    return callback null, data


module.exports =
  makePaySignature: makePaySignature
  getBrandWCPayRequestParams:getBrandWCPayRequestParams
  payValidate: payValidate

