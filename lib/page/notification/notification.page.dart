import 'package:coolapk_flutter/network/model/notification.model.dart';
import 'package:coolapk_flutter/store/notifaction.store.dart';
import 'package:coolapk_flutter/widget/html_text.dart';
import 'package:coolapk_flutter/widget/limited_container.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

part 'notification_list.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通知"),
        actions: [
          FlatButton(
            child: Text(
              "清除通知",
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.bodyText1.color,
              ),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: NotificationList(),
    );
  }
}
