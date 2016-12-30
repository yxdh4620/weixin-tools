###
# 微信的oauth 登录方式实现工具
###
debuglog = require("debug")("weixin-tools::qrcode")
assert = require "assert"
request = require 'request'
_ = require 'underscore'
querystring = require "querystring"

RequestUrls =  require "../enums/request_urls"


# 创建自定义菜单的接口
# param： access_token
# param:  callback
createQrcode = (access_token, action_info, expire_seconds, action_name, callback) ->
  url = "#{RequestUrls.QRCODE_CREATE_URL}?access_token=#{access_token}"
  data =
    expire_seconds: expire_seconds
    action_name: action_name
    action_info: action_info

  options =
    url: url
    json: true
    method:"POST"
    body: data

  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode#{body.errcode} #{body.errmsg}") if body.errcode? and parseInt(body.errcode) != 0
    return callback null, body
  return


module.exports =
  createQrcode: createQrcode





