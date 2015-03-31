###
# 微信素材的接口, 并做相关处理
###

debuglog = require("debug")("weixin_tools")
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

#增加临时素材(有效时间3天)
uploadMedia = (access_token, type, filepath, callback) ->
  assert _.isFunction(callback), "missing callback"
  url = "#{RequestUrls.MEDIA_UPLOAD_URL}?access_token=#{access_token}&type=#{type}"
#  formData =
#    media: fs.createReadStream(filepath)
#  options =
#    url:url
#    json: true
#    media:filepath
#    formData:formData
#  console.dir options
#  request.post options, (err, response, body)->
#    console.dir body
#    return callback err if err?
#    return callback new Error("invalid body") unless body?
#    return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
#    callback null, body
#    return
#  return
# req = request.post url, (err, res, body) ->
#    return callback err if err?
#    unless res.statusCode is 200
#      return callback new Error("statusCode:#{res.statusCode}")
#    #console.dir body
#    console.dir body
#    return callback err if err?
#    return callback new Error("invalid body") unless body?
#    return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
#    callback null, body
#    return
#  form = req.form()
#  form.append("media", filepath)
#  console.dir form
#  console.dir req
  #res = request.post url, (err, httpResponse, body) ->
  #  console.dir body
  #  return callback err if err?
  #  return callback new Error("invalid body") unless body?
  #  return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
  #  callback null, body
  #  return
  #form = res.form()
  #console.dir form
  #form.append('media', fs.createReadStream(file))
  ##form.append('media', file)
  #return
  #fs.stat filepath, (err, stat) ->
  #  return callback(err) if err?
  #  form = formstream()
  #  form.file('media', filepath, path.basename(filepath), stat.size)
  #  url = "#{RequestUrls.MEDIA_UPLOAD_URL}?access_token=#{access_token}&type=#{type}"
  #  options =
  #    url:url
  #    dataType: 'json'
  #    type: 'POST'
  #    timeout: 60000, #60秒超时
  #    headers: form.headers()
  #    stream: form
  #  console.dir options
  #  request options, (err, response, body) ->
  #    console.dir body
  #    return callback err if err?
  #    return callback new Error("invalid body") unless body?
  #    return callback new Error("#{body.errcode}:#{body.errmsg}") unless not body.errcode? or (body.errcode == 0 and body.errmsg == 'ok')
  #    callback null, body
  #    return
  #  return
  #return
  url = "#{RequestUrls.MEDIA_UPLOAD_URL}?access_token=#{access_token}&type=#{type}"
  child_process.exex "curl -F media=@#{filepath} #{url}", (err, stdout, stderr) ->
    return callback err if err?
    return callback null, stdout

module.exports =
  loadMaterialList:loadMaterialList
  loadMaterialCount:loadMaterialCount
  getMaterialById:getMaterialById
  uploadMedia:uploadMedia

