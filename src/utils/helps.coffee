###
# 公共的帮助类(这里的接口只提供本项目自身调用， 不提供对外调用)
###

debuglog = require("debug")("utils::helps")
_ = require 'underscore'
xmlParser = require('xml2json')

#将传人的参数转为一个get 请求参数的字符串
raw = (args)  ->
  keys = _.keys(args)
  keys = keys.sort()
  newArgs = {}
  keys.forEach (key) ->
    newArgs[key.toLowerCase()] = args[key]
  str = ""
  for k,v of newArgs
    str += "&"+k+"="+v
  return str.substr(1)

xml2json = (xml) ->
  str = xmlParser.toJson(xml)
  return unless str
  try
    console.log str
    console.log xmlParser.toXml(str)
    return JSON.parse(str).xml
  catch err
    debuglog "[ERROR] error: #{err}"
  return null

json2xml = (json) ->
  return xmlParser.toXml(json)

module.exports =
  raw:raw
  xml2json:xml2json
  json2xml:json2xml


