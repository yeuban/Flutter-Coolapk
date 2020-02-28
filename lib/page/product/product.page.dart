import 'package:coolapk_flutter/network/api/main.api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
            title: Text("PRODUCT ID: ${widget.productId}"),
          ),
        ],
        body: FutureBuilder(
          future: _fetchProductDetail(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              if (MediaQuery.of(context).size.width > 800) {
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
    );
  }

  Widget _buildSingleColumn(BuildContext context) {
    return NestedScrollViewViewport(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      slivers: <Widget>[
        SliverFillRemaining(
          child: _buildComment(),
        ),
      ],
      offset: ViewportOffset.zero(),
    );
  }

  Widget _buildSplitPage() {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildProductDetail(),
        ),
        Expanded(
          child: _buildComment(),
        ),
      ],
    );
  }

  // 产品信息
  Widget _buildProductDetail() {
    // TODO:
    return Text("TODO");
  }

  // 评论啊啥的 依赖于_detail
  Widget _buildComment() {
    // TODO:
    return Text("TODO");
  }
}
