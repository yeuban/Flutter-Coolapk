import 'package:carousel_slider/carousel_slider.dart';
import 'package:coolapk_flutter/network/api/main.api.dart';
import 'package:coolapk_flutter/util/image_url_size_parse.dart';
import 'package:coolapk_flutter/widget/item_adapter/items/items.dart';
import 'package:coolapk_flutter/widget/primary_button.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
            floating: false,
            snap: false,
            pinned: true,
            title: Text(
              (_detail ?? const {"title": ""})["title"],
            ),
          ),
        ]..addAll(
            (MediaQuery.of(context).size.width <= 860 && _detail != null)
                ? _buildProductDetail()
                : [],
          ),
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
          child: CustomScrollView(
            slivers: _buildProductDetail(),
          ),
        ),
        const VerticalDivider(width: 2),
        Expanded(
          child: _buildComment(),
        ),
      ],
    );
  }

  // 产品信息
  // slivers
  List<Widget> _buildProductDetail() {
    return <Widget>[
      SliverToBoxAdapter(
        child: _buildCover(),
      ),
      SliverPadding(
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        sliver: SliverToBoxAdapter(
          child: Container(
            height: 66,
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                ExtendedImage.network(
                  _detail["logo"],
                  cache: false, // TODO:
                  width: 58,
                  height: 58,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                ),
                const VerticalDivider(color: Colors.transparent),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        _detail["title"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        "${_detail["hot_num_txt"]}热度 ${_detail["feed_comment_num"]}讨论",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        sliver: SliverToBoxAdapter(
          child: Row(
            children: ((_detail["recent_follow_list"] as List<dynamic>)
                .map<Widget>((user) {
              return ExtendedImage.network(
                user["userAvatar"],
                cache: false, // TODO:
                shape: BoxShape.circle,
                width: 24, height: 24,
              );
            }).toList())
              ..addAll([
                const VerticalDivider(color: Colors.transparent),
                Expanded(child: Text("${_detail["follow_num"]}关注>")),
                PrimaryButton(
                  text: "关注",
                  onPressed: () {
                    // TODO:
                  },
                ),
              ]),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: _buildCoolapkRating(),
      ),
      (_detail["description"] ?? "").length == 0
          ? const SliverToBoxAdapter(child: SizedBox())
          : SliverPadding(
              padding: const EdgeInsets.all(16).copyWith(top: 0),
              sliver: SliverToBoxAdapter(
                child: Text(_detail["description"] ?? ""),
              ),
            ),
      SliverToBoxAdapter(
        child: _buildProductTag(),
      ),
      SliverToBoxAdapter(
        child: _buildProductBranch(),
      ),
      SliverToBoxAdapter(
        child: _buildCoolapkRatingDetail(),
      ),
    ];
  }

  // 评论啊啥的 依赖于_detail
  Widget _buildComment() {
    // TODO:
    return Text("TODO");
  }

  Widget _buildCover() {
    final covers = _detail["coverArr"];
    if (covers.length == 0) {
      return const SizedBox();
    }
    final height = getImageSizeFromUrl(covers[0]).height;
    return CarouselSlider.builder(
      itemCount: covers.length,
      viewportFraction: 1.0,
      autoPlay: false,
      height: height > 300 ? 300 : height,
      itemBuilder: (final context, final index) {
        return InkWell(
          child: ExtendedImage.network(
            covers[index],
            fit: BoxFit.cover,
            width: double.infinity,
            cache: false, // TODO:
          ),
        );
      },
    );
  }

  Widget _buildProductTag() {
    if ((_detail["tagArr"] ?? []).length == 0) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      child: Wrap(
        spacing: 16,
        children: (_detail["tagArr"] as Iterable<dynamic>).map<Widget>((tag) {
          return Chip(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            backgroundColor: Theme.of(context).primaryColor.withAlpha(40),
            label: Text(
              tag,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductBranch() {
    if ((_detail["configRows"] ?? []).length == 0) {
      return const SizedBox();
    }
    return MCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "版本配置",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )
        ]..addAll((_detail["configRows"] as Iterable<dynamic>)
              .map<Widget>((config) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              margin: const EdgeInsets.only(top: 16),
              child: ListTile(
                onTap: () {
                  // TODO:
                },
                title: Text(
                  config["title"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                trailing: SizedBox(
                  height: 24,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "￥${config["price"]}",
                      style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withAlpha(100),
                          fontSize: 18),
                      children: [
                        WidgetSpan(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 22,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList()),
      ),
    );
  }

  Widget _buildCoolapkRatingDetail() {
    return MCard(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "酷安评分",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      _detail["rating_average_score"].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 38,
                      ),
                    ),
                    RatingBar(
                      tapOnlyMode: true,
                      maxRating: 10,
                      minRating: 0,
                      initialRating: _detail["rating_average_score"].toDouble(),
                      onRatingUpdate: (value) {},
                      itemCount: 5,
                      itemSize: 18,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    const Divider(
                      color: Colors.transparent,
                      height: 4,
                    ),
                    Text(
                      " ${_detail["rating_total_num"]}人点评",
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withAlpha(100),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: (<int>[1, 2, 3, 4, 5]).map<Widget>((e) {
                    final count = _detail["star_${e}_count"];
                    final total = _detail["star_total_count"];
                    return Row(
                      children: <Widget>[
                        Text("$e\星"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: LinearProgressIndicator(
                              value: count / total,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: (<int>[1, 2, 3, 4, 5]).map<Widget>((e) {
                  return Text(
                    _detail["star_${e}_count"].toString(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCoolapkRating() {
    return MCard(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "酷安评分",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                _detail["rating_average_score"].toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
              ),
              const VerticalDivider(color: Colors.transparent),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RatingBar(
                      tapOnlyMode: true,
                      maxRating: 10,
                      minRating: 0,
                      initialRating: _detail["rating_average_score"].toDouble(),
                      onRatingUpdate: (value) {},
                      itemCount: 5,
                      itemSize: 18,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    Text(" ${_detail["rating_total_num"]}人点评")
                  ],
                ),
              ),
              PrimaryButton(
                text: "加我一个",
                onPressed: () {
                  // TODO:
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
