// Generated by CoffeeScript 1.8.0

/*
 * 微信接收消息（事件）的接口, 并做相关处理
 */

(function() {
  var RequestUrls, assert, debuglog, helps, receiveMessage, request, _;

  debuglog = require("debug")("weixin_tools::receive");

  _ = require('underscore');

  assert = require("assert");

  request = require('request');

  RequestUrls = require("../enums/request_urls");

  helps = require("../utils/helps");

  receiveMessage = function(msgXml, callback) {
    assert(_.isFunction(callback), "missing callback");
    return helps.xml2json(msgXml, (function(_this) {
      return function(err, data) {
        return callback(err, data);
      };
    })(this));
  };

  module.exports = {
    receiveMessage: receiveMessage
  };

}).call(this);
