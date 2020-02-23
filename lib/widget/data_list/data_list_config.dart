part of './data_list.dart';

enum DataListType {
  Normal,
  Tab, // entityTemplate=iconTabLinkGridCard
  SelectorLinkCard, // entityTemplate=selectorLinkCard 话题页
  Coolpic, // 酷图页...
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
    if (url.startsWith("#/") || url.startsWith("/feed/")) {
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
              (element["entityId"]?.toString()?.length ?? 0) >= 4 &&
              element["entityTemplate"] != "imageCarouselCard_1" &&
              element["entityTemplate"] != "iconLinkGridCard")["entityId"]
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
            hasMore = false;
            return;
          case "selectorLinkCard":
            type = DataListType.SelectorLinkCard;
            hasMore = false;
            return;
        }
      });
      if (title == "酷图") {
        type = DataListType.Coolpic;
      }
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
    bool tempNeedLastItem = needLastItem;
    needLastItem = false;
    notifyListeners();
    try {
      await _fetchData();
    } catch (err, stack) {
      this.err = err;
      debugPrintStack(stackTrace: stack);
    }
    loading = false;
    hasMore = true;
    needLastItem = tempNeedLastItem;
    notifyListeners();
    return true;
  }
}
