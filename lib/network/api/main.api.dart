import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/network/model/collection.model.dart';
import 'package:coolapk_flutter/network/model/main_init.model.dart';
import 'package:coolapk_flutter/network/model/reply_data_list.model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum SearchType {
  feed,
  all,
  user,
  feedTopic, // 话题
  ask, // 问答
  dyhMix, // 看看号
  // album, // 应用集
}

class MainApi {
  static Future search({
    SearchType searchType = SearchType.feed,
    @required String searchValue,
    int page,
    int showAnonymous = -1,
    int lastItem,
  }) async {
    return (await Network.apiDio.get(
      "/search",
      queryParameters: {
        "page": page,
        "showAnonymous": showAnonymous,
        "searchValue": searchValue,
        "type": searchType.toString().split(".")[1],
      }
        ..addAll(lastItem != null ? {"lastItem": lastItem} : {})
        ..addAll(searchType == SearchType.feed ? {"sort": "default"} : {})
        ..addAll(searchType == SearchType.ask || searchType == SearchType.feed
            ? {"feedType": "all"}
            : {}),
    ))
        .data;
  }

  static Future<MainInitModel> getInitConfig() async {
    return MainInitModel.fromJson(
      (await Network.apiDio.get("/main/init")).data,
    );
  }

  // // 上传图片 暂时无解 做不了 因为上传图片走的阿里云oss，要验证的，暂且没有算法
  // static Future uploadImage(XFile imageFile) async {
  //   final resp = Network.apiDio.post("/upload/ossUploadPrepare", data: FormData.fromMap({
  //     "uploadBucket": "image",
  //     "uploadDir": "feed",
  //     "is_anonymous": 0,
  //     "uploadFileList": [
  //       {
  //         "name": "xxx.jpeg",
  //         "resolution": "123x341",
  //         "md5": "md5",
  //       }
  //     ],
  //   }));
  // }

  // 获取产品信息
  // 返回的内容 主要字段
  /*
   * alias_title
   * allow_rating
   * config_num // 不同的手机规格
   * configRows
   *  -> cpu
   *  -> id
   *  -> fingerpoint_type=前置指纹识别
   *  -> phone_material=陶瓷机身+金属中框
   *  -> ram=6GB
   *  -> screen_material=
   *  -> price=2599 // 多少钱
   *  -> title=小米6（陶瓷尊享版） // 主要显示内容
   * coverArr
   *  -> ["图片地址@123x321.jpg"]
   * description
   * entityId
   * entityType
   * feed_answer_num
   * feed_article_num=89
   * feed_comment_num=49398
   * feed_review_num=0
   * feed_trade_num=915
   * feed_video_num=27
   * follow_num=24555
   * hot_num=578472
   * hot_num_txt=57.8w // 热度
   * is_recommend=1 // 是否推荐
   * link_tag=小米6
   * logo= // logo地址
   * price_currency=￥ // 单位类型
   * price_max=2409
   * price_min=2109
   * rating_average_score=9.3 // 这个是分数 平均分？
   * rating_average_score_1=9.3
   *  ...>
   * rating_average_score_10=xx
   * rating_total_num=1639 // 上面是分数分布 这个是总分数
   * recent_follow_list // 最近关注清单
   *  -> entityType=user
   *  -> uid=863840
   *  -> userAvatar=http://avatar.coolapk.com/data/000/86/38/40_avatar_middle.jpg?1577117704
   *  -> userInfo
   *    -> xxx
   * status=1 //
   * tabList // tab 划重点 获取评论啥啥啥的链接来自这里
   * tagArr // [玻璃机身] 啥的
   * title // 机子名称
   * userAction // 登录才有
   * star_[1-5]_count=123123 // 点评 各个分段的人数
   * star_total_count // 点评总人数
   * star_average_score=9.3
   */
  static Future<dynamic> getProductDetail(final String id) async {
    final resp = await Network.apiDio.get("/product/detail", queryParameters: {
      "id": id,
    });
    return resp.data["data"];
  }

  // 获取设备某个规格的详细数据
  static Future<dynamic> getProductConfig() async {}

  static Future<dynamic> getFeedDetail(final String feedId) async {
    final resp = await Network.apiDio
        .get("/feed/detail", queryParameters: {"id": feedId});
    return resp.data["data"];
  }

  static Future<dynamic> setFollowUser(
      final dynamic uid, final bool follow) async {
    final url = follow ? "/user/follow" : "/user/unfollow";
    final resp = await Network.apiDio.get(url, queryParameters: {"uid": uid});
    return resp.data;
  }

  static Future<CollectionModel> getCollections({
    final dynamic uid,
    final dynamic targetId,
    final CollectionType type = CollectionType.feed,
    final int page = 1,
  }) async {
    // /v6/collection/list?uid=&id=17752651&type=feed&showDefault=1&page=1
    final resp = await Network.apiDio.get("/collection/list", queryParameters: {
      "uid": uid,
      "id": targetId,
      "type": type.toString().split(".")[1],
      "showDefault": 1,
      "page": page,
    });
    return CollectionModel.fromJson(resp.data);
  }

  static Future<dynamic> addCollectionItem(dynamic uid, List<int> ids,
      {List<int> cancelIds, CollectionType type = CollectionType.feed}) async {
    // /v6/collection/addItem POST
    final resp = await Network.apiDio.post("/collection/addItem",
        data: FormData.fromMap({
          "id": ids.toString().replaceAll(RegExp(r'\[|\]'), ""),
          "targetId": uid,
          "cancelId":
              (cancelIds ?? []).toString().replaceAll(RegExp(r'\[|\]'), ""),
          "type": type.toString().split(".")[1],
        }));
    return resp.data;
  }

  static Future<ReplyDataListModel> getFeedReplyList(
    dynamic feedId, {
    final int page = 1,
    final int lastItem,
    final int firstItem,
    final FeedType feedType = FeedType.feed,
    final int blockStatus = 0,
    final int fromFeedAuthor = 0, // 只看楼主
    final int discussMode = 1,
    final ReplyDataListType sortType = ReplyDataListType.lastupdate_desc,
  }) async {
    final param = {
      "id": feedId,
      "listType": sortType == null ? "" : sortType.toString().split(".")[1],
      "page": page,
      "discussMode": discussMode,
      "feedType": feedType.toString().split(".")[1],
      "blockStatus": blockStatus,
      "fromFeedAuthor": fromFeedAuthor,
    };
    if (lastItem != null) {
      param.addAll({
        "lastItem": lastItem,
      });
    }
    if (firstItem != null) {
      param.addAll({
        "firstItem": firstItem,
      });
    }
    final resp =
        await Network.apiDio.get("/feed/replyList", queryParameters: param);
    return ReplyDataListModel.fromJson(resp.data);
  }

  static Future<dynamic> reply(final dynamic targetId, final String message,
      {final ReplyType type = ReplyType.reply}) async {
    final resp = await Network.apiDio.post(
      "/feed/reply",
      queryParameters: {
        "id": targetId,
        "type": type.toString().split(".")[1],
      },
      data: FormData.fromMap({
        "message": message,
      }),
    );
    return resp.data;
  }
}

enum ReplyType {
  feed,
  reply, // 回复某回复
}

enum FeedType {
  feed,
  feed_reply, // 动态内的回复
}

enum ReplyDataListType {
  lastupdate_desc, // 最近回复
  dateline_desc, // 时间排序
  popular, // 热度排序
}

enum CollectionType {
  feed,
}
