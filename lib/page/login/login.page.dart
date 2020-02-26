import 'dart:ui';

import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/page/login/password_login.dart';
import 'package:coolapk_flutter/page/login/token_login.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<dynamic> picMap = [];
  int picPick = 0;

  Future<bool> getPic() async {
    if (picMap != null && picMap.length != 0) {
      return false;
    }
    final resp = await Network.apiDio.get(
        "/page/dataList?url=%2Ffeed%2FcoolPictureList%3FlistType%3Dpad%26dataListType%3Dstaggered&title=%E5%B9%B3%E6%9D%BF&subTitle=");
    picMap = resp.data["data"];
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBackgroundPic(),
          _buildForm(),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Align(
      alignment: Alignment.centerRight,
      child: LoginFormAnim(
        child: Material(
          elevation: 8,
          child: ConstrainedBox(
            constraints: MediaQuery.of(context).size.width > 666
                ? const BoxConstraints(maxWidth: 330)
                : const BoxConstraints.expand(),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundPic() {
    return MediaQuery.of(context).size.width > 666
        ? FutureBuilder(
            builder: (context, snap) {
              if (snap.hasData) {
                String picUrl = picMap[picPick]["pic"];
                if (picUrl == null || picUrl.length <= 5)
                  return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(right: 330.0),
                  child: Stack(fit: StackFit.expand, children: [
                    ExtendedImage.network(
                      picUrl,
                      cache: false, //  TODO:
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 8),
                        child: Row(
                          children: [
                            FlatButton(
                              textColor: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  .color,
                              color: Theme.of(context).cardColor.withAlpha(20),
                              child: Text("下一张"),
                              onPressed: () {
                                setState(() {
                                  picPick++;
                                  if (picMap.length <= picPick) {
                                    picPick = 0;
                                  }
                                });
                              },
                            ),
                            Padding(padding: const EdgeInsets.all(8)),
                          ],
                        ),
                      ),
                    ),
                  ]),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            future: getPic(),
          )
        : const SizedBox();
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final Map<String, Function> _loginMethod = {
    "密码登录": () => PasswordLogin(),
    "Token登录": () => TokenLogin(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Text("登录酷安"),
              bottom: TabBar(
                // isScrollable: true,
                tabs: _loginMethod.keys.map((key) {
                  return Tab(text: key);
                }).toList(),
              ),
            ),
          ],
          body: SafeArea(
            top: true,
            bottom: true,
            child: TabBarView(
              children: _loginMethod.values.map<Widget>((v) {
                return v();
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginFormAnim extends StatefulWidget {
  final Widget child;
  LoginFormAnim({Key key, this.child}) : super(key: key);

  @override
  _LoginFormAnimState createState() => _LoginFormAnimState();
}

class _LoginFormAnimState extends State<LoginFormAnim>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _controller.forward();
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(begin: Offset(1, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.fastOutSlowIn,
        ),
      ),
      child: widget.child,
    );
  }
}
