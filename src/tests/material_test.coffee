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

  describe "token", ->
    it "should get access_token", (done) ->
      wxt.loadAccessToken (err, data) ->
        console.dir err if err?
        token = data
        console.dir token
        done()

    it "should get jsapi_ticket", (done) ->
      return done() unless token?
      wxt.loadJsapiTicket token.access_token, (err, data) ->
        console.log err if err?
        console.dir data
        done()

  describe "material", ->
    #token =
    #  access_token: "nfbIHl9p_TyQFJ6KQvF3YTrjIG1QjB14KhoRlmQ8fjCwfHHjDV7uJWL7KB3PZR4dW95QBupypwNP_tCGuuX8oEdxVNyiuxd-whpJZ2hN_dE"
    #  ticket: "sM4AOVdWfPE4DxkXGEs8VFj5UEhJXZMbuiU3wOuFKqHuT5pm3O9Y1kLceFR_XIIdtcVN9YNpVpDvUBUq7nSLkA"
    #it "add voice material", (done) ->
    #  filename = "/Users/user/Downloads/2dLwJrA.mp3"
    #  wxt.addVoiceMaterial token.access_token, filename, (err, data) ->
    #    console.log err if err?
    #    console.dir data
    #    done()

    it "load material count", (done) ->
      wxt.loadMaterialCount token.access_token, (err, data) ->
        console.log err if err?
        console.dir data
        done()

    it "load material list", (done) ->
      wxt.loadMaterialList token.access_token, "voice", 0, 20, (err, data) ->
        console.log err if err?
        console.dir data
        wxt.loadMaterialList token.access_token, "image", 0, 20, (err, data) ->
          console.log err if err?
          console.dir data
          done()

    it "get material by id", (done) ->
      wxt.getMaterialById token.access_token, '', (err, data) ->
        console.log err if err?
        console.dir data
        done()

