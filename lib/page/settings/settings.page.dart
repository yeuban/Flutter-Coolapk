import 'package:coolapk_flutter/store/theme.store.dart';
import 'package:coolapk_flutter/widget/limited_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                ]),
              ),
            ],
          ),
        ),
      ),
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
            height: 500,
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
