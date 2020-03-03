part of './data_list.dart';

enum DataListTemplate {
  Tab,
  Normal,
  Grid,
}

enum DataListConfigState {
  Loading, // 加载中
  Idle, //
  Firstime, // 代表第一次
  NoMore, // 代表没有更多
}

class DataListConfig with ChangeNotifier {
  DataListTemplate _template = DataListTemplate.Normal;
  DataListTemplate get template => _template;

  bool _canRefresh = true;
  bool get canRefresh => _canRefresh;

  bool _inited = false;
  bool get inited => _inited;

  int _page = 1;
  int get page => _page;

  String _errMsg;
  String get errMsg => _errMsg ?? "";
  bool get hasErr => errMsg != null;

  List _dataList = [];
  List get dataList => _dataList;

  bool _needFirstItem = true;
  bool _needLastItem = true;

  Future<void> init() async {
    if (_inited || state == DataListConfigState.Loading) return;
    _inited = true;
    return await refresh;
  }

  String get firstItem {
    if (dataList.length == 0) return null;
    return dataList
        .firstWhere((entity) =>
            (entity["entityId"]?.toString()?.length ?? 0) >= 4 &&
            entity["entityTemplate"] != "imageCarouselCard_1" &&
            entity["entityTemplate"] != "iconLinkGridCard")["entityId"]
        ?.toString();
  }

  String get lastItem {
    if (dataList.length == 0) return null;
    return dataList
        .lastWhere((entity) =>
            (entity["entityId"]?.toString()?.length ?? 0) >= 4)["entityId"]
        ?.toString();
  }

  String _requestPath;
  Map<String, String> _requestExtParam = {};

  DataListConfigState state = DataListConfigState.Firstime;

  DataListConfig({String title = "", @required String url}) {
    this._requestExtParam = {
      "title": title,
    };
    if (url.startsWith("#/") || url.startsWith("/feed/")) {
      this._requestPath = "/page/dataList?url=${Uri.encodeComponent(url)}";
    } else {
      this._requestPath = url
          ?.replaceAll("/page?", "/page/dataList?")
          ?.replaceAll("/main/headline", "/main/indexV8");
    }
    if (this._requestPath.startsWith(r'/user/dyhSubscribe'))
      _needFirstItem = false;
  }

  Future<void> get nextPage => _fetchData(nextPage: true);
  Future<void> get refresh => _fetchData(refresh: true);

  Future<void> _fetchData({nextPage = true, final refresh = false}) async {
    if (refresh) {
      _page = 1;
      _dataList.clear();
      nextPage = false;
    } else if (nextPage) {
      _page++;
    }
    state = DataListConfigState.Loading;
    notifyListeners();
    try {
      final resp = await Network.apiDio.get(
        _requestPath,
        queryParameters: {
          "page": page,
        }
          ..addAll(_requestExtParam)
          ..addAll(_needFirstItem && dataList.length > 0
              ? {
                  "firstItem": firstItem,
                }
              : {})
          ..addAll(_needLastItem
              ? {
                  "lastItem": lastItem,
                }
              : {}),
      );
      final _data = resp.data["data"] as List<dynamic>;
      if (_data.length <= 0)
        state = DataListConfigState.NoMore; // 如果没有数据了，设置NoMore
      if (page == 1) {
        _data.every((entity) {
          // 如果包含以下item,则设置NoMore
          final _entityTemplate = entity["entityTemplate"];
          if (_entityTemplate == "iconTabLinkGridCard" ||
              _entityTemplate == "selectorLinkCard") {
            state = DataListConfigState.NoMore;
            _template = DataListTemplate.Tab;
            _canRefresh = false;
            _data.removeRange(_data.indexOf(entity) + 1, _data.length);
            return false;
          }
          return true;
        });
      }
      _dataList.addAll(_data);
    } catch (err, stack) {
      debugPrintStack(stackTrace: stack);
      _errMsg = err.toString();
    } finally {
      if (state != DataListConfigState.NoMore) state = DataListConfigState.Idle;
      notifyListeners();
    }
  }
}
