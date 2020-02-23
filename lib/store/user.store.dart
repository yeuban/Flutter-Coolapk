import 'package:coolapk_flutter/network/api/user.api.dart';
import 'package:coolapk_flutter/network/model/login_info.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserStore extends ChangeNotifier {
  LoginInfoData _loginInfoData;

  LoginInfoData get loginInfo => _loginInfoData;

  String get userName => loginInfo?.username;

  set loginInfo(LoginInfoData data) {
    if (_loginInfoData != data) {
      _loginInfoData = data;
      notifyListeners();
    }
  }

  Future<bool> checkLoginInfo() async {
    if (loginInfo != null) return true;
    LoginInfoModel loginInfoModel = await UserApi.checkLoginInfoData();
    if (loginInfoModel == null) {
      return false; // 没有登录信息
    } else {
      loginInfo = loginInfoModel.data;
    }
    return true;
  }

  static UserStore of(final BuildContext context,
          {final bool listen = false}) =>
      Provider.of<UserStore>(context, listen: listen);
}
