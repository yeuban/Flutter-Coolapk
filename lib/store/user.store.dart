import 'package:coolapk_flutter/network/api/user.api.dart';
import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/network/model/login_info.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserStore extends ChangeNotifier {
  LoginInfoData _loginInfoData;
  // dynamic _userData;

  // dynamic get userInfo => _userData;
  LoginInfoData get loginInfo => _loginInfoData;

  String get userName => loginInfo?.username;

  set loginInfo(LoginInfoData data) {
    if (_loginInfoData != data) {
      _loginInfoData = data;
      notifyListeners();
    }
  }

  Future<LoginInfoData> checkLoginInfo({force = false}) async {
    if (loginInfo != null && !force) return loginInfo;
    LoginInfoModel loginInfoModel = await UserApi.checkLoginInfoData();
    if (loginInfoModel == null) {
      return null; // 没有登录信息
    } else {
      loginInfo = loginInfoModel.data;
    }
    return loginInfo;
  }

  void logout() {
    Network.cookieJar.deleteAll();
    _loginInfoData = null;
  }

  static String getUserUid(final BuildContext context) =>
      (UserStore.of(context)?.loginInfo?.uid);

  static UserStore of(final BuildContext context,
          {final bool listen = false}) =>
      Provider.of<UserStore>(context, listen: listen);
}
