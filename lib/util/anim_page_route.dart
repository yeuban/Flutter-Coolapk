import 'package:flutter/material.dart';

class ScaleInRoute extends PageRouteBuilder {
  final Widget exitWidget;
  final Widget widget;
  ScaleInRoute({this.widget, this.exitWidget})
      : super(
          pageBuilder: (context, anim, secondaryAnim) => widget,
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (context, anim, secondaryAnim, child) {
            final widgetAnim = FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: anim,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: ScaleTransition(
                  scale: ((anim.status == AnimationStatus.forward ||
                              anim.status == AnimationStatus.completed)
                          ? Tween<double>(begin: 1.4, end: 1)
                          : Tween<double>(begin: 1.2, end: 1))
                      .animate(
                    CurvedAnimation(
                      parent: anim,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                  // child: HomePage(),
                  child: child),
            );
            if (exitWidget == null) return widgetAnim;
            final exitWidgetAnim = FadeTransition(
              opacity: Tween<double>(begin: 1, end: 0).animate(anim),
              child: ScaleTransition(
                scale: Tween<double>(begin: 1, end: .5).animate(
                  CurvedAnimation(
                    parent: anim,
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
                // child: HomePage(),
                child: exitWidget,
              ),
            );
            return Stack(
              children: <Widget>[
                exitWidgetAnim,
                widgetAnim,
              ],
            );
          },
        );
}
