should = require "should"

p = require "commander"
env = p.environment || 'development'
_ = require 'underscore'
config = require('../config/config')[env]

#menus = config.menus

WeixinTools = require "../weixin_tools"

options =
  appid : config.appid
  secret : config.secret
  payOptions: config.payOptions
  jsApiList: config.jsApiList

wxt = new WeixinTools(options)
console.dir wxt
openid = ""
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

  describe "oauth", ->
    #it "generateAuthorizeURL", (done) ->
    #  url1 = wxt.generateAuthorizeURL "http://www.baidu.com"
    #  console.log url1
    #  url2 = wxt.generateAuthorizeURL "http://www.baidu.com", "haha"
    #  console.log url2
    #  url3 = wxt.generateAuthorizeURL "http://www.baidu.com", "haha", "snsapi_userinfo"
    #  console.log url3
    #  done()

    #it "loadAuthorzeToken", (done) ->
    #  wxt.loadAuthorzeToken "code", (err, data) ->
    #    console.log err if err?
    #    console.dir data
    #    done()

    it "loadUserInfoUnion test", (done) ->
      wxt.loadUserInfoUnion openid, token.access_token, 'zh_CN', (err, data) ->
        console.log err if err?
        console.dir data
        done()

