import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String url;
  final dynamic heroTag;
  const ImageBox({Key key, @required this.url, this.heroTag = "hero tag"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          child: ExtendedImage.network(url),
          tag: heroTag,
        ),
      ),
    );
  }
}
