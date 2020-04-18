import 'package:coolapk_flutter/network/api/main.api.dart';
import 'package:coolapk_flutter/widget/future_switch.dart';
import 'package:coolapk_flutter/widget/to_login_snackbar.dart';
import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final bool initIsFollow;
  final uid;
  final Color color;
  final Color fontColor;
  final EdgeInsets margin;
  const FollowButton({
    Key key,
    this.initIsFollow = false,
    @required this.uid,
    this.color,
    this.fontColor,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureSwitch(
      initValue: initIsFollow,
      color: color ?? Theme.of(context).accentColor,
      fontColor: fontColor ?? Theme.of(context).primaryTextTheme.bodyText1.color,
      margin: margin ?? const EdgeInsets.only(right: 8),
      future: (value) async {
        final resp = await MainApi.setFollowUser(uid, value);
        if (resp["status"] == 401) {
          showToLoginSnackBar(context, message: resp["message"]);
          return false;
        } else {
          if (resp["data"] == 1 && value == false) {
            return false;
          }
        }
        return true;
      },
      builder: (context, value, error) {
        if (value) {
          return Text("取消关注");
        } else {
          return Text("关注大佬");
        }
      },
    );
  }
}
