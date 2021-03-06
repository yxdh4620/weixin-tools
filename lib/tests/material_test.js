// Generated by CoffeeScript 1.8.0
(function() {
  var WeixinTools, config, env, filepath, fs, jsapi_ticket, media, menus, news_material_id, noncestr, options, p, should, signArgs, signature, timestamp, token, url, wxt, _;

  should = require("should");

  p = require("commander");

  env = p.environment || 'development';

  _ = require('underscore');

  config = require('../config/config')[env];

  fs = require('fs');

  menus = config.menus;

  noncestr = "Wm3WZYTPz0wzccnW";

  jsapi_ticket = "sM4AOVdWfPE4DxkXGEs8VMCPGGVi4C3VM0P37wVUCFvkVAy_90u5h9nbSlYy3-Sl-HhTdfl2fzFy1AOcHKP7qg";

  timestamp = "1414587457";

  url = "http://mp.weixin.qq.com?params=value";

  signature = '0f9de62fce790f9a083d5c99e95740ceb90c27ed';

  signature = '0f9de62fce790f9a083d5c99e95740ceb90c27ed';

  signArgs = {
    noncestr: "Wm3WZYTPz0wzccnW",
    jsapi_ticket: "sM4AOVdWfPE4DxkXGEs8VMCPGGVi4C3VM0P37wVUCFvkVAy_90u5h9nbSlYy3-Sl-HhTdfl2fzFy1AOcHKP7qg",
    timestamp: "1414587457",
    url: "http://mp.weixin.qq.com?params=value"
  };

  WeixinTools = require("../weixin_tools");

  options = {
    appid: config.appid,
    secret: config.secret,
    payOptions: config.payOptions,
    jsApiList: config.jsApiList
  };

  wxt = new WeixinTools(options);

  media = null;

  token = null;

  news_material_id = null;

  token = {
    access_token: '4JcGgbQsdMVLJU4WGf1P1dGi7sqYKqOxxjcPcOpxPCDUJpgA56eSEy74aJEQ0fd6w-0PY3RrHjJDaF-zzWJ-8zTwD20vUt-ZqRWYWOTTgApuULb-YAxtrFAq1iN2JAhUPLQiAAALHM',
    expires_in: 7200
  };

  filepath = "/Users/yuanxiangdong/workspaces/my-tools/weixin-tools/tests/test.jpg";

  describe("test weixin_tools", function() {
    before(function() {});
    return describe("material", function() {
      it("add voice material", function(done) {
        var filename;
        filename = "/Users/yuanxiangdong/Downloads/83ccaf5d5a3e26eb7ef87eafa6995473.jpg";
        return wxt.uploadMedia(token.access_token, 'image', filename, function(err, data) {
          if (err != null) {
            console.log(err);
            return done();
          }
          console.dir(data);
          media = data.media_id;
          return done();
        });
      });
      return it("get image material", function(done) {
        return wxt.getMediaById(token.access_token, media, function(err, body) {
          if (err != null) {
            console.log("dddd: " + err);
            return done();
          }
          console.dir(body);
          fs.writeFileSync(filepath, body);
          return done();
        });
      });
    });
  });

}).call(this);
