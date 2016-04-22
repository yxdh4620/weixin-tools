should = require "should"

p = require "commander"
env = p.environment || 'development'
_ = require 'underscore'
config = require('../config/config')[env]

menus = config.menus

noncestr="Wm3WZYTPz0wzccnW"
jsapi_ticket="sM4AOVdWfPE4DxkXGEs8VMCPGGVi4C3VM0P37wVUCFvkVAy_90u5h9nbSlYy3-Sl-HhTdfl2fzFy1AOcHKP7qg"
timestamp="1414587457"
url="http://mp.weixin.qq.com?params=value"
signature = '0f9de62fce790f9a083d5c99e95740ceb90c27ed'
signature = '0f9de62fce790f9a083d5c99e95740ceb90c27ed'

signArgs =
  noncestr:"Wm3WZYTPz0wzccnW"
  jsapi_ticket:"sM4AOVdWfPE4DxkXGEs8VMCPGGVi4C3VM0P37wVUCFvkVAy_90u5h9nbSlYy3-Sl-HhTdfl2fzFy1AOcHKP7qg"
  timestamp:"1414587457"
  url:"http://mp.weixin.qq.com?params=value"


WeixinTools = require "../weixin_tools"
options =
  appid : config.appid
  secret : config.secret
  payOptions: config.payOptions
  jsApiList: config.jsApiList

wxt = new WeixinTools(options)
media = null
token = null
news_material_id = null

token =
  access_token: 'gkc9vT1t_SJHZulDO7LDGeioKX7a-rSB2ewxmJc_ftSXyWl5dpLZR8zUhT1FCukGEMVScgMuiOGROeUF087hCaAo71CiPiqSFCYojmG_Kcwo4b3EEuEB26TmhOO7VoY4RUTdAGAUXW'
  expires_in: 7200

describe "test weixin_tools", ->
  before () ->
    # before test happen

  #describe "token", ->
  #  it "should get access_token", (done) ->
  #    wxt.loadAccessToken (err, data) ->
  #      console.dir err if err?
  #      token = data
  #      console.dir token
  #      done()

  #  it "should get jsapi_ticket", (done) ->
  #    return done() unless token?
  #    wxt.loadJsapiTicket token.access_token, (err, data) ->
  #      console.log err if err?
  #      console.dir data
  #      done()

  describe "material", ->
    #it "add voice material", (done) ->
    #  filename = "/Users/user/Downloads/05AtKBTyih_im1oj2sw_myImage.png"
    #  wxt.uploadMedia token.access_token, 'voice', filename, (err, data) ->
    #    console.log err if err?
    #    console.dir data
    #    done()

    #it "load material count", (done) ->
    #  wxt.loadMaterialCount token.access_token, (err, data) ->
    #    console.log err if err?
    #    console.dir data
    #    done()

    #it "load material list", (done) ->
    #  wxt.loadMaterialList token.access_token, "voice", 0, 20, (err, data) ->
    #    console.log err if err?
    #    console.dir data
    #    wxt.loadMaterialList token.access_token, "image", 0, 20, (err, data) ->
    #      console.log err if err?
    #      console.dir data
    #      done()


    ##{
    ##  media_id: 'VXXwGi7THPUdu5zdHXKlaGmdHAGxEmqSj_Vx_O9r0PU',
    ##  url: 'https://mmbiz.qlogo.cn/mmbiz/jLPa62esCw1PUBJZciaX0PicKIFx1Oia7jqRoGqpDQS8tBQMQLJSEegCWLOFHIuQlPUqFhmYeRvcKHGRNywibjna5w/0?wx_fmt=png'
    ##}
    #it "add image material", (done) ->
    #  filename = "/Users/user/Downloads/05AtKBTyih_im1oj2sw_myImage.png"
    #  wxt.addImageMaterial token.access_token, filename, (err, data) ->
    #    console.log err if err?
    #    console.dir data
    #    media = data
    #    done()

    ##{ media_id: 'VXXwGi7THPUdu5zdHXKlaETN-tokQvvSOmLtzdPEOaY' }
    #it "add news material", (done) ->
    #  news = [
    #    {
    #      title: "test"
    #      thumb_media_id: media.media_id
    #      author: 'GamaLabs'
    #      digest: '只是一个简单的测试'
    #      show_cover_pic: 1
    #      content:"""
    #          拯救世界一个测试上传的数据<br/>
    #          <img class="rich_media_thumb" id="js_cover" onerror="this.parentNode.removeChild(this)"
    #          data-backsrc="#{media.url}" data-s="300,640" src="#{media.url}">
    #        """
    #      content_source_url:""
    #    },
    #    {
    #      title: "test2"
    #      thumb_media_id: media.media_id
    #      author: 'GamaLabs'
    #      digest: '只是一个简单的测试2'
    #      show_cover_pic: 1
    #      content:"""
    #          拯救世界一个测试上传的数据2<br/>
    #          <img class="rich_media_thumb" id="js_cover" onerror="this.parentNode.removeChild(this)"
    #          data-backsrc="#{media.url}" data-s="300,640" src="#{media.url}">
    #        """
    #      content_source_url:""
    #    }
    #  ]
    #  wxt.addNewsMaterial token.access_token, news, (err, data) ->
    #    console.log err if err?
    #    console.dir data
    #    news_material_id = data.media_id
    #    done()

    #it "update new material ", (done) ->
    #  news =
    #    {
    #      title: "test2_1"
    #      thumb_media_id: media.media_id
    #      author: 'GamaLabs'
    #      digest: '只是一个简单的测试2_1'
    #      show_cover_pic: 1
    #      content:"""
    #          拯救世界一个测试上传的数据2<br/>
    #          <img class="rich_media_thumb" id="js_cover" onerror="this.parentNode.removeChild(this)"
    #          data-backsrc="#{media.url}" data-s="300,640" src="#{media.url}">
    #        """
    #      content_source_url:""
    #    }
    #  wxt.updateNewsMaterial token.access_token, news, news_material_id, 1, (err, data) ->
    #    console.log err if err?
    #    console.dir data
    #    done()


    ##{
    ##  news_item:
    ##   [ { title: 'test',
    ##       author: 'wx',
    ##       digest: '只是一个简单的测试',
    ##       content: '拯救世界一个测试上传的数据<br  />\n<img class="rich_media_thumb" data-backsrc="https://mmbiz.qlogo.cn/mmbiz/jLPa62esCw1PUBJZciaX0PicKIFx1Oia7jqRoGqpDQS8tBQMQLJSEegCWLOFHIuQlPUqFhmYeRvcKHGRNywibjna5w/0?wx_fmt=png" data-s="300,640" src="https://mmbiz.qlogo.cn/mmbiz/jLPa62esCw1PUBJZciaX0PicKIFx1Oia7jqRoGqpDQS8tBQMQLJSEegCWLOFHIuQlPUqFhmYeRvcKHGRNywibjna5w/0?wx_fmt=png"  />',
    ##       content_source_url: '',
    ##       thumb_media_id: 'VXXwGi7THPUdu5zdHXKlaGmdHAGxEmqSj_Vx_O9r0PU',
    ##       show_cover_pic: 1,
    ##       url: 'http://mp.weixin.qq.com/s?__biz=MzA3NjM2NDAyNw==&mid=500226005&idx=1&sn=0b437dca7e6b285ad9d3aaeb689e99d3#rd',
    ##       thumb_url: 'http://mmbiz.qpic.cn/mmbiz/jLPa62esCw1PUBJZciaX0PicKIFx1Oia7jqZ5rwt6W3Nzx3E26EOiaYQ9A1xwk02DO7eguKmlS3ibiam7uWfCXHasFIQ/0?wx_fmt=jpeg'
    ##   } ],
    ##  create_time: 1461297939,
    ##  update_time: 1461297939
    ##}
    #it "get material by id", (done) ->
    #  wxt.getMaterialById token.access_token, news_material_id, (err, data) ->
    #    console.log err if err?
    #    console.dir data
    #    done()

    it "delete material", (done) ->
      news_material_id = 'VXXwGi7THPUdu5zdHXKlaHmbf-rz15UweMgvmNX1y64'
      wxt.deleteMaterial token.access_token, news_material_id, (err, data) ->
        console.log err if err?
        console.dir data
        done()

