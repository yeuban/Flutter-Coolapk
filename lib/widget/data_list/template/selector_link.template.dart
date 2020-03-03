import 'dart:convert';

import 'package:coolapk_flutter/widget/data_list/data_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class SelectorLinkTemplate extends StatefulWidget {
  final dynamic source;
  SelectorLinkTemplate(this.source, {Key key}) : super(key: key);

  @override
  _SelectorLinkTemplateState createState() => _SelectorLinkTemplateState();
}

class _SelectorLinkTemplateState extends State<SelectorLinkTemplate>
    with TickerProviderStateMixin {
  int _nowTab = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final nowEntity = widget.source["entities"][_nowTab];
    return SliverStickyHeader(
      header: SizedBox(
        height: 44,
        child: Material(
          elevation: 4,
          color: Theme.of(context).cardColor,
          child: TabBar(
            isScrollable: true,
            unselectedLabelColor:
                Theme.of(context).textTheme.subtitle1.color.withAlpha(180),
            labelColor: Theme.of(context).textTheme.subtitle1.color,
            controller: TabController(
              vsync: this,
              length: widget.source["entities"].length,
            ),
            tabs: widget.source["entities"].map<Widget>((tab) {
              return Tab(
                text: tab["title"],
              );
            }).toList(),
          ),
        ),
      ),
      sliver: SliverDataList(
        DataListConfig(
          url: nowEntity["url"],
          title: nowEntity["title"],
        ),
        itemColor: Theme.of(context).cardColor,
        borderRadius: 8,
      ),
    );
  }
}
