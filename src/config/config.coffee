###
# 系统配置文件
###

module.exports =
  development:
    #appid : "wxe143a2b06d92c16b"
    #secret : "08d793b678d16804e0fb820e9a4b4ed8"
    #payOptions:
    #  mchId:  10000100
    #  partnerKey: '192006250b4c09247ec02edce69f6a2d'
    #  notifyUrl: 'http://weixin.qq.cn'

    appid : "wxe91769cfb4209cc5"
    secret : "4d11b075fa41d1c833a276db102d3366"
    payOptions:
      mchId: '1230578602'
      partnerKey: 'sgf98R7589iHI9e47568Qs028767UWsw'
      notifyUrl: 'http://weixin.qq.cn'

    menus : {
      "button":[
        {
          "type":"click",
          "name":"游戏社区",
          "key":"V1001_TODAY_MUSIC"
          "sub_button":[]
        },
        {
          "type":"view",
          "name":"进入游戏",
          "url":"http://www.weixin.com"
          "sub_button":[]
        },
        {
          "name":"菜单",
          "sub_button":[
            {
              "type":"view",
              "name":"最新活动",
              "url":"http://www.weixin.com"
            },
            {
              "type":"view",
              "name":"搜索",
              "url":"http://www.soso.com"
            }
          ]
        }
      ]
    }

