import 'package:coolapk_flutter/network/api/feed.api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

const ThumbUpOutline24dp =
    "assets/images/coolapk/ic_thumb_up_outline_white_24dp.png";
const ThumbUp24dp = "assets/images/coolapk/ic_thumb_up_white_24dp.png";

class ThumbUpButton extends StatefulWidget {
  final dynamic feedID;
  final int initThumbNum;
  final bool initThumbState;
  ThumbUpButton(
      {Key key,
      @required this.initThumbNum,
      @required this.feedID,
      this.initThumbState = false})
      : super(key: key);

  @override
  _ThumbUpButtonState createState() => _ThumbUpButtonState();
}

class _ThumbUpButtonState extends State<ThumbUpButton> {
  bool _thumbupState;
  int _num;
  bool _inRequest = false;

  @override
  void initState() {
    _thumbupState = widget.initThumbState;
    _num = widget.initThumbNum;
    super.initState();
  }

  thumbUp() async {
    if (this._inRequest) return;
    this._inRequest = true;
    setState(() {});
    try {
      final resp = await FeedApi.thumbUp(
        feedId: widget.feedID.toString(),
        unThumbup: this._thumbupState,
      );
      String message;
      if ((message = resp["message"]) != null) {
        Toast.show(message, context, duration: 2);
      }
      final newNum = resp["data"]["count"];
      this._num = newNum;
      this._thumbupState = !_thumbupState;
    } catch (err) {} finally {
      this._inRequest = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      icon: AnimatedCrossFade(
        firstChild: ExtendedImage.asset(
          _thumbupState ? ThumbUp24dp : ThumbUpOutline24dp,
          width: 21,
          height: 21,
          filterQuality: FilterQuality.medium,
          color: this._thumbupState
              ? Theme.of(context).primaryColor
              : Theme.of(context).iconTheme.color,
        ),
        secondChild: FittedBox(
          fit: BoxFit.fitHeight,
          child: CircularProgressIndicator(),
        ),
        crossFadeState:
            _inRequest ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 300),
      ),
      label: Text(
        this._num.toString(),
        style: TextStyle(
          color: this._thumbupState
              ? Theme.of(context).primaryColor
              : Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
      onPressed: thumbUp,
    );
  }
}
