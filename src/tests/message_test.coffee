should = require "should"

p = require "commander"
env = p.environment || 'development'
_ = require 'underscore'
config = require('../config/config')[env]

menus = config.menus

noncestr="Wm3WZYTPz0wzccnW"
jsapi_ticket="sM4AOVdWfPE4DxkXGEs8VMCPGGVi4C3VM0P37wVUCFvkVAy_90u5h9nbSlYy3-Sl-HhTdfl2fzFy1AOcHKP7qg"
timestamp="1414587457"
url="http://mp.weixin.qq.com?params=value"
signature = '0f9de62fce790f9a083d5c99e95740ceb90c27ed'
signature = '0f9de62fce790f9a083d5c99e95740ceb90c27ed'

WeixinTools = require "../weixin_tools"
options =
  appid : config.appid
  secret : config.secret
  payOptions: config.payOptions
  jsApiList: config.jsApiList
  originalID: config.originalID
wxt = new WeixinTools(options)

token = null

subscribeXML = """
  <xml>
    <ToUserName>asdfasfa<ToUserName>
    <FromUserName>dsafasfasf</FromUserName>
    <CreateTime>123456789</CreateTime>
    <MsgType><![CDATA[event]]></MsgType>
    <Event><![CDATA[subscribe]]></Event>
  </xml>
"""


describe "test weixin_tools", ->
  before () ->
    # before test happen

  #describe "token", ->
  #  it "should get access_token", (done) ->
  #    wxt.loadAccessToken (err, data) ->
  #      console.dir err if err?
  #      token = data
  #      console.dir token
  #      done()

  #  it "should get jsapi_ticket", (done) ->
  #    return done() unless token?
  #    wxt.loadJsapiTicket token.access_token, (err, data) ->
  #      console.log err if err?
  #      console.dir data
  #      done()

  describe "message", ->
    token =
      access_token: "nfbIHl9p_TyQFJ6KQvF3YTrjIG1QjB14KhoRlmQ8fjCwfHHjDV7uJWL7KB3PZR4dW95QBupypwNP_tCGuuX8oEdxVNyiuxd-whpJZ2hN_dE"
      ticket: "sM4AOVdWfPE4DxkXGEs8VFj5UEhJXZMbuiU3wOuFKqHuT5pm3O9Y1kLceFR_XIIdtcVN9YNpVpDvUBUq7nSLkA"

  #  messages =
  #    "touser":"o-5Zdt8pmmpmYqXbTbDUpXwx_kOk"
  #    "template_id":"Cx7lfTxetVWVKf77h8DRyEj93XfcazYt3faMl9Hhwl8"
  #    "url":"http://weixin.gamagame.cn"
  #    "topcolor":"#FF0000"
  #    "data":
  #       "first":
  #         "value":"您预约报名参加的活动，将要开始了"
  #         "color":"#173177"
  #       "keynote1":
  #         "value":"皇上快点群妃乱斗"
  #         "color":"#173177"
  #       "keynote2":
  #         "value":"今天10:00"
  #         "color":"#173177"
  #       "remark":
  #         "value":"欢迎进入游戏"
  #         "color":"#173177"
  #  access_token = "S46cBuZhmFgC0XlgR4VNLIhsui7aimzuzIxY8-kYVZoPm4_ijWbi0pScnreZztnje19Bi5cPEzjOyvsfkUo_Qb3dXCQvvSrl87CzuZStZ8A"
  #  it "send template message", (done) ->
  #    wxt.sendTemplateMessage messages, access_token, (err, body) ->
  #      console.error err if err?
  #      console.dir body
  #      done()

    it "send auto message", (done) ->
      subscribeXML = """
      <xml><URL><![CDATA[http://mintr-dev.gamagama.cn/weixin/wechat]]></URL><ToUserName><![CDATA[wxe143a2b06d92c16b]]></ToUserName><FromUserName><![CDATA[o-5Zdt8pmmpmYqXbTbDUpXwx_kOk]]></FromUserName><CreateTime>1427706395</CreateTime><MsgType><![CDATA[text]]></MsgType><Content><![CDATA[asdfasf]]></Content><MsgId>1</MsgId></xml>
      """

      wxt.receiveMessage subscribeXML, (err, data)->
        console.error err if err?
        console.dir data
        result = wxt.autoReplyMessage(data.FromUserName, data.MsgType, data.Content||data.MediaId)
        console.log result
        done()

