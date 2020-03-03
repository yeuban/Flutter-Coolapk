import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/widget/item_adapter/auto_item_adapter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part './data_list_config.dart';
part './sliver_persistent_header_delegate_impl.dart';

/// 默认顶级是一个CustomScrollView
/// 然后 在AutoItemAdapter可能也会是一个列表(SliverList)
class DataList extends StatefulWidget {
  final DataListConfig dataListConfig;
  final bool shrinkWrap;
  const DataList(this.dataListConfig, {Key key, this.shrinkWrap = false})
      : super(key: key);

  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  final refreshCtr = RefreshController(initialRefresh: true);
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.dataListConfig,
      child: Builder(
        builder: (context) {
          return Consumer<DataListConfig>(
            builder: (final BuildContext context, final DataListConfig config,
                final Widget child) {
              return SmartRefresher(
                enablePullUp: config.state != DataListConfigState.NoMore,
                controller: refreshCtr,
                footer: ClassicFooter(),
                onRefresh: () {
                  config.refresh
                      .whenComplete(() => refreshCtr.refreshCompleted());
                },
                onLoading: () {
                  if (refreshCtr.isLoading) refreshCtr.loadComplete();
                  if (config.state == DataListConfigState.NoMore)
                    refreshCtr.loadComplete();
                  config.nextPage.whenComplete(() => refreshCtr.loadComplete());
                },
                child: CustomScrollView(
                  shrinkWrap: widget.shrinkWrap,
                  slivers: config.dataList.map<Widget>((entity) {
                    return AutoItemAdapter(
                      entity: entity,
                      sliverMode: true,
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SliverDataList extends StatelessWidget {
  final DataListConfig dataListConfig;
  final EdgeInsets margin;
  final double borderRadius;
  final Color itemColor;
  const SliverDataList(
    this.dataListConfig, {
    Key key,
    this.margin,
    this.borderRadius = 8,
    this.itemColor,
  }) : super(key: key);

  Radius get radius => Radius.circular(borderRadius ?? 0);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: dataListConfig,
      child: Builder(
        builder: (context) {
          dataListConfig.init();
          return Consumer<DataListConfig>(
            builder: (final BuildContext context, final DataListConfig config,
                final Widget child) {
              return SliverPadding(
                padding: margin ?? const EdgeInsets.all(16), // 不要问 问就是不知道
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final entity = config.dataList[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: itemColor,
                            borderRadius: index == 0
                                ? BorderRadius.only(
                                    topLeft: radius,
                                    topRight: radius,
                                  )
                                : index == config.dataList.length - 1
                                    ? BorderRadius.only(
                                        bottomLeft: radius,
                                        bottomRight: radius,
                                      )
                                    : null),
                        child: AutoItemAdapter(
                          entity: entity,
                          sliverMode: false,
                        ),
                      );
                    },
                    childCount: config.dataList.length,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
