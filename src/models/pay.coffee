###
# 微信支付接口的工具类
# date 2015-03-11
# auther YuanXiangDong
###

debuglog = require("debug")("weixin_tools")
assert = require "assert"
request = require 'request'
RequestUrls =  require "../enums/request_urls"
helps = require "./helps"



makePaySignature = (args, signType="sha1") ->
  str = helps.raw args
  digest = crypto.createHash("sha1")
    .update(str)
    .digest("hex")
  return digest

