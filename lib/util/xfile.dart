import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

main(List<String> args) {
  print(XFile("E://MyFork") + "mirai");
  print(XFile("E://MyFork") == "E://MyFork");
  print(XFile("E://MyFork") == XFile("E://MyFork"));
  print(XFile("E://MyFork") + XFile("mirai"));
  print((XFile("E://MyFork") + "../"));
}

String _convert(final dynamic __path) {
  if (__path == null) return "";
  var _path;
  if (__path is String) {
    _path = __path;
  } else if (__path is XFile ||
      __path is File ||
      __path is Directory ||
      __path is Uri) {
    _path = __path.path;
  } else {
    _path = __path.toString();
  }
  return _path;
}

class XFile {
  String _path;
  String get path => _path;

  XFile(final dynamic __path, [a = ""]) {
    String _a = _convert(a);
    if (_a.startsWith(RegExp(r'/|\\'))) {
      _a = _a.replaceFirst(RegExp(r'/|\\'), "");
    }
    this._path = p.join(_convert(__path), _a);
  }

  String get absolute => p.absolute(path);
  String get relative => p.relative(path);

  // -和+同理.... obj - "../abc"
  XFile operator -(final dynamic value) {
    return join(value);
  }

  XFile operator +(final dynamic value) {
    return join(value);
  }

  bool operator ==(final dynamic __path) {
    return path == _convert(__path);
  }

  XFile joinStr(String value) {
    if (value.startsWith(RegExp(r'/|\\'))) {
      value = value.replaceFirst(RegExp(r'/|\\'), "");
    }
    return XFile(p.join(path, value));
  }

  String get basename {
    return p.basename(path);
  }

  String get nameWithout {
    return p.basenameWithoutExtension(path);
  }

  String get ext {
    return p.extension(path);
  }

  String get extension {
    return p.extension(path);
  }

  String get name {
    if (isDir) {
      return p.dirname(path);
    } else if (isFile) {
      return basename;
    } else {
      return path;
    }
  }

  XFile join(final dynamic __path) {
    String _value = _convert(__path);
    if (_value.startsWith(RegExp(r'/|\\'))) {
      _value = _value.replaceFirst(RegExp(r'/|\\'), "");
    }
    return XFile(p.join(path, _convert(__path)));
  }

  Future<XFile> mkDir({final bool recursive = true}) async {
    return XFile((await Directory(path).create(recursive: recursive)).path);
  }

  bool mkDirSync({final bool recursive = true}) {
    try {
      Directory(path).createSync(recursive: recursive);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<XFile> touch({final bool recursive = true}) async {
    return XFile((await File(path).create(recursive: recursive)).path);
  }

  bool touchSync({final bool recursive = true}) {
    try {
      File(path).createSync(recursive: recursive);
      return true;
    } catch (err) {
      return false;
    }
  }

  bool get isDir {
    return FileSystemEntity.isDirectorySync(path);
  }

  bool get isFile {
    return FileSystemEntity.isFileSync(path);
  }

  bool get exists {
    if (isDir) {
      return Directory(path).existsSync();
    } else if (isFile) {
      return File(path).existsSync();
    } else {
      return false;
    }
  }

  void get delete {
    if (isDir) {
      dir.deleteSync(recursive: true);
    } else if (isFile) {
      file.deleteSync(recursive: true);
    }
  }

  File get file => File(path);
  Directory get dir => Directory(path);

  write(dynamic str, {final bool convertToJsonStr = false}) {
    if (isFile) {
      if (convertToJsonStr) {
        str = jsonEncode(str);
      }
      file.writeAsStringSync(str);
    }
  }

  writeAsync(dynamic str, {final bool convertToJsonStr = false}) {
    if (isFile) {
      if (convertToJsonStr) {
        str = jsonEncode(str);
      }
      file.writeAsString(str);
    }
  }

  T read<T extends dynamic>({final bool convertToJsonObj = false}) {
    if (isFile) {
      final str = file.readAsStringSync();
      if (convertToJsonObj) {
        return jsonDecode(str);
      }
    }
    return null;
  }

  List<FileSystemEntity> listFiles(
      {final bool recursive = false, final bool followLinks = true}) {
    return dir.listSync(recursive: recursive, followLinks: followLinks);
  }

  Stream<FileSystemEntity> listFilesAsync(
      {final bool recursive = false, final bool followLinks = true}) {
    return dir.list(recursive: recursive, followLinks: followLinks);
  }

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return path;
  }
}
