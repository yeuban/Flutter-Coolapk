import 'package:coolapk_flutter/util/image_url_size_parse.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageScaleCardItem extends StatelessWidget {
  final dynamic source;
  const ImageScaleCardItem({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: getImageRatio(source["pic"]),
        child: ExtendedImage.network(
          source["pic"],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
