part of 'package:coolapk_flutter/widget/item_adapter/items/items.dart';

class IconLinkGridCard extends StatelessWidget {
  final Map<String, dynamic> source;

  const IconLinkGridCard({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: source["entities"].length > 5
            ? CrossAxisAlignment.stretch
            : CrossAxisAlignment.center,
        children: [
          (source["title"] ?? "").length > 0
              ? ItemTitle(title: source["title"])
              : const SizedBox(),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: source["entities"].map<Widget>((entity) {
              return InkWell(
                onTap: () {},
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 70),
                  child: AspectRatio(
                    aspectRatio: .9,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ExtendedImage.network(
                              entity["pic"] ?? entity["logo"],
                              cache: Platform.isAndroid || Platform.isIOS,
                              shape: BoxShape.rectangle,
                              filterQuality: FilterQuality.low,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        Text(
                          entity["title"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
