###
# 微信素材的接口, 并做相关处理
###

debuglog = require("debug")("weixin_tools::material")
_ = require 'underscore'
assert = require "assert"
request = require 'request'
RequestUrls =  require "../enums/request_urls"
helps = require "../utils/helps"
path = require "path"
fs = require "fs"
child_process = require 'child_process'
#formstream = require "formstream"

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

getMaterialById = (access_token, id, callback) ->
  assert _.isFunction(callback), "missing callback"
  url = "#{RequestUrls.MATERIAL_GET_BY_ID_URL}?access_token=#{access_token}"
  options =
    url:url
    json: true
    method: "POST"
    body:
      media_id: id
  request options, (err, res, body) =>
    return callback err if err?
    return callback new Error("invalid body") unless body?
    return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
    callback null, body
    return
  return


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
#  url = "#{RequestUrls.MATERIAL_ADD_MATERIAL_URL}?access_token=#{access_token}"
#  options =
#    url:url
#    json: true
#    body:
#      type: "voice"
#      media: fs.createReadStream(file)
#  console.dir options
#  request.post options, (err, response, body)->
#    console.dir body
#    return callback err if err?
#    return callback new Error("invalid body") unless body?
#    return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
#    callback null, body
#    return
#  return

addMaterial = (access_token, type, filepath, callback) ->
  assert _.isFunction(callback), "missing callback"
  url = "#{RequestUrls.MATERIAL_ADD_MATERIAL_URL}?access_token=#{access_token}&type=#{type}"
  cmd = "curl -F media=@#{filepath} \"#{url}\""
  child_process.exec cmd, (err, stdout, stderr) ->
    return callback err if err?
    try
      body = JSON.parse(stdout)
      return callback new Error("invalid body") unless body?
      return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
      callback null, body
      return
    catch err
      return callback new Error("invalid body")
    return
  return
  #request.post options, (err, response, body) ->
  #  console.dir body
  #  return callback err if err?
  #  return callback new Error("invalid body") unless body?
  #  return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
  #  callback null, body
  #  return
  #return

# 增加图片永久素材
addImageMaterial = (access_token, file, callback) ->
  assert _.isFunction(callback), "missing callback"
  addMaterial access_token, 'image', file, callback
  return

# 增加图文永久素材
addNewsMaterial = (access_token, news, callback) ->
  assert _.isFunction(callback), "missing callback"
  url = "#{RequestUrls.MATERIAL_ADD_NEW_URL}?access_token=#{access_token}"
  options =
    url: url
    json: true
    body:
      articles: news
  request.post options, (err, response, body) ->
    console.dir body
    return callback err if err?
    return callback new Error("invalid body") unless body?
    return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
    callback null, body
    return
  return

updateNewsMaterial = (access_token, news, media_id, index, callback) ->
  if _.isFunction(index)
    callback = index
    index = 0
  assert _.isFunction(callback), "missing callback"
  url = "#{RequestUrls.MATERIAL_UPDATE_NEWS_URL}?access_token=#{access_token}"
  options =
    url: url
    json: true
    body:
      media_id: media_id
      index: index
      articles: news
  request.post options, (err, response, body) ->
    console.dir body
    return callback err if err?
    return callback new Error("invalid body") unless body?
    return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
    callback null, body
    return
  return

deleteMaterial = (access_token, media_id, callback) ->
  assert _.isFunction(callback), "missing callback"
  url = "#{RequestUrls.MATERIAL_DELETE_URL}?access_token=#{access_token}"
  options =
    url: url
    json: true
    body:
      media_id: media_id
  request.post options, (err, response, body) ->
    console.dir body
    return callback err if err?
    return callback new Error("invalid body") unless body?
    return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
    callback null, body
    return
  return

#增加临时素材(有效时间3天)
uploadMedia = (access_token, type, filepath, callback) ->
  assert _.isFunction(callback), "missing callback"
  url = "#{RequestUrls.MEDIA_UPLOAD_URL}?access_token=#{access_token}&type=#{type}"
  child_process.exec "curl -F media=@#{filepath} \"#{url}\"", (err, stdout, stderr) ->
    return callback err if err?
    try
      body = JSON.parse(stdout)
      return callback new Error("invalid body") unless body?
      return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
      callback null, body
      return
    catch err
      return callback new Error("invalid body")

module.exports =
  loadMaterialList:loadMaterialList
  loadMaterialCount:loadMaterialCount
  getMaterialById:getMaterialById
  addMaterial: addMaterial
  addImageMaterial: addImageMaterial
  addNewsMaterial: addNewsMaterial
  updateNewsMaterial: updateNewsMaterial
  deleteMaterial: deleteMaterial
  uploadMedia:uploadMedia

