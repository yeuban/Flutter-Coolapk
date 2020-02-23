import 'package:coolapk_flutter/widget/data_list/common.widget.dart';
import 'package:coolapk_flutter/widget/data_list/data_list.dart';
import 'package:coolapk_flutter/widget/item_adapter/auto_item_adapter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataListInner extends StatefulWidget {
  final dynamic data;
  final double paddingTop;
  DataListInner({Key key, this.data, this.paddingTop}) : super(key: key);

  @override
  _DataListInnerState createState() => _DataListInnerState();
}

class _DataListInnerState extends State<DataListInner> {
  DataListConfig _dataListConfig;

  @override
  void initState() {
    super.initState();
    _dataListConfig = DataListConfig(
      sourceConfig: widget.data,
      needFirstItem: false,
    );
  }

  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  // void _checkAndNextPage() {
  //   if (_dataListConfig.hasMore &&
  //       !_dataListConfig.loading &&
  //       !_dataListConfig.loadingMore &&
  //       _scrollController.position.pixels >=
  //           _scrollController.position.maxScrollExtent) {
  //     _dataListConfig.nextPage();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _dataListConfig,
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _dataListConfig?.refresh,
        child: Builder(
          builder: (context) => Consumer<DataListConfig>(
              builder: (context, final config, final child) {
            if (!config.inited) {
              _refreshIndicatorKey?.currentState?.show();
            }
            if (config.data.length == 0 && !config.loading) {
              return Center(
                child: Text(
                  "这里没有内容~",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              );
            }
            return CustomScrollView(
              // controller: _scrollController,
              slivers: [
                SliverPadding(
                    padding: EdgeInsets.only(top: widget.paddingTop ?? 0))
              ]
                ..addAll(_buildItems(config))
                ..addAll(_buildLoadingWidget(config)),
            );
          }),
        ),
      ),
    );
  }

  List<Widget> _buildItems(final config) {
    return config.data.map<Widget>((entity) {
      return AutoItemAdapter(
        entity: entity,
        sliverMode: true,
      );
    }).toList();
  }

  List<Widget> _buildLoadingWidget(final config) {
    return config.loadingMore
        ? [
            SliverToBoxAdapter(
              child: Material(
                elevation: 16,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: Text("加载中..."),
                ),
              ),
            )
          ]
        : [];
  }
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
