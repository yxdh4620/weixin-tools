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

signArgs =
  noncestr:"Wm3WZYTPz0wzccnW"
  jsapi_ticket:"sM4AOVdWfPE4DxkXGEs8VMCPGGVi4C3VM0P37wVUCFvkVAy_90u5h9nbSlYy3-Sl-HhTdfl2fzFy1AOcHKP7qg"
  timestamp:"1414587457"
  url:"http://mp.weixin.qq.com?params=value"


WeixinTools = require "../weixin_tools"
options =
  appid : config.appid
  secret : config.secret
  payOptions: config.payOptions
  jsApiList: config.jsApiList

wxt = new WeixinTools(options)
console.dir wxt

xml_test = """
  <xml>
    <appid>wx2421b1c4370ec43b</appid>
    <appid2><![CDATA[wx2421b1c4370ec43b]]></appid2>
    <attach>支付测试</attach>
    <body>JSAPI支付测试</body>
    <mch_id>10000100</mch_id>
    <nonce_str>1add1a30ac87aa2db72f57a2375d8fec</nonce_str>
    <notify_url>http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php</notify_url>
    <openid>oUpF8uMuAJO_M2pxb1Q9zNjWeS6o</openid>
    <out_trade_no>1415659990</out_trade_no>
    <spbill_create_ip>14.23.150.211</spbill_create_ip>
    <total_fee>1</total_fee>
    <trade_type>JSAPI</trade_type>
    <sign>0CB01533B8C1EF103065174F50BCA001</sign>
  </xml>
"""

json_test =
  "appid": 'wx2421b1c4370ec43b',
  "appid2": 'wx2421b1c4370ec43b',
  "attach": '支付测试',
  "body": 'JSAPI支付测试',
  "mch_id": 10000100,
  "nonce_str": '1add1a30ac87aa2db72f57a2375d8fec',
  "notify_url": 'http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php',
  "openid": 'oUpF8uMuAJO_M2pxb1Q9zNjWeS6o',
  "out_trade_no": 1415659990,
  "spbill_create_ip": '14.23.150.211',
  "total_fee": 1,
  "trade_type": 'JSAPI',
  "sign": '0CB01533B8C1EF103065174F50BCA001'



token = null
describe "test weixin_tools", ->
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

  #describe "menus", ->
  #  it "should load menus", (done) ->
  #    return done() unless token?
  #    wxt.loadMenus token.access_token, (err, data) ->
  #      console.log err if err?
  #      console.log JSON.stringify(data)
  #      done()

  #  it "should delete menus", (done) ->
  #    return done() unless token?
  #    wxt.deleteMenus token.access_token, (err, data) ->
  #      console.log err if err?
  #      console.dir data
  #      done()

  #  it "should create menus", (done) ->
  #    return done() unless token?
  #    wxt.createMenus token.access_token, menus, (err, data) ->
  #      console.log err if err?
  #      console.dir data
  #      done()

  #describe "signature", ->
  #  it "makeSignature", (done) ->
  #    sign = wxt.makeSignature signArgs
  #    console.log "sign: #{sign}"
  #    done()

  #  it "checkSignature", (done) ->
  #    check = wxt.checkSignature signature, signArgs
  #    console.log "check: #{check}"
  #    done()

  #  it "generateConfig", (done) ->
  #    config = wxt.generateConfig url, jsapi_ticket
  #    console.dir config
  #    done()


  describe "oauth", ->
    it "generateAuthorizeURL", (done) ->
      url1 = wxt.generateAuthorizeURL "http://www.baidu.com"
      console.log url1
      url2 = wxt.generateAuthorizeURL "http://www.baidu.com", "haha"
      console.log url2
      url3 = wxt.generateAuthorizeURL "http://www.baidu.com", "haha", "snsapi_userinfo"
      console.log url3
      done()

    #it "loadAuthorzeToken", (done) ->
    #  wxt.loadAuthorzeToken "code", (err, data) ->
    #    console.log err if err?
    #    console.dir data
    #    done()

  describe "pay", ->
    it "makePaySignature", (done) ->
      args =
        appid: 'wxd930ea5d5a258f4f'
        device_info: 1000
        body:  "test"
        nonce_str: 'ibuaiVcKdpRxkhJA'
        mch_id: wxt.payOptions.mchId

      sign = wxt.makePaySignature(args)
      console.log "pay sign : #{sign}"
      done()
    it "getBrandWCPayRequestParams", (done) ->
      order =
        body: '吮指原味鸡',
        out_trade_no: 'kfc004',
        total_fee: 1,
        spbill_create_ip: "8.8.8.8",
        openid: "o-5Zdt8pmmpmYqXbTbDUpXwx_kOk",
        trade_type: 'JSAPI'
      wxt.getBrandWCPayRequestParams order, (err, body) ->
        console.error "ERROR: #{err}"
        console.dir body
        done()


  describe "test", ->

    it "xml 2 json", (done) ->
      wxt.xml2json xml_test, (err, json) ->
        console.dir json
        done()

    it "json 2 xml", (done) ->
      console.log wxt.json2xml(json_test)
      done()

