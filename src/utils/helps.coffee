###
# 公共的帮助类(这里的接口只提供本项目自身调用， 不提供对外调用)
###

debuglog = require("debug")("utils::helps")
_ = require 'underscore'


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

module.exports =
  raw:raw
