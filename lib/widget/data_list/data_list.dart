import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/widget/data_list/template/template.dart';
import 'package:coolapk_flutter/widget/item_adapter/auto_item_adapter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

part './data_list_config.dart';
part './sliver_persistent_header_delegate_impl.dart';

class DataListPage extends StatefulWidget {
  final DataListConfig dataListConfig;
  final bool shrinkWrap;
  const DataListPage(this.dataListConfig, {Key key, this.shrinkWrap = false})
      : super(key: key);

  @override
  _DataListPageState createState() => _DataListPageState();
}

class _DataListPageState extends State<DataListPage> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.dataListConfig.init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.dataListConfig,
      child: Builder(
        builder: (context) {
          return Selector<DataListConfig, DataListTemplate>(
            selector: (_, listConfig) => listConfig.template,
            builder: (context, template, child) {
              if (widget.dataListConfig.state == DataListConfigState.Firstime) {
                Future.delayed(Duration(milliseconds: 1))
                    .then((value) => widget.dataListConfig.init());
              }
              switch (template) {
                case DataListTemplate.Loading:
                  return Center(child: CircularProgressIndicator());
                  break;
                case DataListTemplate.Tab:
                  return TabTemplate();
                  break;
                case DataListTemplate.Normal:
                  return NormalTemplate();
                  break;
                case DataListTemplate.Grid:
                  return GridTemplate();
                  break;
                case DataListTemplate.Coolpic:
                  return CoolpicTemplate();
                default:
                  return NormalTemplate();
              }
            },
          );
        },
      ),
    );
  }
}

//  一般是嵌套用的
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
                          onRequireDeleteItem: (entity) {
                            config.dataList.removeWhere((element) =>
                                element["entityId"] == entity["entityId"]);
                            config.notifyChanged;
                          },
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
