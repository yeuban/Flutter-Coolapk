import 'dart:convert' show json;
import 'package:coolapk_flutter/network/model/util.dart';

// 图文

class HtmlArticleModel {
  final List<HtmlArticleFragment> data;

  HtmlArticleModel({
    this.data,
  });

  factory HtmlArticleModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<HtmlArticleFragment> data = jsonRes['data'] is List ? [] : null;
    if (data != null) {
      for (var item in jsonRes['data']) {
        if (item != null) {
          tryCatch(() {
            data.add(HtmlArticleFragment.fromJson(item));
          });
        }
      }
    }

    return HtmlArticleModel(
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

class HtmlArticleFragment {
  final String type;
  final String message;
  final String description;
  final String url;

  HtmlArticleFragment({
    this.type,
    this.message,
    this.description,
    this.url,
  });

  factory HtmlArticleFragment.fromJson(jsonRes) => jsonRes == null
      ? null
      : HtmlArticleFragment(
          type: convertValueByType(jsonRes['type'], String,
              stack: "HtmlArticleFragment-type"),
          message: convertValueByType(jsonRes['message'], String,
              stack: "HtmlArticleFragment-message"),
          description: convertValueByType(jsonRes['description'], String,
              stack: "HtmlArticleFragment-description"),
          url: convertValueByType(jsonRes['url'], String,
              stack: "HtmlArticleFragment-url"),
        );
  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'description': description,
        'url': url,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
