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

token = null
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

  describe "material", ->
    token =
      access_token: "BvCgnDN_lzBtr0Spm-stnJYS0CPaYVBjECkREYFOnZHCjK6PgnK8NwX6mK2Ic5jGp2z8XnDyAQcy3ADSHU81oM_dj0lOSChONscON2pADSw"
      ticket: "sM4AOVdWfPE4DxkXGEs8VFXzXlm0blQsLfNUpWD-79yUTCUtJS03SH4eyqbLymEuaHneFWVZhjC59Clc4Hn2XA"
    it "add voice material", (done) ->
      filename = "/Users/user/Downloads/2dLwJrA.mp3"
      wxt.uploadMedia token.access_token, 'voice', filename, (err, data) ->
        console.log err if err?
        console.dir data
        done()
    #it "load material count", (done) ->
    #  wxt.loadMaterialCount token.access_token, (err, data) ->
    #    console.log err if err?
    #    console.dir data
    #    done()

    #it "load material list", (done) ->
    #  wxt.loadMaterialList token.access_token, "voice", 0, 20, (err, data) ->
    #    console.log err if err?
    #    console.dir data
    #    wxt.loadMaterialList token.access_token, "image", 0, 20, (err, data) ->
    #      console.log err if err?
    #      console.dir data
    #      done()

    #it "get material by id", (done) ->
    #  wxt.getMaterialById token.access_token, '', (err, data) ->
    #    console.log err if err?
    #    console.dir data
    #    done()

