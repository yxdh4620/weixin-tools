should = require "should"

p = require "commander"
env = p.environment || 'development'
_ = require 'underscore'
config = require('../config/config')[env]

fs = require('fs')
path = require('path')

pfxFile = path.resolve(__dirname, '../../ssl/apiclient_cert.p12')
certFile = path.resolve(__dirname, '../../ssl/apiclient_cert.pem')
keyFile = path.resolve(__dirname, '../../ssl/apiclient_key.pem')
caFile = path.resolve(__dirname, '../../ssl/rootca.pem')

menus = config.menus

WeixinTools = require "../weixin_tools"
console.dir config
options =
  appid : config.appid
  secret : config.secret
  payOptions: config.payOptions
  jsApiList: config.jsApiList

  sslCert: fs.readFileSync(certFile)
  sslKey: fs.readFileSync(keyFile)
  sslCa: fs.readFileSync(caFile)
  sslPfx: fs.readFileSync(pfxFile)

wxt = new WeixinTools(options)
console.dir wxt
console.dir wxt.PROMOTION_CHECK_NAME

PROMOTION_CHECK_NAME = wxt.PROMOTION_CHECK_NAME


#   partner_trade_no 商户订单号
#   openid: 用户openid
#   check_name: 检验用户姓名
#   re_user_name: 收款用户姓名（可选）
#   amount: 金额（分）
#   desc: 付款描述
#   spbill_create_ip: IP地址

obj =
  partner_trade_no: '10000098201411111234567890'
  openid : 'oJB0rwqcoxDeM1w3TDw_CTxipH5Q'
  check_name: PROMOTION_CHECK_NAME.NO_CHECK
  #re_user_name: ''
  amount: 100
  desc: '测试->接口测试->企业付款功能接口测试'
  spbill_create_ip: '127.0.0.1'


describe "test promotion", ->
  before () ->
    # before test happen
  #describe "test", ->
  #  it "test", (done) ->
  #    a = {name:"hh"}
  #    b = {name:"dd", age:15}
  #    c =  _.extend a, b
  #    console.dir a
  #    console.dir b
  #    console.dir c
  #    done()

  describe "transfers", ->
    it "should transfers", (done) ->
      wxt.promotion obj, (err, data) ->
        console.log err if err?
        console.log JSON.stringify(data)
        done()

