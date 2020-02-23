import 'dart:convert' show json;

import 'package:coolapk_flutter/network/model/util.dart';

class MainInitModel {
  final List<MainInitModelData> data;

  MainInitModel({
    this.data,
  });

  factory MainInitModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<MainInitModelData> data = jsonRes['data'] is List ? [] : null;
    if (data != null) {
      for (var item in jsonRes['data']) {
        if (item != null) {
          tryCatch(() {
            data.add(MainInitModelData.fromJson(item));
          });
        }
      }
    }

    return MainInitModel(
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

class MainInitModelData {
  final String entityType;
  final String entityTemplate;
  final String title;
  final String url;
  final List<Entity> entities;
  final int entityId;
  final int entityFixed;
  final String pic;
  final int lastupdate;
  final String extraData;

  MainInitModelData({
    this.entityType,
    this.entityTemplate,
    this.title,
    this.url,
    this.entities,
    this.entityId,
    this.entityFixed,
    this.pic,
    this.lastupdate,
    this.extraData,
  });

  factory MainInitModelData.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Entity> entities = jsonRes['entities'] is List ? [] : null;
    if (entities != null) {
      for (var item in jsonRes['entities']) {
        if (item != null) {
          tryCatch(() {
            entities.add(Entity.fromJson(item));
          });
        }
      }
    }

    return MainInitModelData(
      entityType: convertValueByType(jsonRes['entityType'], String,
          stack: "MainInitModelData-entityType"),
      entityTemplate: convertValueByType(jsonRes['entityTemplate'], String,
          stack: "MainInitModelData-entityTemplate"),
      title: convertValueByType(jsonRes['title'], String,
          stack: "MainInitModelData-title"),
      url: convertValueByType(jsonRes['url'], String,
          stack: "MainInitModelData-url"),
      entities: entities,
      entityId: convertValueByType(jsonRes['entityId'], int,
          stack: "MainInitModelData-entityId"),
      entityFixed: convertValueByType(jsonRes['entityFixed'], int,
          stack: "MainInitModelData-entityFixed"),
      pic: convertValueByType(jsonRes['pic'], String,
          stack: "MainInitModelData-pic"),
      lastupdate: convertValueByType(jsonRes['lastupdate'], int,
          stack: "MainInitModelData-lastupdate"),
      extraData: convertValueByType(jsonRes['extraData'], String,
          stack: "MainInitModelData-extraData"),
    );
  }
  Map<String, dynamic> toJson() => {
        'entityType': entityType,
        'entityTemplate': entityTemplate,
        'title': title,
        'url': url,
        'entities': entities,
        'entityId': entityId,
        'entityFixed': entityFixed,
        'pic': pic,
        'lastupdate': lastupdate,
        'extraData': extraData,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Entity {
  final String entityType;
  final String title;
  final String url;
  final Object pic;
  final int id;
  final String pageName;
  final String logo;
  final String banner;
  final String description;
  final String content;
  final String pageExtras;
  final int status;
  final int pageType;
  final int order;
  final int isHeadCard;
  final int uid;
  final String username;
  final int hitnum;
  final int dateline;
  final int lastupdate;
  final int entityId;
  final List<Entity> entities;
  final String extraData;
  final int pageVisibility;
  final int pageFixed;

  Entity({
    this.entityType,
    this.title,
    this.url,
    this.pic,
    this.id,
    this.pageName,
    this.logo,
    this.banner,
    this.description,
    this.content,
    this.pageExtras,
    this.status,
    this.pageType,
    this.order,
    this.isHeadCard,
    this.uid,
    this.username,
    this.hitnum,
    this.dateline,
    this.lastupdate,
    this.entityId,
    this.entities,
    this.extraData,
    this.pageVisibility,
    this.pageFixed,
  });

  factory Entity.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Entity> entities = jsonRes['entities'] is List ? [] : null;
    if (entities != null) {
      for (var item in jsonRes['entities']) {
        if (item != null) {
          tryCatch(() {
            entities.add(Entity.fromJson(item));
          });
        }
      }
    }

    return Entity(
      entityType: convertValueByType(jsonRes['entityType'], String,
          stack: "Entity-entityType"),
      title:
          convertValueByType(jsonRes['title'], String, stack: "Entity-title"),
      url: convertValueByType(jsonRes['url'], String, stack: "Entity-url"),
      pic: convertValueByType(jsonRes['pic'], Object, stack: "Entity-pic"),
      id: convertValueByType(jsonRes['id'], int, stack: "Entity-id"),
      pageName: convertValueByType(jsonRes['page_name'], String,
          stack: "Entity-page_name"),
      logo: convertValueByType(jsonRes['logo'], String, stack: "Entity-logo"),
      banner:
          convertValueByType(jsonRes['banner'], String, stack: "Entity-banner"),
      description: convertValueByType(jsonRes['description'], String,
          stack: "Entity-description"),
      content: convertValueByType(jsonRes['content'], String,
          stack: "Entity-content"),
      pageExtras: convertValueByType(jsonRes['page_extras'], String,
          stack: "Entity-page_extras"),
      status:
          convertValueByType(jsonRes['status'], int, stack: "Entity-status"),
      pageType: convertValueByType(jsonRes['page_type'], int,
          stack: "Entity-page_type"),
      order: convertValueByType(jsonRes['order'], int, stack: "Entity-order"),
      isHeadCard: convertValueByType(jsonRes['is_head_card'], int,
          stack: "Entity-is_head_card"),
      uid: convertValueByType(jsonRes['uid'], int, stack: "Entity-uid"),
      username: convertValueByType(jsonRes['username'], String,
          stack: "Entity-username"),
      hitnum:
          convertValueByType(jsonRes['hitnum'], int, stack: "Entity-hitnum"),
      dateline: convertValueByType(jsonRes['dateline'], int,
          stack: "Entity-dateline"),
      lastupdate: convertValueByType(jsonRes['lastupdate'], int,
          stack: "Entity-lastupdate"),
      entityId: convertValueByType(jsonRes['entityId'], int,
          stack: "Entity-entityId"),
      entities: entities,
      extraData: convertValueByType(jsonRes['extraData'], String,
          stack: "Entity-extraData"),
      pageVisibility: convertValueByType(jsonRes['page_visibility'], int,
          stack: "Entity-page_visibility"),
      pageFixed: convertValueByType(jsonRes['page_fixed'], int,
          stack: "Entity-page_fixed"),
    );
  }
  Map<String, dynamic> toJson() => {
        'entityType': entityType,
        'title': title,
        'url': url,
        'pic': pic,
        'id': id,
        'page_name': pageName,
        'logo': logo,
        'banner': banner,
        'description': description,
        'content': content,
        'page_extras': pageExtras,
        'status': status,
        'page_type': pageType,
        'order': order,
        'is_head_card': isHeadCard,
        'uid': uid,
        'username': username,
        'hitnum': hitnum,
        'dateline': dateline,
        'lastupdate': lastupdate,
        'entityId': entityId,
        'entities': entities,
        'extraData': extraData,
        'page_visibility': pageVisibility,
        'page_fixed': pageFixed,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
