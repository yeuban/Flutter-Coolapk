import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/widget/common_error_widget.dart';
import 'package:coolapk_flutter/widget/data_list/common.widget.dart';
import 'package:coolapk_flutter/widget/data_list/data_list_type_selector.dart';
import 'package:coolapk_flutter/widget/item_adapter/auto_item_adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

part './data_list_type_tab.dart';
part './data_list_type_normal.dart';

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

const emptyMap = {};

enum DataListType {
  Normal,
  Tab, // entityTemplate=iconTabLinkGridCard
  SelectorLinkCard // entityTemplate=selectorLinkCard 话题页
}

class DataListSourceConfig {
  final String url;
  final String title;
  DataListSourceConfig({this.url, this.title = ""});
}

class DataListConfig with ChangeNotifier {
  bool inited = false;

  dynamic sourceConfig;

  dynamic err;

  DataListType type = DataListType.Normal;

  bool needFirstItem;
  bool needLastItem;
  String get path {
    final url = sourceConfig?.url?.toString();
    this.title = sourceConfig?.title ?? "";
    if (url.startsWith("#/")) {
      return "/page/dataList?url=${Uri.encodeComponent(url)}";
    }
    return url
        ?.replaceAll("/page?", "/page/dataList?")
        ?.replaceAll("/main/headline", "/main/indexV8");
  }

  String title = "";
  Map<String, dynamic> headerBase = {};
  Map<String, dynamic> paramBase = {};

  List<dynamic> data = [];
  int page = 1;
  bool loading = false;
  bool loadingMore = false;
  bool hasMore = true;

  String get firstItem => data.length > 0
      ? data
          .firstWhere((element) =>
              (element["entityId"]?.toString()?.length ?? 0) >= 4)["entityId"]
          ?.toString()
      : null;
  String get lastItem => data.length > 0
      ? data
          ?.lastWhere((element) =>
              (element["entityId"]?.toString()?.length ?? 0) >= 4)["entityId"]
          ?.toString()
      : null;

  DataListConfig(
      {this.sourceConfig, this.needFirstItem = true, this.needLastItem = true});

  Future<dynamic> _fetchData() async {
    final response = (await Network.apiDio.get(path,
        queryParameters: {}
          ..addAll(paramBase)
          ..addAll(
            {"page": page, "title": title}
              ..addAll(
                needFirstItem && data.length > 0
                    ? {"firstItem": firstItem}
                    : {},
              )
              ..addAll(
                needLastItem && data.length > 0 ? {"lastItem": lastItem} : {},
              ),
          ),
        options: Options(
          headers: headerBase,
        )));
    debugPrint("""\n
      DATA:    ${response.data["data"].length}
      PATH:    ${response.request.path}
      PARAM:   ${response.request.queryParameters}\n
    """);
    final List<dynamic> d = _process(response.data["data"] as List<dynamic>);
    if (d.length <= 0) {
      hasMore = false;
    }
    data.addAll(d);
  }

  List<dynamic> _process(final tempData) {
    if (page == 1) {
      tempData.forEach((entity) {
        switch (entity["entityTemplate"]) {
          case "iconTabLinkGridCard":
            type = DataListType.Tab;
            return;
          case "selectorLinkCard":
            type = DataListType.SelectorLinkCard;
            return;
        }
      });
    }
    if (path.startsWith(r'/user/dyhSubscribe')) needFirstItem = false;
    return tempData;
  }

  Future<bool> nextPage() async {
    if (loading || loadingMore) return false;
    loading = true;
    loadingMore = true;
    page++;
    notifyListeners();
    try {
      await _fetchData();
    } catch (err, stack) {
      this.err = err;
      debugPrintStack(stackTrace: stack);
    }
    loading = false;
    loadingMore = false;
    notifyListeners();
    return true;
  }

  Future<bool> refresh() async {
    if (loading) return false;
    this.err = null;
    loading = true;
    loadingMore = false;
    page = 1;
    data.clear();
    inited = true;
    notifyListeners();
    try {
      await _fetchData();
    } catch (err, stack) {
      this.err = err;
      debugPrintStack(stackTrace: stack);
    }
    loading = false;
    hasMore = true;
    notifyListeners();
    return true;
  }
}
