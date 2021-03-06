// Generated by CoffeeScript 1.8.0

/*
 * 自动回复消息模板
 */

(function() {
  var IMAGE_TP, NEWS_ITEM_TP, NEWS_TP, REPLY_TYPE, TEXT_TP, VIDEO_TP, VOICE_TP;

  REPLY_TYPE = {
    text: "text",
    image: "image",
    voice: "voice",
    video: "video",
    news: "news"
  };

  TEXT_TP = "<xml>\n  <ToUserName><%=toUser%></ToUserName>\n  <FromUserName><%=fromUser%></FromUserName>\n  <CreateTime><%=timestamp%></CreateTime>\n  <MsgType>text</MsgType>\n  <Content><%=content %></Content>\n</xml>";

  IMAGE_TP = "<xml>\n  <ToUserName><%=toUser%></ToUserName>\n  <FromUserName><%=fromUser%></FromUserName>\n  <CreateTime><%=timestamp%></CreateTime>\n  <MsgType>image</MsgType>\n  <Image>\n    <MediaId><%= media_id %></MediaId>\n  </Image>\n</xml>";

  VOICE_TP = "<xml>\n  <ToUserName><%=toUser%></ToUserName>\n  <FromUserName><%=fromUser%></FromUserName>\n  <CreateTime><%=timestamp%></CreateTime>\n  <MsgType>voice</MsgType>\n  <Voice>\n    <MediaId><%=media_id%><MediaId>\n  </Voice>\n</xml>";

  VIDEO_TP = "<xml>\n  <ToUserName><%=toUser%></ToUserName>\n  <FromUserName><%=fromUser%></FromUserName>\n  <CreateTime><%=timestamp%></CreateTime>\n  <MsgType>video</MsgType>\n  <Video>\n    <MediaId><%=media_id></MediaId>\n    <Title><%=title %></Title>\n    <Description><%= description %></Description>\n  </Video>\n</xml>";

  NEWS_TP = "<xml>\n  <ToUserName><%=toUser%></ToUserName>\n  <FromUserName><%=fromUser%></FromUserName>\n  <CreateTime><%=timestamp%></CreateTime>\n  <MsgType>news</MsgType>\n  <ArticleCount><%=articleCount%></ArticleCount>\n  <Articles>\n    <%=items%>\n  </Articles>\n</xml>";

  NEWS_ITEM_TP = "<item>\n  <Title><%=title%></Title>\n  <Description><%=description%></Description>\n  <PicUrl><%=picurl%></PicUrl>\n  <Url><%=url%></Url>\n</item>";

  module.exports = {
    REPLY_TYPE: REPLY_TYPE,
    TEXT_TP: TEXT_TP,
    IMAGE_TP: IMAGE_TP,
    VOICE_TP: VOICE_TP,
    VIDEO_TP: VIDEO_TP,
    NEWS_TP: NEWS_TP,
    NEWS_ITEM_TP: NEWS_ITEM_TP
  };

}).call(this);
