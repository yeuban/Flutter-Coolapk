import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void showQRCode(final BuildContext context, final String qrStr) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      fullscreenDialog: true,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 450),
      transitionsBuilder: (context, anim1, anim2, child) {
        final xy = Tween(begin: 0.0, end: 30.0)
            .animate(CurvedAnimation(
              parent: anim1,
              curve: Curves.fastOutSlowIn,
            ))
            .value;
        final fade = Tween<double>(begin: 0.0, end: 1).animate(CurvedAnimation(
          parent: anim1,
          curve: Curves.fastOutSlowIn,
        ));
        final scale = Tween<double>(begin: 1.4, end: 1).animate(CurvedAnimation(
          parent: anim1,
          curve: Curves.fastOutSlowIn,
        ));
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: xy,
                  sigmaY: xy,
                ),
                child: Container(
                  color: Colors.white.withOpacity(0.4 * anim1.value),
                ),
              ),
              FadeTransition(
                opacity: fade,
                child: ScaleTransition(
                  scale: scale,
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
      pageBuilder: (context, anim1, __) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 210,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "使用手机酷安扫码打开~",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    QrImage(
                      data: qrStr,
                      size: 200,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          BackButton(),
                          Text(
                            "返回",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(qrStr),
            ],
          ),
        );
      },
    ),
  );
}
