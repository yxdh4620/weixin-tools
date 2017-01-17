###
# 企业付款功能接口， 需要双向证书
# date 2017-01-17
# auther YuanXiangDong
###

debuglog = require("debug")("weixin_tools::pay")
assert = require "assert"
_ = require 'underscore'
crypto = require 'crypto'
request = require 'request'
RequestUrls =  require "../enums/request_urls"
helps = require "../utils/helps"
iconv = require "iconv-lite"

# 企业付款功能接口
# param args
#   partner_trade_no 商户订单号
#   openid: 用户openid
#   check_name: 检验用户姓名
#   re_user_name: 收款用户姓名（可选）
#   amount: 金额（分）
#   desc: 付款描述
#   spbill_create_ip: IP地址
promotion = (args, callback) ->
  debuglog "[promotion] args", args
  args.mch_appid = @appid
  args.mchid = @payOptions.mchId
  args.nonce_str = @generateNonceStr()
  args = helps.rankAndEncode(args)
  args.sign = @makePaySignature(args)
  xml = helps.json2xml(args)
  console.log xml
  options =
    url: RequestUrls.PROMOTION_TRANSFERS_URL
    method: "POST"
    agentOptions: @agentOptions
    body: xml
  request options, (err, res, body) =>
    return callback err if err?
    @promotionValidate body, (err, data) =>
      return callback err, data
    return
  return

# 验证返回的xml数据，并转为JSON 数据
promotionValidate = (xml, callback) ->
  helps.xml2json xml, (err, data) =>
    console.dir data
    console.log "mch_id:#{@payOptions.mchId} appId:#{@appid} sign:#{@makePaySignature(data)} "
    return callback err if err?
    return callback new Error("result data is error") if _.isEmpty(data)
    return callback new Error("errCode: #{data.return_code} message: #{data.return_msg}") unless data.return_code? and data.return_code == 'SUCCESS'
    return callback new Error("errCode: #{data.err_code} message: #{data.err_code_des}") unless data.result_code? and data.result_code == 'SUCCESS'
    return callback new Error("Invalid appId") unless data.mch_appid? and data.mch_appid == @appid
    return callback new Error("Invalid mch_id") unless data.mchid? and data.mchid == @payOptions.mchId
    return callback null, data

module.exports =
  promotion : promotion
  promotionValidate: promotionValidate

