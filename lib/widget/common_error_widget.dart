import 'package:flutter/material.dart';

class CommonErrorWidget extends StatelessWidget {
  final dynamic error;
  final Function onRetry;
  const CommonErrorWidget({Key key, this.error, this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme:
            IconThemeData(color: Theme.of(context).textTheme.bodyText1.color),
        title: Text(
          "出错",
          style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.error,
              color: Colors.redAccent,
              size: 64,
            ),
            const Padding(
              padding: const EdgeInsets.only(bottom: 8),
            ),
            Text(
              error?.toString() ?? "未知错误",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 166),
              child: const Divider(
                height: 55,
              ),
            ),
            OutlineButton(
              child: const Text("重试"),
              onPressed: onRetry ?? () {},
            ),
          ],
        ),
      ),
    );
  }
}
