import 'dart:convert' show json;
import 'package:coolapk_flutter/network/model/util.dart';

class LoginInfoModel {
  final LoginInfoData data;

  LoginInfoModel({
    this.data,
  });

  factory LoginInfoModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : LoginInfoModel(
          data: LoginInfoData.fromJson(jsonRes['data']),
        );
  Map<String, dynamic> toJson() => {
        'data': data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class LoginInfoData {
  final String uid;
  final String username;
  final String token;
  final int adminType;
  final String userAvatar;
  final NotifyCount notifyCount;

  LoginInfoData({
    this.uid,
    this.username,
    this.token,
    this.adminType,
    this.userAvatar,
    this.notifyCount,
  });

  factory LoginInfoData.fromJson(jsonRes) => jsonRes == null
      ? null
      : LoginInfoData(
          uid: convertValueByType(jsonRes['uid'], String,
              stack: "LoginInfoData-uid"),
          username: convertValueByType(jsonRes['username'], String,
              stack: "LoginInfoData-username"),
          token: convertValueByType(jsonRes['token'], String,
              stack: "LoginInfoData-token"),
          adminType: convertValueByType(jsonRes['adminType'], int,
              stack: "LoginInfoData-adminType"),
          userAvatar: convertValueByType(jsonRes['userAvatar'], String,
              stack: "LoginInfoData-userAvatar"),
          notifyCount: NotifyCount.fromJson(jsonRes['notifyCount']),
        );
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'token': token,
        'adminType': adminType,
        'userAvatar': userAvatar,
        'notifyCount': notifyCount,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class NotifyCount {
  final int cloudInstall;
  final int notification;
  final int contactsFollow;
  final int message;
  final int atme;
  final int atcommentme;
  final int commentme;
  final int feedlike;
  final int badge;
  final int dateline;

  NotifyCount({
    this.cloudInstall,
    this.notification,
    this.contactsFollow,
    this.message,
    this.atme,
    this.atcommentme,
    this.commentme,
    this.feedlike,
    this.badge,
    this.dateline,
  });

  factory NotifyCount.fromJson(jsonRes) => jsonRes == null
      ? null
      : NotifyCount(
          cloudInstall: convertValueByType(jsonRes['cloudInstall'], int,
              stack: "NotifyCount-cloudInstall"),
          notification: convertValueByType(jsonRes['notification'], int,
              stack: "NotifyCount-notification"),
          contactsFollow: convertValueByType(jsonRes['contacts_follow'], int,
              stack: "NotifyCount-contacts_follow"),
          message: convertValueByType(jsonRes['message'], int,
              stack: "NotifyCount-message"),
          atme: convertValueByType(jsonRes['atme'], int,
              stack: "NotifyCount-atme"),
          atcommentme: convertValueByType(jsonRes['atcommentme'], int,
              stack: "NotifyCount-atcommentme"),
          commentme: convertValueByType(jsonRes['commentme'], int,
              stack: "NotifyCount-commentme"),
          feedlike: convertValueByType(jsonRes['feedlike'], int,
              stack: "NotifyCount-feedlike"),
          badge: convertValueByType(jsonRes['badge'], int,
              stack: "NotifyCount-badge"),
          dateline: convertValueByType(jsonRes['dateline'], int,
              stack: "NotifyCount-dateline"),
        );
  Map<String, dynamic> toJson() => {
        'cloudInstall': cloudInstall,
        'notification': notification,
        'contacts_follow': contactsFollow,
        'message': message,
        'atme': atme,
        'atcommentme': atcommentme,
        'commentme': commentme,
        'feedlike': feedlike,
        'badge': badge,
        'dateline': dateline,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
