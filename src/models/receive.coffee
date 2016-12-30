###
# 微信接收消息（事件）的接口, 并做相关处理
###

debuglog = require("debug")("weixin_tools::receive")
_ = require 'underscore'
assert = require "assert"
request = require 'request'
RequestUrls =  require "../enums/request_urls"
helps = require "../utils/helps"

#接收消息的总入口
receiveMessage = (msgXml, callback) ->
  assert _.isFunction(callback), "missing callback"
  helps.xml2json msgXml, (err, data) =>
    callback err, data

module.exports =
  receiveMessage:receiveMessage




