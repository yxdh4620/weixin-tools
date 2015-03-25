###
# 微信发送消息的接口
###

debuglog = require("debug")("weixin_tools")
_ = require 'underscore'
assert = require "assert"
request = require 'request'
RequestUrls =  require "../enums/request_urls"

###
#发送模板消息
#params
  msg =
      "touser":"o-5Zdt8pmmpmYqXbTbDUpXwx_kOk"
      "template_id":"Cx7lfTxetVWVKf77h8DRyEj93XfcazYt3faMl9Hhwl8"
      "url":"http://weixin.gamagame.cn"
      "topcolor":"#FF0000"
      "data":
         "first":
           "value":"您预约报名参加的活动，将要开始了"
           "color":"#173177"
         "keynote1":
           "value":"皇上快点群妃乱斗"
           "color":"#173177"
         "keynote2":
           "value":"今天10:00"
           "color":"#173177"
         "remark":
           "value":"欢迎进入游戏"
           "color":"#173177"
  access_token: access_token
#return '{"errcode":40003,"errmsg":"invalid openid"}' or '{"errcode":0,"errmsg":"ok","msgid":204924419}'
###
sendTemplateMessage = (msg, access_token, callback) ->
  assert _.isFunction(callback), "missing callback"
  console.dir msg
  return callback(new Error("msg is empty")) unless msg? and not _.isEmpty(msg)
  url = "#{RequestUrls.SEND_TEMPLATE_MESSAGE_URL}?access_token=#{access_token}"
  options =
    url:url
    json: true
    method: "POST"
    body: JSON.stringify(msg)
  request options, (err, res, body) =>
    return callback err if err?
    return callback new Error("invalid body") unless body?
    return callback new Error("#{body.errcode}:#{body.errmsg}") unless body.errcode == 0 and body.errmsg == 'ok'
    callback null, body
    return
  return


module.exports =
  sendTemplateMessage:sendTemplateMessage




