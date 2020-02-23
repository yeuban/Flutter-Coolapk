import 'package:coolapk_flutter/network/api/main.api.dart';
import 'package:coolapk_flutter/network/model/main_init.model.dart'
    as MainInitModel;
import 'package:coolapk_flutter/page/home/tab_page.dart';
import 'package:coolapk_flutter/widget/common_error_widget.dart';
import 'package:coolapk_flutter/page/home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Map<int, PageController> _controllerMap = {
    14468: PageController(initialPage: 0),
    6390: PageController(initialPage: 1),
  };

  List<MainInitModel.MainInitModelData> _mainInitModelData;

  Future<bool> getMainInitModelData() async {
    if (_mainInitModelData != null) return true;
    _mainInitModelData = (await MainApi.getInitConfig()).data;
    return true;
  }

  List<MainInitModel.MainInitModelData> get _pageConfigs =>
      _mainInitModelData
          ?.where((element) =>
              element.entityTemplate == "configCard" &&
              element.entityType == "card")
          ?.toList() ??
      [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getMainInitModelData(),
        builder: (context, snap) {
          if (snap.hasError) {
            return CommonErrorWidget(
              error: snap.error,
              onRetry: () {
                setState(() {});
              },
            );
          }
          if (snap.hasData) {
            return _buildFrame();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _gotoTab(int pageEntityId, int page) {
    _controllerMap[pageEntityId].jumpToPage(page);
    // duration: Duration(milliseconds: 700), curve: Curves.easeOutQuart);
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controllerMap.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  GlobalKey<HomePageDrawerState> _homePageDrawerStateKey = GlobalKey();

  Widget _buildFrame() {
    final width = MediaQuery.of(context).size.width;
    final tight = MediaQuery.of(context).size.width < 740;
    final drawer = HomePageDrawer(
      key: _homePageDrawerStateKey,
      tabConfigs: _pageConfigs,
      gotoTab: _gotoTab,
    );
    final innerDrawer = <Widget>[
      // only !tight
      Container(
        width: width < 1000 ? 223 : 334,
        child: drawer,
      ),
      const VerticalDivider(
        width: 2,
      ),
    ];
    return Provider.value(
      value: TabController(vsync: this, length: 2),
      child: Builder(
        builder: (context) => Scaffold(
          drawer: tight ? drawer : null,
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: !tight ? innerDrawer : <Widget>[]
              ..add(
                Expanded(
                  child: Center(child: _buildContent(context)),
                ),
              ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(final BuildContext context) {
    return TabBarView(
        controller: Provider.of<TabController>(context, listen: false),
        children: _pageConfigs.map<Widget>((pageConfig) {
          return Container(
            child: PageView(
              onPageChanged: (newPage) {
                _homePageDrawerStateKey?.currentState?.onGotoTab(
                    _pageConfigs.indexOf(pageConfig), (newPage).floor());
              },
              physics: BouncingScrollPhysics(),
              controller: _controllerMap[pageConfig.entityId],
              children: pageConfig.entities.map<Widget>((pageTab) {
                return TabPage(data: pageTab);
              }).toList(),
            ),
          );
        }).toList());
  }
}
