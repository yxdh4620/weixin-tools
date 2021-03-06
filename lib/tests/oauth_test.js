// Generated by CoffeeScript 1.8.0
(function() {
  var WeixinTools, config, env, openid, options, p, should, token, wxt, _;

  should = require("should");

  p = require("commander");

  env = p.environment || 'development';

  _ = require('underscore');

  config = require('../config/config')[env];

  WeixinTools = require("../weixin_tools");

  options = {
    appid: config.appid,
    secret: config.secret,
    payOptions: config.payOptions,
    jsApiList: config.jsApiList
  };

  wxt = new WeixinTools(options);

  console.dir(wxt);

  openid = "o-5Zdt8pmmpmYqXbTbDUpXwx_kOk";

  token = null;

  describe("test weixin_tools", function() {
    before(function() {});
    describe("token", function() {
      it("should get access_token", function(done) {
        return wxt.loadAccessToken(function(err, data) {
          if (err != null) {
            console.dir(err);
          }
          token = data;
          console.dir(token);
          return done();
        });
      });
      return it("should get jsapi_ticket", function(done) {
        if (token == null) {
          return done();
        }
        return wxt.loadJsapiTicket(token.access_token, function(err, data) {
          if (err != null) {
            console.log(err);
          }
          console.dir(data);
          return done();
        });
      });
    });
    return describe("oauth", function() {
      return it("loadUserInfoUnion test", function(done) {
        return wxt.loadUserInfoUnion(openid, token.access_token, 'zh_CN', function(err, data) {
          if (err != null) {
            console.log(err);
          }
          console.dir(data);
          return done();
        });
      });
    });
  });

}).call(this);
