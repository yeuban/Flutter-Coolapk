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
  final bool inaccentColor;
  final bool isReply;

  ThumbUpButton({
    Key key,
    @required this.initThumbNum,
    @required this.feedID,
    this.initThumbState = false,
    this.inaccentColor = false,
    this.isReply = false,
  }) : super(key: key);

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
      final Map<String, dynamic> resp = await FeedApi.thumbUp(
        isReply: widget.isReply,
        feedId: widget.feedID.toString(),
        unThumbup: this._thumbupState,
      );

      String message;
      if ((message = resp["message"]) != null) {
        Toast.show(message, context, duration: 2);
        return;
      }
      final data = resp["data"];
      if (data is Map) {
        this._num = resp["data"]["count"];
      } else {
        this._num = data;
      }
      this._thumbupState = !_thumbupState;
    } catch (err) {} finally {
      this._inRequest = false;
      setState(() {});
      print("?? $_num");
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
          color: !widget.inaccentColor
              ? this._thumbupState
                  ? Theme.of(context).accentColor
                  : Theme.of(context).iconTheme.color
              : Theme.of(context).primaryTextTheme.bodyText1.color,
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
        _num == null ? "" : _num.toString(),
        style: TextStyle(
          color: widget.inaccentColor
              ? Theme.of(context).primaryTextTheme.bodyText1.color
              : this._thumbupState
                  ? Theme.of(context).accentColor
                  : Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
      onPressed: thumbUp,
    );
  }
}
