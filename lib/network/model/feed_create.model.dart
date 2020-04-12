import 'dart:convert' show json;

import 'package:coolapk_flutter/network/model/util.dart';
import 'package:flutter/cupertino.dart';

class FeedCreateModel {
  @required
  final String message;
  @required
  final String type;
  @required
  final int isHtmlArticle;
  @required
  final String pic;
  @required
  final int status;
  @required
  final String location;
  @required
  final String longLocation;
  @required
  final double latitude;
  @required
  final double longitude;
  @required
  final String mediaUrl;
  @required
  final int mediaType;
  @required
  final String mediaPic;
  @required
  final String messageTitle;
  @required
  final String messageBrief;
  @required
  final String extraTitle;
  @required
  final String extraKey;
  @required
  final String extraUrl;
  @required
  final String extraPic;
  @required
  final String extraInfo;
  @required
  final String messageCover;
  @required
  final int disallowRepost;
  @required
  final int isAnonymous;
  @required
  final int isEditindyh;
  @required
  final String forwardid;
  @required
  final String fid;
  @required
  final String dyhId;
  @required
  final String targetType;
  @required
  final String productId;
  @required
  final String province;
  @required
  final String cityCode;
  @required
  final String targetId;
  @required
  final String locationCity;
  @required
  final String locationCountry;
  @required
  final int disallowReply;
  @required
  final int voteScore;
  @required
  final int replyWithForward;
  @required
  final String mediaInfo;
  @required
  final int insertProductMedia;

  FeedCreateModel({
    this.message,
    this.type,
    this.isHtmlArticle,
    this.pic,
    this.status,
    this.location,
    this.longLocation,
    this.latitude,
    this.longitude,
    this.mediaUrl,
    this.mediaType,
    this.mediaPic,
    this.messageTitle,
    this.messageBrief,
    this.extraTitle,
    this.extraUrl,
    this.extraPic,
    this.extraInfo,
    this.messageCover,
    this.disallowRepost,
    this.isAnonymous,
    this.isEditindyh,
    this.forwardid,
    this.fid,
    this.dyhId,
    this.targetType,
    this.extraKey,
    this.productId,
    this.province,
    this.cityCode,
    this.targetId,
    this.locationCity,
    this.locationCountry,
    this.disallowReply,
    this.voteScore,
    this.replyWithForward,
    this.mediaInfo,
    this.insertProductMedia,
  });

  factory FeedCreateModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : FeedCreateModel(
          message: convertValueByType(jsonRes['message'], String,
              stack: "FeedCreateModel-message"),
          type: convertValueByType(jsonRes['type'], String,
              stack: "FeedCreateModel-type"),
          isHtmlArticle: convertValueByType(jsonRes['is_html_article'], int,
              stack: "FeedCreateModel-is_html_article"),
          pic: convertValueByType(jsonRes['pic'], String,
              stack: "FeedCreateModel-pic"),
          status: convertValueByType(jsonRes['status'], int,
              stack: "FeedCreateModel-status"),
          location: convertValueByType(jsonRes['location'], String,
              stack: "FeedCreateModel-location"),
          longLocation: convertValueByType(jsonRes['long_location'], String,
              stack: "FeedCreateModel-long_location"),
          latitude: convertValueByType(jsonRes['latitude'], double,
              stack: "FeedCreateModel-latitude"),
          longitude: convertValueByType(jsonRes['longitude'], double,
              stack: "FeedCreateModel-longitude"),
          mediaUrl: convertValueByType(jsonRes['media_url'], String,
              stack: "FeedCreateModel-media_url"),
          mediaType: convertValueByType(jsonRes['media_type'], int,
              stack: "FeedCreateModel-media_type"),
          mediaPic: convertValueByType(jsonRes['media_pic'], String,
              stack: "FeedCreateModel-media_pic"),
          messageTitle: convertValueByType(jsonRes['message_title'], String,
              stack: "FeedCreateModel-message_title"),
          messageBrief: convertValueByType(jsonRes['message_brief'], String,
              stack: "FeedCreateModel-message_brief"),
          extraTitle: convertValueByType(jsonRes['extra_title'], String,
              stack: "FeedCreateModel-extra_title"),
          extraUrl: convertValueByType(jsonRes['extra_url'], String,
              stack: "FeedCreateModel-extra_url"),
          extraPic: convertValueByType(jsonRes['extra_pic'], String,
              stack: "FeedCreateModel-extra_pic"),
          extraInfo: convertValueByType(jsonRes['extra_info'], String,
              stack: "FeedCreateModel-extra_info"),
          messageCover: convertValueByType(jsonRes['message_cover'], String,
              stack: "FeedCreateModel-message_cover"),
          disallowRepost: convertValueByType(jsonRes['disallow_repost'], int,
              stack: "FeedCreateModel-disallow_repost"),
          isAnonymous: convertValueByType(jsonRes['is_anonymous'], int,
              stack: "FeedCreateModel-is_anonymous"),
          isEditindyh: convertValueByType(jsonRes['is_editInDyh'], int,
              stack: "FeedCreateModel-is_editInDyh"),
          forwardid: convertValueByType(jsonRes['forwardid'], String,
              stack: "FeedCreateModel-forwardid"),
          fid: convertValueByType(jsonRes['fid'], String,
              stack: "FeedCreateModel-fid"),
          dyhId: convertValueByType(jsonRes['dyhId'], String,
              stack: "FeedCreateModel-dyhId"),
          targetType: convertValueByType(jsonRes['targetType'], String,
              stack: "FeedCreateModel-targetType"),
          productId: convertValueByType(jsonRes['productId'], String,
              stack: "FeedCreateModel-productId"),
          province: convertValueByType(jsonRes['province'], String,
              stack: "FeedCreateModel-province"),
          cityCode: convertValueByType(jsonRes['city_code'], String,
              stack: "FeedCreateModel-city_code"),
          targetId: convertValueByType(jsonRes['targetId'], String,
              stack: "FeedCreateModel-targetId"),
          locationCity: convertValueByType(jsonRes['location_city'], String,
              stack: "FeedCreateModel-location_city"),
          locationCountry: convertValueByType(
              jsonRes['location_country'], String,
              stack: "FeedCreateModel-location_country"),
          disallowReply: convertValueByType(jsonRes['disallow_reply'], int,
              stack: "FeedCreateModel-disallow_reply"),
          voteScore: convertValueByType(jsonRes['vote_score'], int,
              stack: "FeedCreateModel-vote_score"),
          replyWithForward: convertValueByType(jsonRes['replyWithForward'], int,
              stack: "FeedCreateModel-replyWithForward"),
          mediaInfo: convertValueByType(jsonRes['media_info'], String,
              stack: "FeedCreateModel-media_info"),
          insertProductMedia: convertValueByType(
              jsonRes['insert_product_media'], int,
              stack: "FeedCreateModel-insert_product_media"),
          extraKey: convertValueByType(jsonRes['extra_key'], String,
              stack: "FeedCreateModel-extra_key"),
        );
  Map<String, dynamic> toJson() => {
        'message': message,
        'type': type,
        'is_html_article': isHtmlArticle,
        'pic': pic,
        'status': status,
        'location': location,
        'long_location': longLocation,
        'latitude': latitude,
        'longitude': longitude,
        'media_url': mediaUrl,
        'media_type': mediaType,
        'media_pic': mediaPic,
        'message_title': messageTitle,
        'message_brief': messageBrief,
        'extra_title': extraTitle,
        'extra_url': extraUrl,
        'extra_pic': extraPic,
        'extra_info': extraInfo,
        'message_cover': messageCover,
        'disallow_repost': disallowRepost,
        'is_anonymous': isAnonymous,
        'is_editInDyh': isEditindyh,
        'forwardid': forwardid,
        'fid': fid,
        'dyhId': dyhId,
        'targetType': targetType,
        'productId': productId,
        'province': province,
        'city_code': cityCode,
        'targetId': targetId,
        'extra_key': extraKey,
        'location_city': locationCity,
        'location_country': locationCountry,
        'disallow_reply': disallowReply,
        'vote_score': voteScore,
        'replyWithForward': replyWithForward,
        'media_info': mediaInfo,
        'insert_product_media': insertProductMedia,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
