import 'package:coolapk_flutter/util/global_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Map<String, MaterialColor> ThemeMap = {
  "blue": Colors.blue,
  "green": Colors.green,
  "orange": Colors.orange,
  "indigo": Colors.indigo,
  "purple": Colors.purple,
  "lime": Colors.lime,
  "pink": Colors.pink
};

class ThemeStore extends ChangeNotifier {
  bool _dark;
  String _color;
  String get colorKey => _color;
  MaterialColor get swatch => ThemeMap[_color];
  bool get dark => _dark;
  Brightness get brightness => dark ? Brightness.dark : Brightness.light;

  ThemeStore() {
    loadConfig();
  }

  setTheme(String newTheme, bool dark) {
    if (_color != newTheme || _dark != dark) {
      _color = newTheme;
      _dark = dark;
      notifyListeners();
    }
  }

  set color(String value) {
    if (value != _color) {
      _color = value;
      notifyListeners();
    }
  }

  set dark(value) {
    if (_dark != value) {
      _dark = value;
      notifyListeners();
    }
  }

  @override
  notifyListeners() {
    _save();
    super.notifyListeners();
  }

  loadConfig() {
    final _color = GlobalStorage.instance
        .get<String>(box: "theme", key: "color", defaultValue: "blue");
    final _dark = GlobalStorage.instance.get<bool>(
        box: "theme",
        key: "dark",
        defaultValue: WidgetsBinding.instance.window.platformBrightness ==
            Brightness.dark);
    setTheme(_color, _dark);
  }

  _save() {
    GlobalStorage.instance.set(box: "theme", key: "color", value: colorKey);
    GlobalStorage.instance.set(box: "theme", key: "dark", value: _dark);
  }

  static ThemeStore of(final BuildContext context, {final listen = false}) =>
      Provider.of<ThemeStore>(context, listen: listen);
}
