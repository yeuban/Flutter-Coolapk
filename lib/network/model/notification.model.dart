import 'dart:convert' show json;

import 'package:coolapk_flutter/network/model/util.dart';

class NotificationModel {
  final List<NotificationModelData> data;

  NotificationModel({
    this.data,
  });

  factory NotificationModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<NotificationModelData> data = jsonRes['data'] is List ? [] : null;
    if (data != null) {
      for (var item in jsonRes['data']) {
        if (item != null) {
          tryCatch(() {
            data.add(NotificationModelData.fromJson(item));
          });
        }
      }
    }

    return NotificationModel(
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

class NotificationModelData {
  final int id;
  final int uid;
  final int fromType;
  final int fromuid;
  final String fromusername;
  final int listGroup;
  final String type;
  final String slug;
  final int isnew;
  final String note;
  final int dateline;
  final String entityType;
  final int entityId;
  final String url;
  final String fromUserAvatar;
  final NotificationModelFromUserInfo fromUserInfo;

  NotificationModelData({
    this.id,
    this.uid,
    this.fromType,
    this.fromuid,
    this.fromusername,
    this.listGroup,
    this.type,
    this.slug,
    this.isnew,
    this.note,
    this.dateline,
    this.entityType,
    this.entityId,
    this.url,
    this.fromUserAvatar,
    this.fromUserInfo,
  });

  factory NotificationModelData.fromJson(jsonRes) => jsonRes == null
      ? null
      : NotificationModelData(
          id: convertValueByType(jsonRes['id'], int,
              stack: "NotificationModelData-id"),
          uid: convertValueByType(jsonRes['uid'], int,
              stack: "NotificationModelData-uid"),
          fromType: convertValueByType(jsonRes['from_type'], int,
              stack: "NotificationModelData-from_type"),
          fromuid: convertValueByType(jsonRes['fromuid'], int,
              stack: "NotificationModelData-fromuid"),
          fromusername: convertValueByType(jsonRes['fromusername'], String,
              stack: "NotificationModelData-fromusername"),
          listGroup: convertValueByType(jsonRes['list_group'], int,
              stack: "NotificationModelData-list_group"),
          type: convertValueByType(jsonRes['type'], String,
              stack: "NotificationModelData-type"),
          slug: convertValueByType(jsonRes['slug'], String,
              stack: "NotificationModelData-slug"),
          isnew: convertValueByType(jsonRes['isnew'], int,
              stack: "NotificationModelData-isnew"),
          note: convertValueByType(jsonRes['note'], String,
              stack: "NotificationModelData-note"),
          dateline: convertValueByType(jsonRes['dateline'], int,
              stack: "NotificationModelData-dateline"),
          entityType: convertValueByType(jsonRes['entityType'], String,
              stack: "NotificationModelData-entityType"),
          entityId: convertValueByType(jsonRes['entityId'], int,
              stack: "NotificationModelData-entityId"),
          url: convertValueByType(jsonRes['url'], String,
              stack: "NotificationModelData-url"),
          fromUserAvatar: convertValueByType(jsonRes['fromUserAvatar'], String,
              stack: "NotificationModelData-fromUserAvatar"),
          fromUserInfo:
              NotificationModelFromUserInfo.fromJson(jsonRes['fromUserInfo']),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'from_type': fromType,
        'fromuid': fromuid,
        'fromusername': fromusername,
        'list_group': listGroup,
        'type': type,
        'slug': slug,
        'isnew': isnew,
        'note': note,
        'dateline': dateline,
        'entityType': entityType,
        'entityId': entityId,
        'url': url,
        'fromUserAvatar': fromUserAvatar,
        'fromUserInfo': fromUserInfo,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class NotificationModelFromUserInfo {
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

  NotificationModelFromUserInfo({
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

  factory NotificationModelFromUserInfo.fromJson(jsonRes) => jsonRes == null
      ? null
      : NotificationModelFromUserInfo(
          uid: convertValueByType(jsonRes['uid'], int,
              stack: "NotificationModelFromUserInfo-uid"),
          username: convertValueByType(jsonRes['username'], String,
              stack: "NotificationModelFromUserInfo-username"),
          admintype: convertValueByType(jsonRes['admintype'], int,
              stack: "NotificationModelFromUserInfo-admintype"),
          groupid: convertValueByType(jsonRes['groupid'], int,
              stack: "NotificationModelFromUserInfo-groupid"),
          usergroupid: convertValueByType(jsonRes['usergroupid'], int,
              stack: "NotificationModelFromUserInfo-usergroupid"),
          level: convertValueByType(jsonRes['level'], int,
              stack: "NotificationModelFromUserInfo-level"),
          status: convertValueByType(jsonRes['status'], int,
              stack: "NotificationModelFromUserInfo-status"),
          usernamestatus: convertValueByType(jsonRes['usernamestatus'], int,
              stack: "NotificationModelFromUserInfo-usernamestatus"),
          avatarstatus: convertValueByType(jsonRes['avatarstatus'], int,
              stack: "NotificationModelFromUserInfo-avatarstatus"),
          avatarCoverStatus: convertValueByType(
              jsonRes['avatar_cover_status'], int,
              stack: "NotificationModelFromUserInfo-avatar_cover_status"),
          regdate: convertValueByType(jsonRes['regdate'], int,
              stack: "NotificationModelFromUserInfo-regdate"),
          logintime: convertValueByType(jsonRes['logintime'], int,
              stack: "NotificationModelFromUserInfo-logintime"),
          fetchType: convertValueByType(jsonRes['fetchType'], String,
              stack: "NotificationModelFromUserInfo-fetchType"),
          entityType: convertValueByType(jsonRes['entityType'], String,
              stack: "NotificationModelFromUserInfo-entityType"),
          entityId: convertValueByType(jsonRes['entityId'], int,
              stack: "NotificationModelFromUserInfo-entityId"),
          displayUsername: convertValueByType(
              jsonRes['displayUsername'], String,
              stack: "NotificationModelFromUserInfo-displayUsername"),
          url: convertValueByType(jsonRes['url'], String,
              stack: "NotificationModelFromUserInfo-url"),
          userAvatar: convertValueByType(jsonRes['userAvatar'], String,
              stack: "NotificationModelFromUserInfo-userAvatar"),
          userSmallAvatar: convertValueByType(
              jsonRes['userSmallAvatar'], String,
              stack: "NotificationModelFromUserInfo-userSmallAvatar"),
          userBigAvatar: convertValueByType(jsonRes['userBigAvatar'], String,
              stack: "NotificationModelFromUserInfo-userBigAvatar"),
          cover: convertValueByType(jsonRes['cover'], String,
              stack: "NotificationModelFromUserInfo-cover"),
          verifyStatus: convertValueByType(jsonRes['verify_status'], int,
              stack: "NotificationModelFromUserInfo-verify_status"),
          verifyIcon: convertValueByType(jsonRes['verify_icon'], String,
              stack: "NotificationModelFromUserInfo-verify_icon"),
          verifyLabel: convertValueByType(jsonRes['verify_label'], String,
              stack: "NotificationModelFromUserInfo-verify_label"),
          verifyTitle: convertValueByType(jsonRes['verify_title'], String,
              stack: "NotificationModelFromUserInfo-verify_title"),
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
