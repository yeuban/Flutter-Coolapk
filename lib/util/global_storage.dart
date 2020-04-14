import 'dart:io';

import 'package:coolapk_flutter/util/xfile.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class GlobalStorage {
  static GlobalStorage instance;
  static const String DefaultBoxName = "___default___";

  bool inited = false;

  Map<String, dynamic> boxes;
  XFile boxesFile;

  Future<void> init() async {
    instance = this;
    if (inited) return;
    try {
      boxesFile =
          XFile(await getTemporaryDirectory(), "coolapk_flutter/storage.json");
    } catch (err) {
      boxesFile = XFile(Directory.systemTemp, "coolapk_flutter/storage.json");
    }

    if (!boxesFile.exists) {
      boxes = {};
      await boxesFile.touch();
      await _save();
    } else {
      boxes = boxesFile.read(convertToJsonObj: true);
    }
    print("Storage File: ${boxesFile.path}");
    print("Storage Boxes: ${boxes}");
  }

  operator []=(String key, String value) {
    set(key: key, value: value);
  }

  operator [](String key) {
    return get(key: key, defaultValue: null);
  }

  set({
    String box = DefaultBoxName,
    @required String key,
    @required dynamic value,
  }) {
    if (this.boxes[box] == null || !(this.boxes[box] is Map)) {
      this.boxes[box] = {};
    }
    this.boxes[box][key] = value;
    _saveSync();
  }

  get<T>({
    String box = DefaultBoxName,
    @required String key,
    T defaultValue,
  }) {
    return ((this.boxes[box] ?? {})[key] ?? defaultValue);
  }

  static setValue(
    final BuildContext context, {
    String box = DefaultBoxName,
    @required String key,
    @required dynamic value,
  }) {
    GlobalStorage.of(context).set(
      box: box,
      key: key,
      value: value,
    );
  }

  static getValue<T>(
    final BuildContext context, {
    String box = DefaultBoxName,
    @required String key,
    T defaultValue,
  }) {
    GlobalStorage.of(context).get(
      box: box,
      key: key,
      defaultValue: defaultValue,
    );
  }

  static GlobalStorage of(final BuildContext context, {bool listen: false}) =>
      Provider.of<GlobalStorage>(context, listen: listen);

  Future<void> _save() async {
    await boxesFile.writeAsync(boxes, convertToJsonStr: true);
  }

  void _saveSync() {
    boxesFile.write(boxes, convertToJsonStr: true);
  }
}
