import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/network/model/login_info.model.dart';
import 'package:coolapk_flutter/network/model/user_space.model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserApi {
  static Future<UserSpaceModelData> userSpace({
    @required dynamic uid,
  }) async {
    return UserSpaceModel.fromJson(
            (await Network.apiDio.get("/user/space", queryParameters: {
      "uid": uid,
    }))
                .data)
        .data;
  }

  static Future<LoginInfoModel> checkLoginInfoData() async {
    try {
      final resp = await Network.apiDio.get("/account/checkLoginInfo");
      return LoginInfoModel.fromJson(resp.data);
    } catch (err) {
      return null;
    }
  }

  static Future<dynamic> updateConfig({
    @required dynamic key,
    @required dynamic value,
  }) async {
    // value must be json string
    return (await Network.apiDio.post("/account/updateConfig",
            data: FormData.fromMap({
              "key": key,
              "value": value,
            })))
        .data;
  }
}
