import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/network/model/feed_create.model.dart';
import 'package:coolapk_flutter/network/model/html_article.model.dart';
import 'package:coolapk_flutter/util/xfile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum CreateFeedType { feed }

class FeedApi {
  static Future<dynamic> deleteFeed({
    @required feedId,
  }) async {
    final resp =
        await Network.apiDio.post("/feed/deleteFeed", queryParameters: {
      "id": feedId,
      "notNotify": 0,
    });
    return resp.data;
  }

  static Future<dynamic> createFeed({
    @required String message,
    CancelToken cancelToken,
  }) async {
    final resp = await Network.apiDio.post("/feed/createFeed",
        data: FormData.fromMap(FeedCreateModel(
          message: message,
          type: CreateFeedType.feed.toString().split(".")[1],
          isHtmlArticle: 0,
          pic: "",
          status: 1,
          location: "",
          longLocation: "",
          latitude: 0.0,
          longitude: 0.0,
          mediaUrl: "",
          mediaType: 0,
          mediaPic: "",
          messageTitle: "",
          messageBrief: "",
          extraTitle: "",
          extraUrl: "",
          extraKey: "",
          extraPic: "",
          extraInfo: "",
          messageCover: "",
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
        ).toJson()),
        cancelToken: cancelToken);
    return resp.data;
  }

  /**
   * 创建图文动态 暂时做不了 要上传图片 而上传图片又有另外一个问题了
   */
  static Future<dynamic> createHtmlArticleFeed({
    List<HtmlArticleFragment> message,
    String title,
    XFile cover,
  }) async {
    // TODO:
    // cover需要上传
    var coverUrl;

    final emm = HtmlArticleModel(data: message)
        .toJson()
        .toString()
        .replaceAll(RegExp(r'^{data: '), "");
    final resp = await Network.apiDio.post(
      "/feed/createFeed",
      data: FormData.fromMap(
        FeedCreateModel(
          message: emm.substring(0, emm.length - 1),
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
        ).toJson(),
      ),
    );

    return resp.data;
  }
}
