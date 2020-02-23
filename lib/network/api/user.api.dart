import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/network/model/login_info.model.dart';

class UserApi {
  static Future<LoginInfoModel> checkLoginInfoData() async {
    try {
      return LoginInfoModel.fromJson(
          await Network.apiDio.get("/v6/account/checkLoginInfo"));
    } catch (err) {
      return null;
    }
  }
}
