import 'package:flutter/material.dart';

class AnimPageRoute extends StatefulWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget target;
  AnimPageRoute({Key key, this.animation, this.secondaryAnimation, this.target})
      : super(key: key);

  @override
  _AnimPageRouteState createState() => _AnimPageRouteState();

  static use(BuildContext context, Widget target) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AnimPageRoute(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        target: target,
      ),
      transitionDuration: Duration(milliseconds: 700),
    );
  }
}

class _AnimPageRouteState extends State<AnimPageRoute> {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.animation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.6, end: 1).animate(
          CurvedAnimation(
              parent: widget.animation, curve: Curves.fastOutSlowIn),
        ),
        // child: HomePage(),
        child: widget.target,
      ),
    );
  }
}
