part of './data_list.dart';

class DataListTypeSelector extends StatefulWidget {
  DataListTypeSelector({Key key}) : super(key: key);

  @override
  _DataListTypeSelectorState createState() => _DataListTypeSelectorState();
}

class _DataListTypeSelectorState extends State<DataListTypeSelector>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<dynamic> _selectorLinkCardEntityList; //
  Map<String, dynamic> _configCard; //
  List<dynamic> _configCardEntities; // tabs entity

  // ScrollController _primaryScrollController;

  List<GlobalKey<__SelectorTabPageState>> _selectorTabPageStates = [];

  SliverOverlapAbsorberHandle _sliverOverlapAbsorberHandle;

  @override
  void initState() {
    super.initState();

    _selectorLinkCardEntityList =
        Provider.of<DataListConfig>(context, listen: false).data; // 首先获取data列表

    _configCard =
        _selectorLinkCardEntityList.firstWhere(// 然后获取selectorLinkCard的数据
                (element) => element["entityTemplate"] == "selectorLinkCard")
            as Map<String, dynamic>;
    _configCardEntities = _configCard["entities"];

    _tabController = TabController(
      //  配置tabController
      vsync: this,
      length: _configCardEntities.length,
    );

    _selectorLinkCardEntityList.removeRange(
      // 移除多余部分
      _selectorLinkCardEntityList.indexWhere(
          ((element) => element["entityTemplate"] == "selectorLinkCard")),
      _selectorLinkCardEntityList.length,
    );

    for (var i = 0; i < _configCardEntities.length; i++) {
      _selectorTabPageStates.add(GlobalKey());
    }
  }

  void _callTabPagesNextPage() {
    // if (_primaryScrollController.position.pixels >=
    //     _primaryScrollController.position.maxScrollExtent) {
    //   // print(
    //   //     "${_selectorTabPageStates[_tabController.index].currentState == null}");
    //   _selectorTabPageStates[_tabController.index]
    //       .currentState
    //       ?.checkAndNextPage();
    // }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    // _primaryScrollController.dispose();
    _sliverOverlapAbsorberHandle.dispose();
  }

  double get _tabHeight {
    return const TabBar(
          tabs: const <Widget>[],
        ).preferredSize.height +
        16;
  }

  List<Widget> _buildHeaderSliver(context, final data) {
    List<Widget> widgets = [];
    widgets.addAll(_selectorLinkCardEntityList.map<Widget>((entity) {
      return AutoItemAdapter(
        entity: entity,
        sliverMode: true,
      );
    }).toList());
    widgets.add(
      SliverPadding(
        padding: const EdgeInsets.only(top: 1),
      ),
    );
    widgets.add(_buildTabBar(context));
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<DataListConfig, List<dynamic>>(
      selector: (_, final config) => config.data,
      builder: (final BuildContext context, final data, final child) {
        return NestedScrollView(
          controller: PrimaryScrollController.of(context),
          headerSliverBuilder: (context, _) =>
              _buildHeaderSliver(context, data),
          body: Builder(
            builder: (context) {
              return NestedScrollViewViewport(
                handle: _sliverOverlapAbsorberHandle ??
                    (() {
                      _sliverOverlapAbsorberHandle =
                          NestedScrollView.sliverOverlapAbsorberHandleFor(
                              context);
                      return _sliverOverlapAbsorberHandle;
                    })(),
                offset: ViewportOffset.zero(),
                slivers: <Widget>[
                  SliverFillRemaining(
                    child: _buildContent(context),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildContent(final BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: _configCardEntities.map<Widget>((entity) {
        return _SelectorTabPage(
          key: _selectorTabPageStates[_configCardEntities.indexOf(entity)],
          entity: entity,
          paddingTop: _tabHeight,
        );
      }).toList(),
    );
  }

  Widget _buildTabBar(final BuildContext context) {
    return SliverOverlapAbsorber(
      handle: _sliverOverlapAbsorberHandle ??
          NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverPersistentHeader(
        floating: true,
        pinned: true,
        delegate: SliverPersistentHeaderDelegateImpl(
          child: PreferredSize(
            preferredSize: Size(double.infinity, _tabHeight),
            child: Material(
              elevation: 4,
              shadowColor: Colors.black.withAlpha(100),
              color: Theme.of(context).cardColor,
              child: Center(
                child: TabBar(
                  controller: _tabController,
                  labelColor:
                      Theme.of(context).primaryTextTheme.bodyText1.color,
                  unselectedLabelColor:
                      Theme.of(context).textTheme.bodyText1.color,
                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadiusDirectional.circular(_tabHeight),
                    color: Theme.of(context).primaryColor,
                  ),
                  tabs: _buildTabs(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabs() {
    return _configCardEntities.map<Widget>((entity) {
      return Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        child: Tab(text: entity["title"]),
      );
    }).toList();
  }
}

class _SelectorTabPage extends StatefulWidget {
  final dynamic entity;
  final double paddingTop;

  const _SelectorTabPage({Key key, this.entity, this.paddingTop})
      : super(key: key);

  @override
  __SelectorTabPageState createState() => __SelectorTabPageState();
}

class __SelectorTabPageState extends State<_SelectorTabPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<DataListInnerState> _dataListInnerState = GlobalKey();

  checkAndNextPage() {
    _dataListInnerState?.currentState?._checkAndNextPage();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DataListInner(
      key: _dataListInnerState,
      data: DataListSourceConfig(
        url: widget.entity["url"],
        title: widget.entity["title"],
      ),
      paddingTop: widget.paddingTop,
    );
  }
}
