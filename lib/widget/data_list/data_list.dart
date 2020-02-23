import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/widget/common_error_widget.dart';
import 'package:coolapk_flutter/widget/data_list/common.widget.dart';
import 'package:coolapk_flutter/widget/item_adapter/auto_item_adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

part './data_list_type_tab.dart';
part './data_list_type_normal.dart';
part './data_list_type_selector.dart';
part './data_list_config.dart';
part './sliver_persistent_header_delegate_impl.dart';
part './data_list_inner.dart';

// // 通常要判断一下是直接的列表数据url 还是页面url
//  /dyh
//  #/dyh  页面
// /user/dyhFollowList 固定样式类型页面 title=我订阅的看看号
class DataList extends StatefulWidget {
  final dynamic data;
  DataList({Key key, @required this.data}) : super(key: key);

  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  DataListConfig _dataListConfig;

  @override
  void initState() {
    super.initState();
    _dataListConfig = DataListConfig(sourceConfig: widget.data);
    // _dataListConfig.refresh(); 在子空间里刷新...
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _dataListConfig,
      child: Builder(
        builder: (context) {
          final config = Provider.of<DataListConfig>(context, listen: true);
          final type = config.type;
          Widget view;
          if (config.err != null)
            view = CommonErrorWidget(
              error: config.err,
              onRetry: config.refresh,
            );
          switch (type) {
            case DataListType.Normal:
              view = DataListTypeNormal();
              break;
            case DataListType.Tab:
              view = DataListTypeTab();
              break;
            case DataListType.SelectorLinkCard:
              view = DataListTypeSelector();
              break;
          }
          return view;
        },
      ),
    );
    // return DataListTypeNormal();
  }
}
