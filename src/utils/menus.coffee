###
# 微信自定义菜单的接口工具类
###

debuglog = require("debug")("weixin_tools")
assert = require "assert"
request = require 'request'

RequestUrls =  require "../enums/request_urls"
# 获取自定义菜单JSON的接口
loadMenus = (access_token, callback) ->
  url = "#{RequestUrls.GET_MENUS_URL}?access_token=#{access_token}"
  options =
    url: url
    json: true
    method:"GET"
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode#{body.errcode} #{body.errmsg}") if body.errcode? and parseInt(body.errcode) != 0
    return callback null, body
  return

# 删除自定义菜单
deleteMenus = (access_token, callback) ->
  url = "#{RequestUrls.DELETE_MENUS_URL}?access_token=#{access_token}"
  options =
    url: url
    json: true
    method:"GET"
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode#{body.errcode} #{body.errmsg}") if body.errcode? and parseInt(body.errcode) != 0
    return callback null, body
  return

# 创建自定义菜单的接口
createMenus = (access_token, menus, callback) ->
  url = "#{RequestUrls.POST_MENUS_URL}?access_token=#{access_token}"
  options =
    url: url
    json: true
    method:"POST"
    body: menus
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode#{body.errcode} #{body.errmsg}") if body.errcode? and parseInt(body.errcode) != 0
    return callback null, body
  return


module.exports =
  loadMenus: loadMenus
  deleteMenus:deleteMenus
  createMenus:createMenus





