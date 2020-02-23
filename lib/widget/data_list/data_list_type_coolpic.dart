import 'dart:convert';

import 'package:coolapk_flutter/util/html_text.dart';
import 'package:coolapk_flutter/util/image_url_size_parse.dart';
import 'package:coolapk_flutter/widget/data_list/data_list.dart';
import 'package:coolapk_flutter/widget/item_adapter/auto_item_adapter.dart';
import 'package:coolapk_flutter/widget/item_adapter/items/items.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class DataListTypeCoolpic extends StatefulWidget {
  DataListTypeCoolpic({Key key}) : super(key: key);

  @override
  _DataListTypeCoolpicState createState() => _DataListTypeCoolpicState();
}

class _DataListTypeCoolpicState extends State<DataListTypeCoolpic> {
  Map<String, dynamic> extraData;

  @override
  void initState() {
    super.initState();
    final config = Provider.of<DataListConfig>(context, listen: false);

    final extraDataStr = config.data[0]["extraData"];
    extraData = jsonDecode(extraDataStr);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<DataListConfig, List<dynamic>>(
      selector: (_, final config) => config.data,
      builder: (final BuildContext context, final data, final child) {
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return data.skip(1).map((entity) {
              return AutoItemAdapter(entity: entity);
            }).toList();
          },
          body: _CoolpicList(
            config: DataListConfig(
              sourceConfig: DataListSourceConfig(url: extraData["url"]),
            ),
          ),
        );
      },
    );
  }
}

class _CoolpicList extends StatefulWidget {
  final DataListConfig config;
  _CoolpicList({Key key, this.config}) : super(key: key);

  @override
  __CoolpicListState createState() => __CoolpicListState();
}

class __CoolpicListState extends State<_CoolpicList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.config,
      child: Consumer<DataListConfig>(
        builder: (context, final config, child) => SmartRefresher(
          header: BezierCircleHeader(),
          enablePullUp: true,
          footer: ClassicFooter(),
          controller: _refreshController,
          onRefresh: () {
            widget.config.refresh().whenComplete(
                  () => _refreshController.refreshCompleted(),
                );
          },
          onLoading: () {
            if (widget.config.loadingMore) _refreshController.loadComplete();
            if (!widget.config.hasMore) {
              _refreshController.loadNoData();
              return;
            }
            if (widget.config.err != null) {
              _refreshController.loadFailed();
              return;
            }
            widget.config.nextPage().whenComplete(
                  () => _refreshController.loadComplete(),
                );
          },
          child: WaterfallFlow.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverWaterfallFlowDelegate(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: (MediaQuery.of(context).size.width / 340).floor(),
              collectGarbage: (garbages) {
                garbages.forEach((index) {
                  final url = config.data[index]["pic"];
                  final provider = ExtendedNetworkImageProvider(url);
                  provider.evict();
                });
              },
            ),
            itemCount: config.data.length,
            itemBuilder: (context, index) {
              final entity = config.data[index];
              final pic = entity["pic"] ?? "@1x1.jpg";
              final ratio = getImageRatio(pic);
              return MCard(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: ratio,
                      child: ExtendedImage.network(
                        pic,
                        cache: false, // TODO:
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                        shape: BoxShape.rectangle,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      color: Theme.of(context).cardColor,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          HtmlText(
                            html: entity["message"],
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 8)),
                          Row(
                            children: <Widget>[
                              ExtendedImage.network(
                                entity["userInfo"]["userSmallAvatar"],
                                cache: false, // TODO:
                                width: 28,
                                height: 28,
                                filterQuality: FilterQuality.low,
                                shape: BoxShape.circle,
                              ),
                              Padding(padding: const EdgeInsets.only(left: 8)),
                              Expanded(
                                child: Text(
                                  entity["username"],
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .color
                                        .withAlpha(200),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
