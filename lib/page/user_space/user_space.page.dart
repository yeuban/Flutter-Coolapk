import 'package:coolapk_flutter/network/api/user.api.dart';
import 'package:coolapk_flutter/network/model/user_space.model.dart';
import 'package:coolapk_flutter/widget/data_list/data_list.dart';
import 'package:coolapk_flutter/widget/follow_btn.dart';
import 'package:coolapk_flutter/widget/item_adapter/auto_item_adapter.dart';
import 'package:coolapk_flutter/widget/limited_container.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class UserSpacePage extends StatefulWidget {
  final dynamic uid;
  UserSpacePage({Key key, @required this.uid}) : super(key: key);

  @override
  _UserSpacePageState createState() => _UserSpacePageState();

  static entry(final BuildContext context, final dynamic uid) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserSpacePage(
            uid: uid,
          ),
        ));
  }
}

class _UserSpacePageState extends State<UserSpacePage>
    with TickerProviderStateMixin {
  GlobalKey<NestedScrollViewState> _nestedScrollViewKey = GlobalKey();
  ScrollController get _innerScrollCtr =>
      _nestedScrollViewKey.currentState.innerController;
  TabController _tabController;

  List<DataListConfig> _subConfigs;

  UserSpaceModelData _data;

  Future<void> _fetchData() async {
    try {
      _data = await UserApi.userSpace(uid: widget.uid);
      setState(() {});
    } catch (err) {
      Toast.show(err.toString(), context, duration: 3);
    }
  }

  @override
  void initState() {
    try {
      int.tryParse(widget.uid.toString());
    } catch (err) {
      Toast.show("UID:${widget.uid} 不正确，请重试", context, duration: 3);
      super.initState();
      return;
    }
    _tabController = TabController(initialIndex: 0, vsync: this, length: 2);
    _subConfigs = [];
    _subConfigs.addAll([
      DataListConfig(
        // 动态
        url: "/user/feedList",
        extParam: {
          "uid": widget.uid,
          "showAnonymous": 0,
        },
      ),
      DataListConfig(
        // 酷图
        url: "/picture/userPictures",
        extParam: {
          "uid": widget.uid,
        },
      ),
    ]);
    super.initState();
    _tabController.addListener(() {
      setState(() {});
    });
    _fetchData();
  }

  _innerScrollCtrListener() {
    final nowSelectConfig = _subConfigs[_tabController.index];
    if (_innerScrollCtr.position.pixels >=
        (_innerScrollCtr.position.maxScrollExtent - 200)) {
      if (nowSelectConfig.state != DataListConfigState.NoMore &&
          nowSelectConfig.state != DataListConfigState.Loading &&
          nowSelectConfig.state != DataListConfigState.Firstime) {
        nowSelectConfig.nextPage;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        key: _nestedScrollViewKey,
        headerSliverBuilder: _buildSliverHeader,
        body: Builder(
          builder: (context) {
            _innerScrollCtr.removeListener(_innerScrollCtrListener);
            _innerScrollCtr.addListener(_innerScrollCtrListener);
            // _subConfigs[_tabController.index].init();
            return ChangeNotifierProvider.value(
              value: _subConfigs[_tabController.index],
              child: _SubTab(),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildSliverHeader(context, innerBoxIsScrolled) {
    return [
      SliverAppBar(
        snap: true,
        pinned: true,
        floating: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _data != null
                ? CircleAvatar(
                    backgroundImage: ExtendedImage.network(
                            _data.userSmallAvatar,
                            fit: BoxFit.cover)
                        .image,
                  )
                : const SizedBox(),
            VerticalDivider(color: Colors.transparent),
            Text(_data?.username ?? "加载中..."),
            Spacer(),
            FollowButton(
              uid: widget.uid,
              initIsFollow: ((_data?.isFollow ?? 0) == 0 ? false : true),
            ),
          ],
        ),
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: [
            StretchMode.blurBackground,
            StretchMode.fadeTitle,
          ],
          background: Stack(
            children: [
              _data != null
                  ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: ExtendedImage.network(_data.cover,
                                fit: BoxFit.cover)
                            .image,
                      )),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withAlpha(70),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32, left: 32),
                  child: Text(
                    _data != null
                        ? "${_data.bio ?? ""}\n\n${_data.follow}关注 ${_data.fans}粉丝\n"
                        : "",
                    style:
                        Theme.of(context).primaryTextTheme.headline6.copyWith(
                              fontSize: 16,
                            ),
                  ),
                ),
              ),
            ],
          ),
        ),
        expandedHeight: 400,
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text("动态"),
            ),
            Tab(
              child: Text("酷图"),
            ),
          ],
        ),
      ),
    ];
  }
}

class _SubTab extends StatefulWidget {
  const _SubTab({Key key}) : super(key: key);

  @override
  __SubTabState createState() => __SubTabState();
}

class __SubTabState extends State<_SubTab> {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    if (Provider.of<DataListConfig>(context, listen: false).state ==
        DataListConfigState.Firstime) {
      Future.delayed(Duration(milliseconds: 1))
          .then((value) => _refreshIndicatorKey.currentState.show());
    }
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () =>
          Provider.of<DataListConfig>(context, listen: false).refresh,
      child: Consumer<DataListConfig>(
        builder: (context, config, child) => ListView.builder(
          itemBuilder: (context, index) =>
              config.state == DataListConfigState.Loading &&
                      index == config.dataList.length
                  ? Container(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text("加载中..."),
                      ),
                    )
                  : AutoItemAdapter(
                      sliverMode: false,
                      entity: config.dataList[index],
                      limitContainerType: LimiteType.SingleColumn,
                    ),
          itemCount: config.dataList.length +
              (config.state == DataListConfigState.Loading ? 1 : 0),
        ),
      ),
    );
  }
}
