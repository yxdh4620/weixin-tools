should = require "should"

p = require "commander"
env = p.environment || 'development'
_ = require 'underscore'
config = require('../config/config')[env]

menus = config.menus

WeixinTools = require "../weixin_tools"
options =
  appid : config.appid
  secret : config.secret
  payOptions: config.payOptions
  jsApiList: config.jsApiList

wxt = new WeixinTools(options)
console.dir wxt

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

  describe "menus", ->
    it "should load menus", (done) ->
      return done() unless token?
      wxt.loadMenus token.access_token, (err, data) ->
        console.log err if err?
        console.log JSON.stringify(data)
        done()

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

