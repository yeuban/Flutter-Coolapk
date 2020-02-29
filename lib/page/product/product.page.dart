import 'package:coolapk_flutter/network/api/main.api.dart';
import 'package:coolapk_flutter/page/product/comment.dart';
import 'package:coolapk_flutter/page/product/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({Key key, this.productId}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Map<String, dynamic> _detail;

  Future<bool> _fetchProductDetail() async {
    if (_detail != null) return true;
    try {
      _detail = await MainApi.getProductDetail(widget.productId);
      setState(() {});
    } catch (err) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("未知错误:\n${err.toString()}\n请尝试重试~"),
      ));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            title: Text(
              (_detail ?? const {"title": ""})["title"],
            ),
          ),
        ],
        body: FutureBuilder(
          future: _fetchProductDetail(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              if (MediaQuery.of(context).size.width > 860) {
                return _buildSplitPage();
              } else {
                return _buildSingleColumn(context);
              }
            } else if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                child: Text("EMMMM...."),
              );
            }
          },
        ),
      ),
      bottomSheet: (MediaQuery.of(context).size.width <= 860 && _detail != null)
          ? _buildBottomSheet(context)
          : null,
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    final tabList = _detail["tabList"];
    return DefaultTabController(
      length: _detail["tabList"].length,
      child: Builder(
        builder: (context) {
          return SolidBottomSheet(
            elevation: 8,
            body: TabBarView(
              children: tabList.map<Widget>((tab) {
                return ProductCommentDataList(
                  paddingTop: 0,
                  url: tab["url"],
                  title: tab["title"],
                  // enableRefresh: false,
                );
              }).toList(),
            ),
            // body: ProductCommentDataList(
            //   key: Key(DefaultTabController.of(context).index.toString()),
            //   paddingTop: 0,
            //   url: tabList[DefaultTabController.of(context).index]["url"],
            //   title: tabList[DefaultTabController.of(context).index]["title"],
            //   enableRefresh: false,
            // ),
            headerBar: Container(
              height: 50,
              color: Theme.of(context).primaryColor,
              alignment: Alignment.center,
              child: TabBar(
                isScrollable: true,
                indicatorColor:
                    Theme.of(context).primaryTextTheme.bodyText1.color,
                tabs: tabList.map<Widget>((tab) {
                  return Tab(
                    text: tab["title"],
                  );
                }).toList(),
              ),
            ),
            maxHeight: MediaQuery.of(context).size.height - 50,
            minHeight: 0,
            draggableBody: true,
            canUserSwipe: true,
            autoSwiped: true,
            toggleVisibilityOnTap: true,
          );
        },
      ),
    );
  }

  Widget _buildSingleColumn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: ProductDetail(detail: _detail),
    );
  }

  Widget _buildSplitPage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ProductDetail(detail: _detail),
        ),
        Expanded(
          child: ProductComment(
            splitMode: true,
            tabList: _detail["tabList"],
          ),
        ),
      ],
    );
  }
}
