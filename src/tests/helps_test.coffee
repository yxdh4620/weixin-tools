should = require "should"
_ = require 'underscore'

helps = require "../utils/helps"

raw_test =
  sign: "asdfasdfaiwoehklnafhan;lajsdfajfasfaf"
  name: "小Q"
  age: 12

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


describe "test utils helps", ->
  before () ->
    # before test happen
  describe "test", ->
    it "raw", (done) ->
      console.log helps.raw(raw_test)
      done()

    it "xml 2 json", (done) ->
      helps.xml2json xml_test, (err, json) ->
        console.dir json
        done()

    it "json 2 xml", (done) ->
      console.log helps.json2xml(json_test)
      done()

