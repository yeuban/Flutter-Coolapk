part of 'package:coolapk_flutter/widget/item_adapter/items/items.dart';

class ItemTitle extends StatelessWidget {
  final String title;
  final String url;
  const ItemTitle({Key key, this.title, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
