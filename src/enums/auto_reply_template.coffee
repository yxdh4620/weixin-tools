###
# 自动回复消息模板
###

REPLY_TYPE =
  text:"text"
  image:"image"
  voice:"voice"
  video:"video"
  news:"news"

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
NEWS_TP = """
  <xml>
    <ToUserName><%=toUser%></ToUserName>
    <FromUserName><%=fromUser%></FromUserName>
    <CreateTime><%=timestamp%></CreateTime>
    <MsgType>news</MsgType>
    <ArticleCount><%=articleCount%></ArticleCount>
    <Articles>
      <%=items%>
    </Articles>
  </xml>
"""

NEWS_ITEM_TP = """
  <item>
    <Title><%=title%></Title>
    <Description><%=description%></Description>
    <PicUrl><%=picurl%></PicUrl>
    <Url><%=url%></Url>
  </item>
"""

module.exports =
  REPLY_TYPE:REPLY_TYPE
  TEXT_TP:TEXT_TP
  IMAGE_TP:IMAGE_TP
  VOICE_TP:VOICE_TP
  VIDEO_TP:VIDEO_TP
  NEWS_TP:NEWS_TP
  NEWS_ITEM_TP:NEWS_ITEM_TP
