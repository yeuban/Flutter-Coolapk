import 'dart:convert';
import 'dart:math';

import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:dio/dio.dart';

class AuthApi {
  static String get captchaUrl =>
      "https://account.coolapk.com/auth/showCaptchaImage?1582721958000${Random().nextDouble()}";
  static Future<dynamic> getRequestHash() async {
    final resp = await Network.authDio.post(
      "/auth/loginByCoolapk",
      queryParameters: {
        "submit": 1,
        "requestHash": "???",
        "login": "admin",
        "password": "admin",
        "captcha": "nichai",
        "randomNumber": "***?",
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "x-requested-with": "XMLHttpRequest",
        },
        responseType: ResponseType.json,
      ),
    );
    return resp.data;
  }

  static Future<dynamic> login(String userName, String password, String captcha,
      String requestHash) async {
    final resp = await Network.authDio.post(
      "/auth/loginByCoolapk",
      data: {
        "submit": 1,
        "requestHash": requestHash,
        "login": userName,
        "password": password,
        "captcha": captcha,
        "randomNumber":
            "0undefined123123" + Random().nextInt(1000000).toString(),
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "x-requested-with": "XMLHttpRequest",
        },
      ),
    );
    return jsonDecode(resp.data);
  }
}
