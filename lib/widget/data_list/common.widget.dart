import 'package:flutter/material.dart';

Widget buildLoadingWidgetInStack() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Material(
      elevation: 16,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: Text("加载中..."),
      ),
    ),
  );
}
