import 'package:flutter/material.dart';
import 'package:emoji_picker/emoji_lists.dart' as emojiList;

class EmojiPanel extends StatelessWidget {
  const EmojiPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    emojiList.smileys.forEach((key, value) => () {}());
    return Container(
      child: Text("还未实现"),
    );
  }
}
