import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/network/model/feed_create.model.dart';
import 'package:coolapk_flutter/network/model/html_article.model.dart';
import 'package:coolapk_flutter/util/xfile.dart';
import 'package:dio/dio.dart';

enum CreateFeedType { feed }

class MainApi {
  /**
   * 创建图文动态
   */
  static Future<dynamic> createHtmlArticleFeed({
    List<HtmlArticleFragment> message,
    String title,
    XFile cover,
  }) {
    // TODO:
    // cover需要上传
    var coverUrl;
    final resp = Network.apiDio.post("/feed/createFeed",
        data: FormData.fromMap(FeedCreateModel(
          message: HtmlArticleModel(data: message).toJson().toString(),
          type: CreateFeedType.feed.toString().split(".")[1],
          isHtmlArticle: 1,
          pic: "",
          status: 1,
          location: "",
          longLocation: "",
          latitude: 0.0,
          longitude: 0.0,
          mediaUrl: "",
          mediaType: 0,
          mediaPic: "",
          messageTitle: title,
          messageBrief: "",
          extraTitle: "",
          extraUrl: "",
          extraKey: "",
          extraPic: "",
          extraInfo: "",
          messageCover: coverUrl,
          disallowRepost: 0,
          isAnonymous: 0,
          isEditindyh: 0,
          forwardid: "",
          fid: "",
          dyhId: "",
          targetType: "",
          productId: "",
          province: "",
          cityCode: "",
          targetId: "",
          locationCity: "",
          locationCountry: "",
          disallowReply: 0,
          voteScore: 0,
          replyWithForward: 0,
          mediaInfo: "",
          insertProductMedia: 0,
        ).toJson()));
    return resp;
  }
}
