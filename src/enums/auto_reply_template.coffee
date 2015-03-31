###
# 自动回复消息模板
###

REPLY_TYPE =
  text:"text"
  image:"image"
  voice:"voice"
  video:"video"

TEXT_TP = """
  <xml>
    <ToUserName><%=toUser%></ToUserName>
    <FromUserName><%=fromUser%></FromUserName>
    <CreateTime><%=timestamp%></CreateTime>
    <MsgType>text</MsgType>
    <Content><%=content %></Content>
  </xml>
"""

IMAGE_TP = """
  <xml>
    <ToUserName><%=toUser%></ToUserName>
    <FromUserName><%=fromUser%></FromUserName>
    <CreateTime><%=timestamp%></CreateTime>
    <MsgType>image</MsgType>
    <Image>
      <MediaId><%= media_id %></MediaId>
    </Image>
  </xml>
"""

VOICE_TP = """
  <xml>
    <ToUserName><%=toUser%></ToUserName>
    <FromUserName><%=fromUser%></FromUserName>
    <CreateTime><%=timestamp%></CreateTime>
    <MsgType>voice</MsgType>
    <Voice>
      <MediaId><%=media_id%><MediaId>
    </Voice>
  </xml>
"""

VIDEO_TP = """
  <xml>
    <ToUserName><%=toUser%></ToUserName>
    <FromUserName><%=fromUser%></FromUserName>
    <CreateTime><%=timestamp%></CreateTime>
    <MsgType>video</MsgType>
    <Video>
      <MediaId><%=media_id></MediaId>
      <Title><%=title %></Title>
      <Description><%= description %></Description>
    </Video>
  </xml>
"""

#MUSIC_TP = """
#  <xml>
#    <ToUserName><%=toUser%></ToUserName>
#    <FromUserName><%=fromUser%></FromUserName>
#    <CreateTime><%=timestamp%></CreateTime>
#    <MsgType>music</MsgType>
#    <Music>
#      <Title><%=title%></Title>
#      <Description><%=description%></Description>
#      <MusicUrl><%=music_url%></MusicUrl>
#      <HQMusicUrl><%=hq_music_url%></HQMusicUrl>
#      <ThumbMediaId><%=thumb_media_id%></ThumbMediaId>
#    </Music>
#  </xml>
#"""
#
#NEWS_TP = """
#  <xml>
#    <ToUserName><![CDATA[toUser]]></ToUserName>
#    <FromUserName><![CDATA[fromUser]]></FromUserName>
#    <CreateTime>12345678</CreateTime>
#    <MsgType><![CDATA[news]]></MsgType>
#    <ArticleCount>2</ArticleCount>
#    <Articles>
#      <item>
#        <Title><![CDATA[title1]]></Title>
#        <Description><![CDATA[description1]]></Description>
#        <PicUrl><![CDATA[picurl]]></PicUrl>
#        <Url><![CDATA[url]]></Url>
#      </item>
#      <item>
#        <Title><![CDATA[title]]></Title>
#        <Description><![CDATA[description]]></Description>
#        <PicUrl><![CDATA[picurl]]></PicUrl>
#        <Url><![CDATA[url]]></Url>
#      </item>
#    </Articles>
#  </xml>
#"""

module.exports =
  REPLY_TYPE:REPLY_TYPE
  TEXT_TP:TEXT_TP
  IMAGE_TP:IMAGE_TP
  VOICE_TP:VOICE_TP
  VIDEO_TP:VIDEO_TP

