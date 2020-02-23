import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:coolapk_flutter/util/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

class Network {
  static TokenInterceptors _tokenInterceptors = TokenInterceptors();
  static PersistCookieJar cookieJar;
  static CookieManager _cookieManager;
  static Future<bool> setupNetwork() async {
    Directory temporaryDir;
    try {
      temporaryDir = await getTemporaryDirectory();
    } catch (err) {
      temporaryDir =
          Directory(Directory.systemTemp.path + "/coolapk_flutter/.cookies")
            ..createSync(recursive: true);
    }
    cookieJar = PersistCookieJar(dir: temporaryDir.path);
    _cookieManager = CookieManager(cookieJar);
    return true;
  }

  static Dio get apiDio {
    final Dio dio = Dio(BaseOptions(
      baseUrl: "https://api.coolapk.com/v6",
      contentType: Headers.formUrlEncodedContentType,
    ));
    dio.interceptors.add(_tokenInterceptors);
    dio.interceptors.add(_cookieManager);
    return dio;
  }

  static Dio get authDio {
    final Dio dio = Dio(BaseOptions(
      baseUrl: "https://account.coolapk.com",
      contentType: Headers.formUrlEncodedContentType,
    ));
    dio.interceptors.add(_cookieManager);
    return dio;
  }
}
