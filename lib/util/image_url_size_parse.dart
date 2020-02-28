import 'package:flutter/material.dart';

Size getImageSizeFromUrl(final String url) {
  try {
    final whArr = url
        .substring(url.lastIndexOf("@") + 1, url.lastIndexOf("."))
        .split("x");
    return Size(double.parse(whArr[0]), double.parse(whArr[1]));
  } catch (err) {
    return Size(0, 0);
  }
}

double getImageRatio(final String url) {
  final size = getImageSizeFromUrl(url);
  final r = (size.width / size.height);
  return r.isNaN ? 1 : r;
}
