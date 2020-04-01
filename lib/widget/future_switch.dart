import 'package:flutter/material.dart';

typedef FutureFunction = Future<bool> Function(bool value);
typedef FutureSwitchBuilder = Widget Function(
    BuildContext context, bool value, dynamic error);

class FutureSwitch extends StatefulWidget {
  final FutureFunction future;
  final FutureSwitchBuilder builder;
  final bool initValue;
  final Color color;
  final Color fontColor;
  final EdgeInsets margin;
  final EdgeInsets padding;
  FutureSwitch(
      {Key key,
      this.initValue,
      this.future,
      this.builder,
      this.color,
      this.margin,
      this.padding,
      this.fontColor})
      : super(key: key);

  @override
  _FutureSwitchState createState() => _FutureSwitchState();
}

class _FutureSwitchState extends State<FutureSwitch> {
  bool _s;
  bool get s {
    if (_s == null && widget.initValue != null) {
      _s = widget.initValue;
    }
    return _s;
  }

  set s(bool value) => _s = value;

  dynamic err;
  bool i = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Material(
        color: widget.color ?? Theme.of(context).primaryColor,
        textStyle: TextStyle(
          color:
              widget.fontColor ?? Theme.of(context).textTheme.bodyText1.color,
        ),
        borderRadius: BorderRadius.circular(36),
        child: Container(
          width: 80,
          height: 36,
          child: InkWell(
            borderRadius: BorderRadius.circular(36),
            onTap: () async {
              if (i) return;
              s = !s;
              i = true;
              setState(() {});
              try {
                if (!await widget.future(s)) {
                  s = !s;
                }
              } catch (er) {
                err = er;
                s = !s;
              }
              i = false;
              setState(() {});
            },
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: AnimatedCrossFade(
                  duration: Duration(milliseconds: 300),
                  firstChild: Builder(
                    builder: (context) =>
                        widget.builder(context, i ? !s : s, err),
                  ),
                  secondChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                  crossFadeState:
                      i ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
