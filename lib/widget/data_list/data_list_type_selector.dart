import 'package:coolapk_flutter/widget/data_list/data_list.dart';
import 'package:coolapk_flutter/widget/data_list/data_list_inner.dart';
import 'package:coolapk_flutter/widget/data_list/sliver_persistent_header_delegate_impl.dart';
import 'package:coolapk_flutter/widget/item_adapter/auto_item_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class DataListTypeSelector extends StatefulWidget {
  DataListTypeSelector({Key key}) : super(key: key);

  @override
  _DataListTypeSelectorState createState() => _DataListTypeSelectorState();
}

class _DataListTypeSelectorState extends State<DataListTypeSelector>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<dynamic> _selectorLinkCardEntityList;
  Map<String, dynamic> _configCard;

  int selected = 0;

  @override
  void initState() {
    super.initState();

    _selectorLinkCardEntityList =
        Provider.of<DataListConfig>(context, listen: false).data; // 首先获取data列表

    _configCard =
        _selectorLinkCardEntityList.firstWhere(// 然后获取selectorLinkCard的数据
                (element) => element["entityTemplate"] == "selectorLinkCard")
            as Map<String, dynamic>;

    _tabController = TabController(
      //  配置tabController
      vsync: this,
      length: _configCard["entities"]?.length ?? 0,
    );

    _selectorLinkCardEntityList.removeRange(
      // 移除多余部分
      _selectorLinkCardEntityList.indexWhere(
          ((element) => element["entityTemplate"] == "selectorLinkCard")),
      _selectorLinkCardEntityList.length,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  double get _tabHeight {
    return const TabBar(
      tabs: const <Widget>[],
    ).preferredSize.height;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<DataListConfig, List<dynamic>>(
      selector: (_, final config) => config.data,
      builder: (context, final data, child) {
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) =>
              _selectorLinkCardEntityList.map<Widget>((entity) {
            return AutoItemAdapter(
              entity: entity,
              sliverMode: true,
            );
          }).toList()
                ..add(_buildTabBar(context)),
          body: Builder(
            builder: (context) {
              return NestedScrollViewViewport(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                offset: ViewportOffset.zero(),
                slivers: <Widget>[
                  SliverFillRemaining(
                    child: TabBarView(
                      controller: _tabController,
                      children: _configCard["entities"].map<Widget>((entity) {
                        return _SelectorTabPage(
                          entity: entity,
                          paddingTop: _tabHeight,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTabBar(final BuildContext context) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverPersistentHeader(
        floating: true,
        pinned: true,
        delegate: SliverPersistentHeaderDelegateImpl(
          child: TabBar(
            controller: _tabController,
            labelPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            indicator: BoxDecoration(color: Colors.transparent),
            isScrollable: true,
            tabs: _buildTabs(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabs() {
    final theme = Theme.of(context);
    return (_configCard["entities"] as List<dynamic>).map<Widget>((entity) {
      final isSelected = selected == _configCard["entities"].indexOf(entity);
      return ConstrainedBox(
        constraints: BoxConstraints.tightForFinite(),
        child: Chip(
          backgroundColor:
              isSelected ? theme.primaryColor : theme.chipTheme.backgroundColor,
          labelStyle: TextStyle(
            color: isSelected
                ? theme.primaryTextTheme.bodyText1.color
                : theme.textTheme.bodyText1.color,
          ),
          label: Text(entity["title"]),
        ),
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
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DataListInner(
      data: DataListSourceConfig(
        url: widget.entity["url"],
        title: widget.entity["title"],
      ),
      paddingTop: widget.paddingTop,
    );
  }
}
