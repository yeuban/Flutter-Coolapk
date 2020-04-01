import 'package:coolapk_flutter/page/login/login.page.dart';
import 'package:coolapk_flutter/util/anim_page_route.dart';
import 'package:flutter/material.dart';

ScaffoldFeatureController showToLoginSnackBar(final BuildContext context, {final String message}) {
  return Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(message ?? "您还没有登录，请先登录~"),
    action: SnackBarAction(
      label: "登录",
      onPressed: () {
        Navigator.of(context).push(ScaleInRoute(widget: LoginPage()));
      },
    ),
  ));
}
