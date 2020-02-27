import 'dart:async';

import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/page/home/home.page.dart';
import 'package:coolapk_flutter/page/login/login.page.dart';
import 'package:coolapk_flutter/store/theme.store.dart';
import 'package:coolapk_flutter/store/user.store.dart';
import 'package:coolapk_flutter/util/anim_page_route.dart';
import 'package:coolapk_flutter/util/global_storage.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

Future<bool> setupComponent() async {
  await GlobalStorage.setupGlobalStorage();
  await Network.setupNetwork();
  return true;
}

Future<bool> init(final BuildContext context) async {
  await Provider.of<ThemeStore>(context, listen: false).loadConfig();
  final loginInfo =
      await Provider.of<UserStore>(context, listen: false).checkLoginInfo();
  print("登录信息:" + loginInfo.toString());
  return true;
}

class LauncherPage extends StatefulWidget {
  const LauncherPage({Key key}) : super(key: key);

  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage>
    with TickerProviderStateMixin {
  dynamic err;

  AnimationController _animCtr;
  Animation<double> _scaleAnim;
  Animation<double> _scaleAnim2;

  @override
  void initState() {
    super.initState();
    _animCtr = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    final _curvedAnim = CurvedAnimation(
      parent: _animCtr,
      curve: Curves.fastOutSlowIn,
    );
    _scaleAnim = Tween(begin: 0.0, end: 1.0).animate(_curvedAnim);
    _scaleAnim2 = Tween(begin: 1.0, end: 10.0).animate(_curvedAnim);
    _animCtr.addListener(() {
      setState(() {});
    });
    doAppInit();
  }

  @override
  void dispose() {
    _animCtr.dispose();
    super.dispose();
  }

  doAppInit() async {
    try {
      _animCtr.forward(from: 0.0);
      await setupComponent();
      await init(context);
      await Future.delayed(Duration(milliseconds: 500));
      _animCtr.reset();
      _scaleAnim = _scaleAnim2;
      _animCtr.forward();
      Future.delayed(Duration(milliseconds: 500)).then((_) {
        Navigator.pushReplacement(
          context,
          ScaleInRoute(widget: LoginPage()),
        );
      });
      // ======================================= //
    } catch (err, stack) {
      debugPrintStack(stackTrace: stack);
      setState(() {
        this.err = err.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (err != null) {
      return Center(child: Text(err));
    }
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _scaleAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ExtendedImage.asset(
                  "assets/images/logo_256.png",
                  filterQuality: FilterQuality.high,
                  color: Color(0xff4caf50),
                  width: 80,
                  height: 80,
                ),
                Text(Provider.of<UserStore>(context).userName ?? "加载中..."),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {}
}
