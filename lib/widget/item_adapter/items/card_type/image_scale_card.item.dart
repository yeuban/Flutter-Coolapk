part of 'package:coolapk_flutter/widget/item_adapter/items/items.dart';

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
          cache: true,
        ),
      ),
    );
  }
}
