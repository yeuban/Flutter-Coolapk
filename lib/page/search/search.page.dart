import 'package:coolapk_flutter/network/api/main.api.dart';
import 'package:coolapk_flutter/util/anim_page_route.dart';
import 'package:coolapk_flutter/widget/item_adapter/auto_item_adapter.dart';
import 'package:coolapk_flutter/widget/limited_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'sub_search.dart';

class SearchPage extends StatefulWidget {
  final String searchString;
  SearchPage({Key key, this.searchString}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  TextEditingController _textEditingController;

  final _tabs = [
    ["动态", SearchType.feed],
    ["用户", SearchType.user],
    ["话题", SearchType.feedTopic],
    ["问答", SearchType.ask],
    ["看看号", SearchType.dyhMix],
  ];

  List<SubSearch> _tabsWidget;
  GlobalKey<NestedScrollViewState> _nestedScrollViewKey = GlobalKey();
  ScrollController get _innerController =>
      _nestedScrollViewKey.currentState.innerController;
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    _textEditingController = TextEditingController(text: "");
    _tabsWidget = _tabs
        .map((tab) => SubSearch(
              key: GlobalKey(),
              searchValue: widget.searchString,
              searchType: tab[1],
            ))
        .toList();
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void _innerScrollControllerListener() {
    if (_innerController.position.pixels >=
        _innerController.position.maxScrollExtent - 200) {
      this
          ._tabsWidget[_tabController.index]
          .key
          .currentState
          .fetchData(nextPage: true, refresh: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          _nestedScrollViewKey.currentState.innerController.jumpTo(0);
          _nestedScrollViewKey.currentState.outerController.jumpTo(0);
        },
      ),
      body: NestedScrollView(
        key: _nestedScrollViewKey,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildAppBar(context, innerBoxIsScrolled),
        ],
        body: Builder(
          builder: (context) {
            _innerController.removeListener(_innerScrollControllerListener);
            _innerController.addListener(_innerScrollControllerListener);
            return NestedScrollViewViewport(
                offset: ViewportOffset.zero(),
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                slivers: <Widget>[
                  SliverFillRemaining(
                    child: _tabsWidget[_tabController.index],
                  )
                ]);
          },
        ),
      ),
    );
  }

  Widget _buildAppBar(final BuildContext context, bool innerBoxIsScrolled) {
    return SliverAppBar(
      forceElevated: innerBoxIsScrolled,
      pinned: true,
      snap: true,
      floating: true,
      bottom: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabs: _tabs
            .map((tab) => Tab(
                  child: Text(tab[0]),
                ))
            .toList(),
      ),
      title: Row(
        children: [
          Text("搜索:"),
          VerticalDivider(),
          Expanded(
            child: TextField(
              controller: _textEditingController,
              cursorColor: Theme.of(context).primaryTextTheme.bodyText1.color,
              autofocus: false,
              maxLines: 1,
              style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.bodyText1.color),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "请输入搜索内容",
                hintStyle: TextStyle(
                    color: Theme.of(context)
                        .primaryTextTheme
                        .bodyText1
                        .color
                        .withAlpha(100)),
              ),
              onSubmitted: (string) => Navigator.push(
                  context,
                  ScaleInRoute(
                      widget: SearchPage(
                    searchString: string,
                  ))),
            ),
          ),
        ],
      ),
      actionsIconTheme: Theme.of(context).primaryIconTheme,
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => {
            Navigator.push(
                context,
                ScaleInRoute(
                    widget: SearchPage(
                  searchString: _textEditingController.text,
                )))
          },
        ),
      ],
    );
  }
}
