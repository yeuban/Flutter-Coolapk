part of 'feed_detail.page.dart';

void handleOnLinkTap(final String url, final BuildContext context) {
  if (url.startsWith("pic=")) {
    ImageBox.push(context, urls: [url.split("=")[1]]);
  } else if (url.startsWith(RegExp(r'user=|/u/'))) {
    // TODO: handle to user space
    UserSpacePage.entry(context, url.replaceAll(RegExp(r'user=|/u/'), ""));
  } else if (url.startsWith("https://www.coolapk.com/feed/")) {
    Navigator.push(
        context,
        ScaleInRoute(
            widget: FeedDetailPage(
          url: url.split("?")[0].replaceAll("https://www.coolapk.com", ""),
        )));
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("链接内容:"),
          content: TextField(
            controller: TextEditingController(text: url),
            obscureText: false,
            autofocus: false,
            maxLines: 100,
            minLines: 1,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
