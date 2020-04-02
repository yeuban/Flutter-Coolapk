import 'dart:convert' show json;

import 'package:coolapk_flutter/network/model/util.dart';

class ReplyDataListModel {
  final List<ReplyDataEntity> data;

  ReplyDataListModel({
    this.data,
  });

  factory ReplyDataListModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<ReplyDataEntity> data = jsonRes['data'] is List ? [] : null;
    if (data != null) {
      for (var item in jsonRes['data']) {
        if (item != null) {
          tryCatch(() {
            data.add(ReplyDataEntity.fromJson(item));
          });
        }
      }
    }

    return ReplyDataListModel(
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

class ReplyDataEntity {
  final int id;
  final int ftype;
  final int fid;
  final int rid;
  final int rrid;
  final int uid;
  final String username;
  final int ruid;
  final String rusername;
  final String pic;
  final String message;
  final int replynum;
  final int likenum;
  final int burynum;
  final int reportnum;
  final int rankScore;
  final int dateline;
  final int lastupdate;
  final int isFolded;
  final int status;
  final int messageStatus;
  final int blockStatus;
  final String recentReplyIds;
  final int feedUid;
  final String fetchType;
  final int entityId;
  final String avatarFetchType;
  final String userAvatar;
  final String entityTemplate;
  final String entityType;
  final String infoHtml;
  final int isFeedAuthor;
  final _UserAction userAction;
  final _UserInfo userInfo;
  final List<InReplyRowEntity> replyRows;
  final int replyRowsCount;
  final int replyRowsMore;

  ReplyDataEntity({
    this.id,
    this.ftype,
    this.fid,
    this.rid,
    this.rrid,
    this.uid,
    this.username,
    this.ruid,
    this.rusername,
    this.pic,
    this.message,
    this.replynum,
    this.likenum,
    this.burynum,
    this.reportnum,
    this.rankScore,
    this.dateline,
    this.lastupdate,
    this.isFolded,
    this.status,
    this.messageStatus,
    this.blockStatus,
    this.recentReplyIds,
    this.feedUid,
    this.fetchType,
    this.entityId,
    this.avatarFetchType,
    this.userAvatar,
    this.entityTemplate,
    this.entityType,
    this.infoHtml,
    this.isFeedAuthor,
    this.userAction,
    this.userInfo,
    this.replyRows,
    this.replyRowsCount,
    this.replyRowsMore,
  });

  factory ReplyDataEntity.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<InReplyRowEntity> replyRows = jsonRes['replyRows'] is List ? [] : null;
    if (replyRows != null) {
      for (var item in jsonRes['replyRows']) {
        if (item != null) {
          tryCatch(() {
            replyRows.add(InReplyRowEntity.fromJson(item));
          });
        }
      }
    }

    return ReplyDataEntity(
      id: convertValueByType(jsonRes['id'], int, stack: "ReplyDataEntity-id"),
      ftype: convertValueByType(jsonRes['ftype'], int,
          stack: "ReplyDataEntity-ftype"),
      fid:
          convertValueByType(jsonRes['fid'], int, stack: "ReplyDataEntity-fid"),
      rid:
          convertValueByType(jsonRes['rid'], int, stack: "ReplyDataEntity-rid"),
      rrid: convertValueByType(jsonRes['rrid'], int,
          stack: "ReplyDataEntity-rrid"),
      uid:
          convertValueByType(jsonRes['uid'], int, stack: "ReplyDataEntity-uid"),
      username: convertValueByType(jsonRes['username'], String,
          stack: "ReplyDataEntity-username"),
      ruid: convertValueByType(jsonRes['ruid'], int,
          stack: "ReplyDataEntity-ruid"),
      rusername: convertValueByType(jsonRes['rusername'], String,
          stack: "ReplyDataEntity-rusername"),
      pic: convertValueByType(jsonRes['pic'], String,
          stack: "ReplyDataEntity-pic"),
      message: convertValueByType(jsonRes['message'], String,
          stack: "ReplyDataEntity-message"),
      replynum: convertValueByType(jsonRes['replynum'], int,
          stack: "ReplyDataEntity-replynum"),
      likenum: convertValueByType(jsonRes['likenum'], int,
          stack: "ReplyDataEntity-likenum"),
      burynum: convertValueByType(jsonRes['burynum'], int,
          stack: "ReplyDataEntity-burynum"),
      reportnum: convertValueByType(jsonRes['reportnum'], int,
          stack: "ReplyDataEntity-reportnum"),
      rankScore: convertValueByType(jsonRes['rank_score'], int,
          stack: "ReplyDataEntity-rank_score"),
      dateline: convertValueByType(jsonRes['dateline'], int,
          stack: "ReplyDataEntity-dateline"),
      lastupdate: convertValueByType(jsonRes['lastupdate'], int,
          stack: "ReplyDataEntity-lastupdate"),
      isFolded: convertValueByType(jsonRes['is_folded'], int,
          stack: "ReplyDataEntity-is_folded"),
      status: convertValueByType(jsonRes['status'], int,
          stack: "ReplyDataEntity-status"),
      messageStatus: convertValueByType(jsonRes['message_status'], int,
          stack: "ReplyDataEntity-message_status"),
      blockStatus: convertValueByType(jsonRes['block_status'], int,
          stack: "ReplyDataEntity-block_status"),
      recentReplyIds: convertValueByType(jsonRes['recent_reply_ids'], String,
          stack: "ReplyDataEntity-recent_reply_ids"),
      feedUid: convertValueByType(jsonRes['feedUid'], int,
          stack: "ReplyDataEntity-feedUid"),
      fetchType: convertValueByType(jsonRes['fetchType'], String,
          stack: "ReplyDataEntity-fetchType"),
      entityId: convertValueByType(jsonRes['entityId'], int,
          stack: "ReplyDataEntity-entityId"),
      avatarFetchType: convertValueByType(jsonRes['avatarFetchType'], String,
          stack: "ReplyDataEntity-avatarFetchType"),
      userAvatar: convertValueByType(jsonRes['userAvatar'], String,
          stack: "ReplyDataEntity-userAvatar"),
      entityTemplate: convertValueByType(jsonRes['entityTemplate'], String,
          stack: "ReplyDataEntity-entityTemplate"),
      entityType: convertValueByType(jsonRes['entityType'], String,
          stack: "ReplyDataEntity-entityType"),
      infoHtml: convertValueByType(jsonRes['infoHtml'], String,
          stack: "ReplyDataEntity-infoHtml"),
      isFeedAuthor: convertValueByType(jsonRes['isFeedAuthor'], int,
          stack: "ReplyDataEntity-isFeedAuthor"),
      userAction: _UserAction.fromJson(jsonRes['userAction']),
      userInfo: _UserInfo.fromJson(jsonRes['userInfo']),
      replyRows: replyRows,
      replyRowsCount: convertValueByType(jsonRes['replyRowsCount'], int,
          stack: "ReplyDataEntity-replyRowsCount"),
      replyRowsMore: convertValueByType(jsonRes['replyRowsMore'], int,
          stack: "ReplyDataEntity-replyRowsMore"),
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'ftype': ftype,
        'fid': fid,
        'rid': rid,
        'rrid': rrid,
        'uid': uid,
        'username': username,
        'ruid': ruid,
        'rusername': rusername,
        'pic': pic,
        'message': message,
        'replynum': replynum,
        'likenum': likenum,
        'burynum': burynum,
        'reportnum': reportnum,
        'rank_score': rankScore,
        'dateline': dateline,
        'lastupdate': lastupdate,
        'is_folded': isFolded,
        'status': status,
        'message_status': messageStatus,
        'block_status': blockStatus,
        'recent_reply_ids': recentReplyIds,
        'feedUid': feedUid,
        'fetchType': fetchType,
        'entityId': entityId,
        'avatarFetchType': avatarFetchType,
        'userAvatar': userAvatar,
        'entityTemplate': entityTemplate,
        'entityType': entityType,
        'infoHtml': infoHtml,
        'isFeedAuthor': isFeedAuthor,
        'userAction': userAction,
        'userInfo': userInfo,
        'replyRows': replyRows,
        'replyRowsCount': replyRowsCount,
        'replyRowsMore': replyRowsMore,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class _UserAction {
  final int like;

  _UserAction({
    this.like,
  });

  factory _UserAction.fromJson(jsonRes) => jsonRes == null
      ? null
      : _UserAction(
          like: convertValueByType(jsonRes['like'], int,
              stack: "_UserAction-like"),
        );
  Map<String, dynamic> toJson() => {
        'like': like,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class _UserInfo {
  final int uid;
  final String username;
  final int admintype;
  final int groupid;
  final int usergroupid;
  final int level;
  final int status;
  final int usernamestatus;
  final int avatarstatus;
  final int avatarCoverStatus;
  final int regdate;
  final int logintime;
  final String fetchType;
  final String entityType;
  final int entityId;
  final String displayUsername;
  final String url;
  final String userAvatar;
  final String userSmallAvatar;
  final String userBigAvatar;
  final String cover;
  final int verifyStatus;
  final String verifyIcon;
  final String verifyLabel;
  final String verifyTitle;

  _UserInfo({
    this.uid,
    this.username,
    this.admintype,
    this.groupid,
    this.usergroupid,
    this.level,
    this.status,
    this.usernamestatus,
    this.avatarstatus,
    this.avatarCoverStatus,
    this.regdate,
    this.logintime,
    this.fetchType,
    this.entityType,
    this.entityId,
    this.displayUsername,
    this.url,
    this.userAvatar,
    this.userSmallAvatar,
    this.userBigAvatar,
    this.cover,
    this.verifyStatus,
    this.verifyIcon,
    this.verifyLabel,
    this.verifyTitle,
  });

  factory _UserInfo.fromJson(jsonRes) => jsonRes == null
      ? null
      : _UserInfo(
          uid: convertValueByType(jsonRes['uid'], int, stack: "_UserInfo-uid"),
          username: convertValueByType(jsonRes['username'], String,
              stack: "_UserInfo-username"),
          admintype: convertValueByType(jsonRes['admintype'], int,
              stack: "_UserInfo-admintype"),
          groupid: convertValueByType(jsonRes['groupid'], int,
              stack: "_UserInfo-groupid"),
          usergroupid: convertValueByType(jsonRes['usergroupid'], int,
              stack: "_UserInfo-usergroupid"),
          level: convertValueByType(jsonRes['level'], int,
              stack: "_UserInfo-level"),
          status: convertValueByType(jsonRes['status'], int,
              stack: "_UserInfo-status"),
          usernamestatus: convertValueByType(jsonRes['usernamestatus'], int,
              stack: "_UserInfo-usernamestatus"),
          avatarstatus: convertValueByType(jsonRes['avatarstatus'], int,
              stack: "_UserInfo-avatarstatus"),
          avatarCoverStatus: convertValueByType(
              jsonRes['avatar_cover_status'], int,
              stack: "_UserInfo-avatar_cover_status"),
          regdate: convertValueByType(jsonRes['regdate'], int,
              stack: "_UserInfo-regdate"),
          logintime: convertValueByType(jsonRes['logintime'], int,
              stack: "_UserInfo-logintime"),
          fetchType: convertValueByType(jsonRes['fetchType'], String,
              stack: "_UserInfo-fetchType"),
          entityType: convertValueByType(jsonRes['entityType'], String,
              stack: "_UserInfo-entityType"),
          entityId: convertValueByType(jsonRes['entityId'], int,
              stack: "_UserInfo-entityId"),
          displayUsername: convertValueByType(
              jsonRes['displayUsername'], String,
              stack: "_UserInfo-displayUsername"),
          url: convertValueByType(jsonRes['url'], String,
              stack: "_UserInfo-url"),
          userAvatar: convertValueByType(jsonRes['userAvatar'], String,
              stack: "_UserInfo-userAvatar"),
          userSmallAvatar: convertValueByType(
              jsonRes['userSmallAvatar'], String,
              stack: "_UserInfo-userSmallAvatar"),
          userBigAvatar: convertValueByType(jsonRes['userBigAvatar'], String,
              stack: "_UserInfo-userBigAvatar"),
          cover: convertValueByType(jsonRes['cover'], String,
              stack: "_UserInfo-cover"),
          verifyStatus: convertValueByType(jsonRes['verify_status'], int,
              stack: "_UserInfo-verify_status"),
          verifyIcon: convertValueByType(jsonRes['verify_icon'], String,
              stack: "_UserInfo-verify_icon"),
          verifyLabel: convertValueByType(jsonRes['verify_label'], String,
              stack: "_UserInfo-verify_label"),
          verifyTitle: convertValueByType(jsonRes['verify_title'], String,
              stack: "_UserInfo-verify_title"),
        );
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'admintype': admintype,
        'groupid': groupid,
        'usergroupid': usergroupid,
        'level': level,
        'status': status,
        'usernamestatus': usernamestatus,
        'avatarstatus': avatarstatus,
        'avatar_cover_status': avatarCoverStatus,
        'regdate': regdate,
        'logintime': logintime,
        'fetchType': fetchType,
        'entityType': entityType,
        'entityId': entityId,
        'displayUsername': displayUsername,
        'url': url,
        'userAvatar': userAvatar,
        'userSmallAvatar': userSmallAvatar,
        'userBigAvatar': userBigAvatar,
        'cover': cover,
        'verify_status': verifyStatus,
        'verify_icon': verifyIcon,
        'verify_label': verifyLabel,
        'verify_title': verifyTitle,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class InReplyRowEntity {
  final int id;
  final int ftype;
  final int fid;
  final int rid;
  final int rrid;
  final int uid;
  final String username;
  final int ruid;
  final String rusername;
  final String pic;
  final String message;
  final int replynum;
  final int likenum;
  final int burynum;
  final int reportnum;
  final int rankScore;
  final int dateline;
  final int lastupdate;
  final int isFolded;
  final int status;
  final int messageStatus;
  final int blockStatus;
  final String recentReplyIds;
  final int feedUid;
  final String fetchType;
  final int entityId;
  final String avatarFetchType;
  final String userAvatar;
  final String entityTemplate;
  final String entityType;
  final String infoHtml;
  final int isFeedAuthor;

  InReplyRowEntity({
    this.id,
    this.ftype,
    this.fid,
    this.rid,
    this.rrid,
    this.uid,
    this.username,
    this.ruid,
    this.rusername,
    this.pic,
    this.message,
    this.replynum,
    this.likenum,
    this.burynum,
    this.reportnum,
    this.rankScore,
    this.dateline,
    this.lastupdate,
    this.isFolded,
    this.status,
    this.messageStatus,
    this.blockStatus,
    this.recentReplyIds,
    this.feedUid,
    this.fetchType,
    this.entityId,
    this.avatarFetchType,
    this.userAvatar,
    this.entityTemplate,
    this.entityType,
    this.infoHtml,
    this.isFeedAuthor,
  });

  factory InReplyRowEntity.fromJson(jsonRes) => jsonRes == null
      ? null
      : InReplyRowEntity(
          id: convertValueByType(jsonRes['id'], int, stack: "_InReplyRows-id"),
          ftype: convertValueByType(jsonRes['ftype'], int,
              stack: "_InReplyRows-ftype"),
          fid: convertValueByType(jsonRes['fid'], int,
              stack: "_InReplyRows-fid"),
          rid: convertValueByType(jsonRes['rid'], int,
              stack: "_InReplyRows-rid"),
          rrid: convertValueByType(jsonRes['rrid'], int,
              stack: "_InReplyRows-rrid"),
          uid: convertValueByType(jsonRes['uid'], int,
              stack: "_InReplyRows-uid"),
          username: convertValueByType(jsonRes['username'], String,
              stack: "_InReplyRows-username"),
          ruid: convertValueByType(jsonRes['ruid'], int,
              stack: "_InReplyRows-ruid"),
          rusername: convertValueByType(jsonRes['rusername'], String,
              stack: "_InReplyRows-rusername"),
          pic: convertValueByType(jsonRes['pic'], String,
              stack: "_InReplyRows-pic"),
          message: convertValueByType(jsonRes['message'], String,
              stack: "_InReplyRows-message"),
          replynum: convertValueByType(jsonRes['replynum'], int,
              stack: "_InReplyRows-replynum"),
          likenum: convertValueByType(jsonRes['likenum'], int,
              stack: "_InReplyRows-likenum"),
          burynum: convertValueByType(jsonRes['burynum'], int,
              stack: "_InReplyRows-burynum"),
          reportnum: convertValueByType(jsonRes['reportnum'], int,
              stack: "_InReplyRows-reportnum"),
          rankScore: convertValueByType(jsonRes['rank_score'], int,
              stack: "_InReplyRows-rank_score"),
          dateline: convertValueByType(jsonRes['dateline'], int,
              stack: "_InReplyRows-dateline"),
          lastupdate: convertValueByType(jsonRes['lastupdate'], int,
              stack: "_InReplyRows-lastupdate"),
          isFolded: convertValueByType(jsonRes['is_folded'], int,
              stack: "_InReplyRows-is_folded"),
          status: convertValueByType(jsonRes['status'], int,
              stack: "_InReplyRows-status"),
          messageStatus: convertValueByType(jsonRes['message_status'], int,
              stack: "_InReplyRows-message_status"),
          blockStatus: convertValueByType(jsonRes['block_status'], int,
              stack: "_InReplyRows-block_status"),
          recentReplyIds: convertValueByType(
              jsonRes['recent_reply_ids'], String,
              stack: "_InReplyRows-recent_reply_ids"),
          feedUid: convertValueByType(jsonRes['feedUid'], int,
              stack: "_InReplyRows-feedUid"),
          fetchType: convertValueByType(jsonRes['fetchType'], String,
              stack: "_InReplyRows-fetchType"),
          entityId: convertValueByType(jsonRes['entityId'], int,
              stack: "_InReplyRows-entityId"),
          avatarFetchType: convertValueByType(
              jsonRes['avatarFetchType'], String,
              stack: "_InReplyRows-avatarFetchType"),
          userAvatar: convertValueByType(jsonRes['userAvatar'], String,
              stack: "_InReplyRows-userAvatar"),
          entityTemplate: convertValueByType(jsonRes['entityTemplate'], String,
              stack: "_InReplyRows-entityTemplate"),
          entityType: convertValueByType(jsonRes['entityType'], String,
              stack: "_InReplyRows-entityType"),
          infoHtml: convertValueByType(jsonRes['infoHtml'], String,
              stack: "_InReplyRows-infoHtml"),
          isFeedAuthor: convertValueByType(jsonRes['isFeedAuthor'], int,
              stack: "_InReplyRows-isFeedAuthor"),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'ftype': ftype,
        'fid': fid,
        'rid': rid,
        'rrid': rrid,
        'uid': uid,
        'username': username,
        'ruid': ruid,
        'rusername': rusername,
        'pic': pic,
        'message': message,
        'replynum': replynum,
        'likenum': likenum,
        'burynum': burynum,
        'reportnum': reportnum,
        'rank_score': rankScore,
        'dateline': dateline,
        'lastupdate': lastupdate,
        'is_folded': isFolded,
        'status': status,
        'message_status': messageStatus,
        'block_status': blockStatus,
        'recent_reply_ids': recentReplyIds,
        'feedUid': feedUid,
        'fetchType': fetchType,
        'entityId': entityId,
        'avatarFetchType': avatarFetchType,
        'userAvatar': userAvatar,
        'entityTemplate': entityTemplate,
        'entityType': entityType,
        'infoHtml': infoHtml,
        'isFeedAuthor': isFeedAuthor,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
