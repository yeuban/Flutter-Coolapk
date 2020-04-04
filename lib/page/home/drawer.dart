import 'dart:ui';

import 'package:coolapk_flutter/network/model/main_init.model.dart'
    as MainInitModel;
import 'package:coolapk_flutter/page/login/login.page.dart';
import 'package:coolapk_flutter/store/user.store.dart';
import 'package:coolapk_flutter/util/anim_page_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageDrawer extends StatefulWidget {
  final List<MainInitModel.MainInitModelData> tabConfigs;
  final Function(int, int) gotoTab;
  HomePageDrawer({Key key, this.tabConfigs, this.gotoTab}) : super(key: key);

  @override
  HomePageDrawerState createState() => HomePageDrawerState();
}

class HomePageDrawerState extends State<HomePageDrawer>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int _homePageSelected = 1;
  int _digitalPageSelected = 0;

  onGotoTab(int page, int tab) {
    bool hasChange = false;
    if (page == 0) {
      if (_homePageSelected != tab) hasChange = true;
      _homePageSelected = tab;
    } else {
      if (_digitalPageSelected != tab) hasChange = true;
      _digitalPageSelected = tab;
    }
    if (hasChange) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Drawer(
      elevation: 0,
      child: Material(
        color: Theme.of(context).cardColor,
        child: Stack(
          children: <Widget>[
            _buildTabControllPanel(context),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildUserCard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(final BuildContext context) {
    return AppBar(
      elevation: 2,
      backgroundColor: Theme.of(context).cardColor,
      primary: false,
      title: Container(
        constraints: BoxConstraints(maxHeight: 36),
        child: TextField(
          autofocus: false,
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: "搜索",
            fillColor: Theme.of(context).primaryColor.withAlpha(30),
            contentPadding: const EdgeInsets.all(8),
            filled: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ),
    );
  }

  final double userCardHeight =
      64 + 32.toDouble(); // 54 usercard height + padding

  Widget _buildUserCard() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        elevation: 4,
        child: Container(
          height: userCardHeight - 32, // - padding
          child: DrawerUserCard(),
        ),
      ),
    );
  }

  Widget _buildTabControllPanel(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildHeader(context),
        TabBar(
          controller: Provider.of<TabController>(context, listen: false),
          labelColor: Theme.of(context).textTheme.bodyText1.color,
          tabs: <Widget>[
            Tab(
              text: ("首页"),
            ),
            Tab(
              text: ("数码"),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: Provider.of<TabController>(context, listen: false),
            children: widget.tabConfigs.map<Widget>((tabConfig) {
              return ListView(
                shrinkWrap: true,
                children: tabConfig.entities.map<Widget>((tabItem) {
                  final tabItemIndex = tabConfig.entities.indexOf(tabItem);
                  return ListTile(
                    selected: tabItemIndex ==
                        (tabConfig.entityId == 6390
                            ? _homePageSelected
                            : _digitalPageSelected),
                    dense: false,
                    title: Text(tabItem.title),
                    onTap: () {
                      widget.gotoTab(tabConfig.entityId, tabItemIndex);
                      setState(() {
                        if (tabConfig.entityId == 6390) {
                          _homePageSelected = tabItemIndex;
                        } else {
                          _digitalPageSelected = tabItemIndex;
                        }
                      });
                    },
                    leading: tabItem.logo.length > 0 // 数码TAB没有logo.....
                        ? ExtendedImage.network(
                            tabItem.logo,
                            width: 24,
                            height: 24,
                            cache: true,
                          )
                        : null,
                  );
                }).toList()
                  ..add(Padding(
                    padding: EdgeInsets.only(bottom: userCardHeight),
                  )),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DrawerUserCard extends StatefulWidget {
  DrawerUserCard({Key key}) : super(key: key);

  @override
  _DrawerUserCardState createState() => _DrawerUserCardState();
}

class _DrawerUserCardState extends State<DrawerUserCard> {
  @override
  Widget build(BuildContext context) {
    if (UserStore.of(context).loginInfo == null)
      return Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            child: Text(
              "登录",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                ScaleInRoute(widget: LoginPage()),
              );
            },
          ),
        ),
      );
    final iconColor =
        Theme.of(context).textTheme.bodyText1.color.withAlpha(120);
    return InkWell(
      onTap: () {
        // TODO:
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ExtendedImage.network(
              UserStore.of(context).loginInfo.userAvatar,
              cache: true,
              filterQuality: FilterQuality.low,
              width: 40,
              height: 40,
              shape: BoxShape.circle,
            ),
            const VerticalDivider(
              width: 8,
              color: Colors.transparent,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      "${UserStore.of(context).userName}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Divider(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        constraints:
                            const BoxConstraints(maxWidth: 20, maxHeight: 20),
                        color: iconColor,
                        tooltip: "设置",
                        icon: Icon(
                          Icons.settings,
                          size: 18,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        constraints:
                            const BoxConstraints(maxWidth: 24, maxHeight: 24),
                        color: iconColor,
                        tooltip: "消息",
                        icon: Icon(
                          Icons.mail_outline,
                          size: 18,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        constraints:
                            const BoxConstraints(maxWidth: 24, maxHeight: 24),
                        color: iconColor,
                        tooltip: "退出登录",
                        icon: Icon(
                          Icons.exit_to_app,
                          size: 18,
                        ),
                        onPressed: () {
                          Provider.of<UserStore>(context, listen: false)
                              .logout();
                          Navigator.of(context).pushReplacement(
                            ScaleInRoute(
                              widget: LoginPage(),
                            ),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
