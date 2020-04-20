import 'dart:convert';

import 'package:coolapk_flutter/app_config.dart';
import 'package:coolapk_flutter/network/api/main.api.dart';
import 'package:coolapk_flutter/network/api/user.api.dart';
import 'package:coolapk_flutter/page/model_selector/model_selector.page.dart';
import 'package:coolapk_flutter/store/theme.store.dart';
import 'package:coolapk_flutter/store/user.store.dart';
import 'package:coolapk_flutter/util/anim_page_route.dart';
import 'package:coolapk_flutter/util/fake_device.dart';
import 'package:coolapk_flutter/util/global_storage.dart';
import 'package:coolapk_flutter/widget/limited_container.dart';
import 'package:coolapk_flutter/widget/to_login_snackbar.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

part 'block_manage.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            pinned: true,
            title: Text("设置"),
          )
        ],
        body: LimitedContainer(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  ThemeSettingTile(),
                  PrimarySwatchTile(),
                  Divider(),
                  FakeDeviceTile(),
                  Divider(),
                  HideUnsupportItemTile(),
                  BlockManageTile(),
                  Divider(),
                  Center(child: Text("Flutter Coolapk $AppVersion")),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HideUnsupportItemTile extends StatefulWidget {
  @override
  _HideUnsupportItemTileState createState() => _HideUnsupportItemTileState();
}

class _HideUnsupportItemTileState extends State<HideUnsupportItemTile> {
  bool _hide = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _hide = GlobalStorage()
            .get<bool>(key: "hide_unsupport_item", defaultValue: true);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: _hide,
      title: Text("隐藏暂未支持的item"),
      onChanged: (value) {
        _hide = value;
        GlobalStorage().set(key: "hide_unsupport_item", value: value);
        setState(() {});
      },
    );
  }
}

class FakeDeviceTile extends StatefulWidget {
  const FakeDeviceTile({Key key}) : super(key: key);

  @override
  _FakeDeviceTileState createState() => _FakeDeviceTileState();
}

class _FakeDeviceTileState extends State<FakeDeviceTile> {
  @override
  Widget build(BuildContext context) {
    final device = FakeDevice.get();
    return ListTile(
      title: Text("机型伪装"),
      subtitle: Text(
          "当前机型: ${device.name} | 厂商:${device.manufacturer} | BRAND:${device.brand} | MODEL:${device.model}"),
      trailing: Icon(Icons.chevron_right),
      onTap: () async {
        final resp = await Navigator.push(
            context, ScaleInRoute(widget: ModelSelectorPage()));
        if (resp != null) {
          FakeDevice.set(resp);
          setState(() {});
        }
      },
    );
  }
}

class PrimarySwatchTile extends StatelessWidget {
  const PrimarySwatchTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeStore, MaterialColor>(
      selector: (_, themeStore) => themeStore.swatch,
      builder: (context, value, child) {
        return ListTile(
          title: Text("主题涩"),
          subtitle: Container(
            margin: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: ThemeMap.keys.map((e) {
                final now = ThemeStore.of(context).colorKey;
                return Material(
                  child: InkWell(
                    onTap: () {
                      ThemeStore.of(context).color = e;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4),
                        color: ThemeMap[e],
                        border: now == e
                            ? Border.all(
                                width: 3,
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              )
                            : null,
                      ),
                      width: 50,
                      height: 50,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class ThemeSettingTile extends StatelessWidget {
  const ThemeSettingTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeStore, bool>(
      selector: (_, themeStore) => themeStore.dark,
      builder: (context, isDark, child) {
        return CheckboxListTile(
          value: isDark,
          title: Text("夜间模式"),
          onChanged: (nValue) {
            ThemeStore.of(context).dark = nValue;
          },
        );
      },
    );
  }
}
