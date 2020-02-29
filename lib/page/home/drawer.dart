import 'dart:io';
import 'dart:ui';

import 'package:coolapk_flutter/network/model/main_init.model.dart'
    as MainInitModel;
import 'package:coolapk_flutter/page/login/login.page.dart';
import 'package:coolapk_flutter/store/user.store.dart';
import 'package:coolapk_flutter/util/anim_page_route.dart';
import 'package:coolapk_flutter/widget/primary_button.dart';
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
    with TickerProviderStateMixin {
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
    return Drawer(
      elevation: 0,
      child: Stack(
        children: <Widget>[
          _buildTabControllPanel(),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildUserCard(),
          ),
        ],
      ),
    );
  }

  final double userCardHeight =
      64 + 32.toDouble(); // 54 usercard height + padding

  Widget _buildUserCard() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 4,
        child: Container(
          height: userCardHeight - 32, // - padding
          child: DrawerUserCard(),
        ),
      ),
    );
  }

  Widget _buildTabControllPanel() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
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
                            // enableMemoryCache: false,
                            cache: Platform.isWindows || Platform.isLinux
                                ? false
                                : true, // ExtendedImage写死了用path_provider获取路径，不过windows的flutter插件api可能会有所改变 故暂且不用
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
      return PrimaryButton(
        text: "登录",
        onPressed: () {
          Navigator.of(context).pushReplacement(
            ScaleInRoute(widget: LoginPage()),
          );
        },
      );
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
              cache: false, // TODO:
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
                  Divider(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        constraints:
                            const BoxConstraints(maxWidth: 20, maxHeight: 20),
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withAlpha(120),
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
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withAlpha(120),
                        icon: Icon(
                          Icons.mail_outline,
                          size: 18,
                        ),
                        onPressed: () {},
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
