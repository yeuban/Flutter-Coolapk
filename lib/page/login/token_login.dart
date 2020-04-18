import 'package:flutter/material.dart';

class TokenLogin extends StatefulWidget {
  TokenLogin({Key key}) : super(key: key);

  @override
  _TokenLoginState createState() => _TokenLoginState();
}

class _TokenLoginState extends State<TokenLogin>
    with AutomaticKeepAliveClientMixin {
  bool enable = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          _buildAgreement(),
          Divider(),
          Text("Token登录暂未完成"),
        ],
      ),
    );
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
                          "如果本软件不是由你自己(下载源码)编译的，或是来自不可信的地方，那么，即使你使用Token登录，你的账号也可能会遭到恶意盗取！出了任何问题本软件概不负责！点击“同意”按钮表示你同意接受风险~ ",
                    ),
                    WidgetSpan(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        child: Text("同意"),
                        textColor: Theme.of(context).accentColor,
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
  bool get wantKeepAlive => enable;
}
