import 'package:coolapk_flutter/util/image_url_size_parse.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageSquareScrollCardItem extends StatelessWidget {
  final dynamic source;
  const ImageSquareScrollCardItem({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 120),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final entity = source["entities"][index];
          return AspectRatio(
            aspectRatio: getImageRatio(entity["logo"] ?? entity["pic"] ?? ""),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                child: Stack(
                  children: <Widget>[
                    ExtendedImage.network(
                      entity["logo"] ?? entity["pic"] ?? "",
                      cache: false, // TODO:
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    Container(
                      color: Colors.black.withAlpha(30),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        entity["title"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white,
                            shadows: [
                              Shadow(blurRadius: 4, color: Colors.black)
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: source["entities"].length,
      ),
    );
  }
}
