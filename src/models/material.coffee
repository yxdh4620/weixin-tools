###
# 微信素材的接口, 并做相关处理
###

debuglog = require("debug")("weixin_tools")
_ = require 'underscore'
assert = require "assert"
request = require 'request'
RequestUrls =  require "../enums/request_urls"
helps = require "../utils/helps"

#获取素材列表
loadMaterialList = (access_token, type, offset=1, count=20, callback) ->
  assert _.isFunction(callback), "missing callback"
  url = "#{RequestUrls.MATERIAL_LOAD_LIST_URL}?access_token=#{access_token}"
  options =
    url:url
    json: true
    method: "POST"
    body:
      type:type
      offset:offset
      count:count
  request options, (err, res, body) =>
    return callback err if err?
    return callback new Error("invalid body") unless body?
    return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
    callback null, body
    return
  return

#获取素材总数
loadMaterialCount = (access_token, callback) ->
  assert _.isFunction(callback), "missing callback"
  url = "#{RequestUrls.MATERIAL_LOAD_COUNT_URL}?access_token=#{access_token}"
  options =
    url:url
    json: true
    method: "GET"
  request options, (err, res, body) =>
    return callback err if err?
    return callback new Error("invalid body") unless body?
    return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
    callback null, body
    return
  return

##TODO 新增图文素材
#addGraphicMaterial = (access_token, articles, callback) ->
#  assert _.isFunction(callback), "missing callback"
#  callback null, null
#  return

## 新增视频素材
#addVideoMaterial = (access_token, file, description, callback) ->
#  assert _.isFunction(callback), "missing callback"
#  url = "#{RequestUrls.MATERIAL_ADD_NEW_URL}?access_token=#{access_token}"
#  options =
#    url:url
#    json: true
#    method: "GET"
#  request options, (err, res, body) =>
#    return callback err if err?
#    return callback new Error("invalid body") unless body?
#    return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
#    callback null, body
#    return
#
#
## TODO 新增音频素材
#addVoiceMaterial= (access_token, file, callback) ->
#  assert _.isFunction(callback), "missing callback"
#  url = "#{RequestUrls.MATERIAL_ADD_NEW_URL}?access_token=#{access_token}"
#  formData =
#    media: file
#  options =
#    url:url
#    json: true
#    form: formData
#    body:
#      type: "voice"
#
#  request.post options, (err, response, body)->
#    console.dir body
#    return callback err if err?
#    return callback new Error("invalid body") unless body?
#    return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
#    callback null, body
#    return
#  return

module.exports =
  loadMaterialList:loadMaterialList
  loadMaterialCount:loadMaterialCount


