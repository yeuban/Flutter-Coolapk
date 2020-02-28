import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/network/model/login_info.model.dart';

class UserApi {
  static Future<LoginInfoModel> checkLoginInfoData() async {
    try {
      final resp = await Network.apiDio.get("/account/checkLoginInfo");
      return LoginInfoModel.fromJson(resp.data);
    } catch (err) {
      return null;
    }
  }
}
