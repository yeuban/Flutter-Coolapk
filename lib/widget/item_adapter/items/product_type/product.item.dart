part of 'package:coolapk_flutter/widget/item_adapter/items/items.dart';

class ProductItem extends StatelessWidget {
  final Map<String, dynamic> source;
  const ProductItem({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: child,
      child: ListTile(
        onTap: () {},
        title: Text(source["title"]),
        subtitle:
            Text("${source["hot_num_txt"]}热度 ${source["feed_comment_num"]}讨论"),
        leading: FittedBox(
          fit: BoxFit.contain,
          child: ExtendedImage.network(
            source["logo"],
            filterQuality: FilterQuality.low,
            cache: false, // TODO:
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${source["star_average_score"]}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            RatingBar(
              initialRating: double.parse(
                source["star_average_score"].toString(),
              ),
              minRating: 0,
              maxRating: 10,
              itemCount: 5,
              itemSize: 18,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            )
          ],
        ),
      ),
    );
  }
}
