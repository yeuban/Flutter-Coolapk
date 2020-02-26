import 'dart:convert';

import 'package:coolapk_flutter/network/api/auth.api.dart';
import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/widget/common_error_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class PasswordLogin extends StatefulWidget {
  PasswordLogin({Key key}) : super(key: key);

  @override
  _PasswordLoginState createState() => _PasswordLoginState();
}

class _PasswordLoginState extends State<PasswordLogin> with AutomaticKeepAliveClientMixin {


  GlobalKey<FormState> _formKey = GlobalKey();

  String _requestHash;
  String _captchaUrl;

  Future<bool> _getRequestHash() async {
    if (_requestHash != null) return false;
    final data = await AuthApi.getRequestHash();
    _requestHash = jsonDecode(data)["requestHash"];
    return true;
  }

  bool enable = false;

  @override
  void initState() {
    super.initState();
    _captchaUrl = AuthApi.captchaUrl;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: _getRequestHash(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snap.hasError) {
          return CommonErrorWidget(
            error: snap.error,
            onRetry: () => setState(() {}),
          );
        }
        // _requestHash = snap.data["requestHash"];
        return _buildContent();
      },
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: ListView(
          children: <Widget>[]
            ..add(_buildAgreement())
            ..addAll(_buildForm()),
        ),
      ),
    );
  }

  Widget _buildCaptcha() {
    return InkWell(
      onTap: () => setState(() {
        _captchaUrl = AuthApi.captchaUrl;
      }),
      child: ExtendedImage.network(
        _captchaUrl,
        width: 130,
        cache: false, // TODO:
        headers: {
          "cookie": Network.cookieJar
              .loadForRequest(Uri.parse("https://account.coolapk.com"))
              .map((cookie) => "${cookie.name}=${cookie.value}")
              .join('; ')
        },
      ),
    );
  }

  List<Widget> _buildForm() {
    return !enable
        ? []
        : [
            TextFormField(
              autofocus: false,
              decoration: InputDecoration(labelText: "邮箱/手机号/用户名"),
              maxLines: 1,
            ),
            TextFormField(
              autofocus: false,
              decoration: InputDecoration(labelText: "密码"),
              maxLines: 1,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: "验证码",
                    ),
                    maxLines: 1,
                  ),
                ),
                _buildCaptcha(),
              ],
            ),
            const Divider(
              height: 16,
              thickness: 0,
              color: Colors.transparent,
            ),
            OutlineButton(
              child: Text("登录"),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                // TODO:
              },
            ),
            Divider(),
            Text(
              "为可能的第三方登录占位~",
              style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .color
                      .withAlpha(100)),
            ),
          ];
  }

  Widget _buildAgreement() {
    return enable
        ? const SizedBox()
        : Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 8),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                        child: Icon(
                      Icons.warning,
                      color: Colors.red,
                    )),
                    TextSpan(
                      text: "注意：",
                      style: const TextStyle(color: Colors.red),
                    ),
                    TextSpan(
                      style: Theme.of(context).textTheme.bodyText1,
                      text:
                          "如果您对该登录方法不信任或是不放心，那么我建议使用Token方式登录(相对安全)！如果该软件不是你自己编译的，或不是可信任的来源下载到本软件，请小心使用！出了任何问题本软件概不负责！点击“同意”按钮表示你同意接受风险~ ",
                    ),
                    WidgetSpan(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        child: Text("同意"),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          enable = true;
                          setState(() {});
                        },
                      ),
                    )),
                  ],
                ),
              ),
            ),
          );
  }

  @override
  bool get wantKeepAlive => _requestHash != null && enable;
}
