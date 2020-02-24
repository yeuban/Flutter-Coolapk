import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class GlobalStorage {
  static Future<bool> setupGlobalStorage() async {
    if (_storageObj != null) return true;
    Directory dir;
    try {
      dir = await getTemporaryDirectory();
    } catch (err) {
      dir = Directory.systemTemp;
    }
    _storageFile = File(dir.path + "/coolapk_flutter/storage.json");
    if (!_storageFile.existsSync()) _storageFile.createSync(recursive: true);
    try {
      final obj = jsonDecode(await _storageFile.readAsString());
      _storageObj = obj as Map<String, dynamic>;
    } catch (err, stack) {
//      debugPrintStack(stackTrace: stack);
      _storageObj = Map();
    }
    return true;
  }

  static File _storageFile;
  static Map<String, dynamic> _storageObj;

  static T set<T>(final String box, final String key, final T value) {
    if (_storageObj[box] == null) {
      _storageObj[box] = Map<String, dynamic>();
    }
    _storageObj[box][key] = value;
    _storageFile.writeAsStringSync(jsonEncode(_storageObj));
    return value;
  }

  static T get<T>(final String box, final String key, {final T defaultValue}) {
    try {
      return _storageObj[box][key];
    } catch (err) {
      return defaultValue;
    }
  }

  static Map getObj() {
    return _storageObj;
  }
}
