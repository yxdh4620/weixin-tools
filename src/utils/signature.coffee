###
# 微信的签名算法工具
###
debuglog = require("debug")("utils::signature")
crypto = require 'crypto'
request = require 'request'
_ = require 'underscore'
helps = require "./helps"

_raw = (args)  ->
  keys = _.keys(args)
  keys = keys.sort()
  newArgs = {}
  keys.forEach (key) ->
    newArgs[key.toLowerCase()] = args[key]
  str = ""
  for k,v of newArgs
    str += "&"+k+"="+v
  return str.substr(1)

# 计算签名
#makeSignature = (url, jsapi_ticket, noncestr, timestamp) ->
makeSignature = (args) ->
  #args =
  #  url:url
  #  jsapi_ticket:jsapi_ticket
  #  noncestr:noncestr
  #  timestamp:timestamp
  str = helps.raw args
  digest = crypto.createHash("sha1")
    .update(str)
    .digest("hex")
  return digest

# 验证签名
#checkSignature = (signature, url, jsapi_ticket, noncestr, timestamp) ->
#  sign = makeSignature(url, jsapi_ticket, noncestr, timestamp)
checkSignature = (signature, args) ->
  sign = makeSignature(args)
  return sign == signature


module.exports =
  makeSignature:makeSignature
  checkSignature:checkSignature


