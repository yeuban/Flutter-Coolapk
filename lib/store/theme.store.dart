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

  MaterialColor get swatch => ThemeMap[_color];
  bool get dark => _dark ?? false;
  Brightness get brightness => dark ? Brightness.dark : Brightness.light;

  ThemeStore() {
    _load();
  }

  setTheme(String newTheme, bool dark) {
    if (_color != newTheme || _dark != dark) {
      if (_color != newTheme) {
        _color = newTheme;
      }
      if (_dark != dark) {
        _dark = dark;
      }
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

  _load() {
    final _color =
        GlobalStorage.get<String>("theme", "color", defaultValue: "blue");
    final _dark = GlobalStorage.get<bool>("theme", "dark", defaultValue: false);
    setTheme(_color, _dark);
  }

  _save() {
    GlobalStorage.set("theme", "color", _color);
    GlobalStorage.set("theme", "dark", _dark);
  }

  static ThemeStore of(final BuildContext context, {final listen = false}) =>
      Provider.of<ThemeStore>(context, listen: listen);
}
