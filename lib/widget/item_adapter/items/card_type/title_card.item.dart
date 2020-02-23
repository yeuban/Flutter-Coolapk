import 'package:flutter/material.dart';

class TitleCardItem extends StatelessWidget {
  final Map<String, dynamic> source;
  const TitleCardItem({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final url = source["url"];
    final title = source["title"];
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            url.toString().length > 0
                ? IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      // TODO:
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
      onTap: () {
        // TODO:
      },
    );
  }
}
