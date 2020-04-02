import 'dart:convert' show json;

import 'package:coolapk_flutter/network/model/util.dart';

class CollectionModel {
  final List<CollectionEntity> data;

  CollectionModel({
    this.data,
  });

  factory CollectionModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<CollectionEntity> data = jsonRes['data'] is List ? [] : null;
    if (data != null) {
      for (var item in jsonRes['data']) {
        if (item != null) {
          tryCatch(() {
            data.add(CollectionEntity.fromJson(item));
          });
        }
      }
    }

    return CollectionModel(
      data: data,
    );
  }
  Map<String, dynamic> toJson() => {
        'data': data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class CollectionEntity {
  final int id;
  final int uid;
  final String username;
  final String title;
  final String description;
  final int type;
  final int sourceId;
  final String coverPic;
  final int isOpen;
  final int recommend;
  final int itemNum;
  final int disallowCopy;
  final int disallowReply;
  final int followNum;
  final int replyNum;
  final int likeNum;
  final int shareNum;
  final int forkNum;
  final int apkNum;
  final int albumNum;
  final int feedNum;
  final int articleNum;
  final int rankScore;
  final String userTags;
  final String recentTopIds;
  final String extraConf;
  final int createdate;
  final int lastupdate;
  final int blockStatus;
  final int status;
  final String url;
  final String entityType;
  final String isOpenTitle;
  final _UserAction userAction;
  final int isBeCollected;

  CollectionEntity({
    this.id,
    this.uid,
    this.username,
    this.title,
    this.description,
    this.type,
    this.sourceId,
    this.coverPic,
    this.isOpen,
    this.recommend,
    this.itemNum,
    this.disallowCopy,
    this.disallowReply,
    this.followNum,
    this.replyNum,
    this.likeNum,
    this.shareNum,
    this.forkNum,
    this.apkNum,
    this.albumNum,
    this.feedNum,
    this.articleNum,
    this.rankScore,
    this.userTags,
    this.recentTopIds,
    this.extraConf,
    this.createdate,
    this.lastupdate,
    this.blockStatus,
    this.status,
    this.url,
    this.entityType,
    this.isOpenTitle,
    this.userAction,
    this.isBeCollected,
  });

  factory CollectionEntity.fromJson(jsonRes) => jsonRes == null
      ? null
      : CollectionEntity(
          id: convertValueByType(jsonRes['id'], int,
              stack: "CollectionEntity-id"),
          uid: convertValueByType(jsonRes['uid'], int,
              stack: "CollectionEntity-uid"),
          username: convertValueByType(jsonRes['username'], String,
              stack: "CollectionEntity-username"),
          title: convertValueByType(jsonRes['title'], String,
              stack: "CollectionEntity-title"),
          description: convertValueByType(jsonRes['description'], String,
              stack: "CollectionEntity-description"),
          type: convertValueByType(jsonRes['type'], int,
              stack: "CollectionEntity-type"),
          sourceId: convertValueByType(jsonRes['source_id'], int,
              stack: "CollectionEntity-source_id"),
          coverPic: convertValueByType(jsonRes['cover_pic'], String,
              stack: "CollectionEntity-cover_pic"),
          isOpen: convertValueByType(jsonRes['is_open'], int,
              stack: "CollectionEntity-is_open"),
          recommend: convertValueByType(jsonRes['recommend'], int,
              stack: "CollectionEntity-recommend"),
          itemNum: convertValueByType(jsonRes['item_num'], int,
              stack: "CollectionEntity-item_num"),
          disallowCopy: convertValueByType(jsonRes['disallow_copy'], int,
              stack: "CollectionEntity-disallow_copy"),
          disallowReply: convertValueByType(jsonRes['disallow_reply'], int,
              stack: "CollectionEntity-disallow_reply"),
          followNum: convertValueByType(jsonRes['follow_num'], int,
              stack: "CollectionEntity-follow_num"),
          replyNum: convertValueByType(jsonRes['reply_num'], int,
              stack: "CollectionEntity-reply_num"),
          likeNum: convertValueByType(jsonRes['like_num'], int,
              stack: "CollectionEntity-like_num"),
          shareNum: convertValueByType(jsonRes['share_num'], int,
              stack: "CollectionEntity-share_num"),
          forkNum: convertValueByType(jsonRes['fork_num'], int,
              stack: "CollectionEntity-fork_num"),
          apkNum: convertValueByType(jsonRes['apk_num'], int,
              stack: "CollectionEntity-apk_num"),
          albumNum: convertValueByType(jsonRes['album_num'], int,
              stack: "CollectionEntity-album_num"),
          feedNum: convertValueByType(jsonRes['feed_num'], int,
              stack: "CollectionEntity-feed_num"),
          articleNum: convertValueByType(jsonRes['article_num'], int,
              stack: "CollectionEntity-article_num"),
          rankScore: convertValueByType(jsonRes['rank_score'], int,
              stack: "CollectionEntity-rank_score"),
          userTags: convertValueByType(jsonRes['user_tags'], String,
              stack: "CollectionEntity-user_tags"),
          recentTopIds: convertValueByType(jsonRes['recent_top_ids'], String,
              stack: "CollectionEntity-recent_top_ids"),
          extraConf: convertValueByType(jsonRes['extra_conf'], String,
              stack: "CollectionEntity-extra_conf"),
          createdate: convertValueByType(jsonRes['createdate'], int,
              stack: "CollectionEntity-createdate"),
          lastupdate: convertValueByType(jsonRes['lastupdate'], int,
              stack: "CollectionEntity-lastupdate"),
          blockStatus: convertValueByType(jsonRes['block_status'], int,
              stack: "CollectionEntity-block_status"),
          status: convertValueByType(jsonRes['status'], int,
              stack: "CollectionEntity-status"),
          url: convertValueByType(jsonRes['url'], String,
              stack: "CollectionEntity-url"),
          entityType: convertValueByType(jsonRes['entityType'], String,
              stack: "CollectionEntity-entityType"),
          isOpenTitle: convertValueByType(jsonRes['is_open_title'], String,
              stack: "CollectionEntity-is_open_title"),
          userAction: _UserAction.fromJson(jsonRes['userAction']),
          isBeCollected: convertValueByType(jsonRes['isBeCollected'], int,
              stack: "CollectionEntity-isBeCollected"),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'username': username,
        'title': title,
        'description': description,
        'type': type,
        'source_id': sourceId,
        'cover_pic': coverPic,
        'is_open': isOpen,
        'recommend': recommend,
        'item_num': itemNum,
        'disallow_copy': disallowCopy,
        'disallow_reply': disallowReply,
        'follow_num': followNum,
        'reply_num': replyNum,
        'like_num': likeNum,
        'share_num': shareNum,
        'fork_num': forkNum,
        'apk_num': apkNum,
        'album_num': albumNum,
        'feed_num': feedNum,
        'article_num': articleNum,
        'rank_score': rankScore,
        'user_tags': userTags,
        'recent_top_ids': recentTopIds,
        'extra_conf': extraConf,
        'createdate': createdate,
        'lastupdate': lastupdate,
        'block_status': blockStatus,
        'status': status,
        'url': url,
        'entityType': entityType,
        'is_open_title': isOpenTitle,
        'userAction': userAction,
        'isBeCollected': isBeCollected,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class _UserAction {
  final int like;
  final int follow;

  _UserAction({
    this.like,
    this.follow,
  });

  factory _UserAction.fromJson(jsonRes) => jsonRes == null
      ? null
      : _UserAction(
          like: convertValueByType(jsonRes['like'], int,
              stack: "_UserAction-like"),
          follow: convertValueByType(jsonRes['follow'], int,
              stack: "_UserAction-follow"),
        );
  Map<String, dynamic> toJson() => {
        'like': like,
        'follow': follow,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
