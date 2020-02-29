import 'package:coolapk_flutter/widget/data_list/data_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ProductCommentState extends ValueNotifier {
  ProductCommentState({tabIndex = 0}) : super(tabIndex);
}

class ProductComment extends StatelessWidget {
  final List<dynamic> tabList;
  final bool splitMode;
  const ProductComment({Key key, this.tabList, this.splitMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final header = Container(
      height: 50,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: ConstrainedBox(
        child: Builder(builder: (context) => _buildTabBar(context)),
        constraints: BoxConstraints(
          maxHeight: 50,
        ),
      ),
    );
    final content = Builder(
      builder: (context) => Consumer<ProductCommentState>(
        builder: (context, state, child) {
          // return _CommentDataList(
          //   url: tabList[state.value]["url"],
          //   title: tabList[state.value]["title"],
          // );
          return TabBarView(
            children: tabList.map<Widget>((tab) {
              return ProductCommentDataList(
                url: tab["url"],
                title: tab["title"],
              );
            }).toList(),
          );
        },
      ),
    );
    final stickyHeader = StickyHeader(
      overlapHeaders: true,
      header: header,
      content: content,
    );
    return DefaultTabController(
      length: tabList.length,
      child: ChangeNotifierProvider(
        create: (context) => ProductCommentState(),
        child: splitMode
            ? PrimaryScrollController(
                controller: ScrollController(),
                child: stickyHeader,
              )
            : stickyHeader,
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return TabBar(
      isScrollable: true,
      indicatorColor: Theme.of(context).primaryTextTheme.bodyText1.color,
      onTap: (index) {
        Provider.of<ProductCommentState>(context, listen: false).value = index;
      },
      tabs: tabList.map<Widget>((tab) {
        return Tab(
          text: tab["title"],
        );
      }).toList(),
    );
  }
}

class ProductCommentDataList extends StatelessWidget {
  final String url;
  final String title;
  final double paddingTop;
  final bool enableRefresh;
  const ProductCommentDataList(
      {Key key,
      this.url,
      this.title,
      this.paddingTop = 50,
      this.enableRefresh = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataListInner(
      paddingTop: paddingTop,
      enableRefresh: enableRefresh,
      data: DataListSourceConfig(
        url: url,
        title: title,
      ),
    );
  }
}
