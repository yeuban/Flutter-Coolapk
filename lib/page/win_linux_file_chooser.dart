import 'dart:io';

import 'package:coolapk_flutter/page/image_box/image_box.page.dart';
import 'package:coolapk_flutter/util/xfile.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:universal_platform/universal_platform.dart';

/**
 * 简单粗糙的做了一个文件选择器，windows 和 Linux 平台支持
 * android ios 请调用 file picker
 * 粗糙到我不想再看一次这些代码 哪怕一次...
 */

List<Directory> get winDrives {
  List<Directory> _drives = [];
  for (var i = 0; i < 26; i++) {
    final drive = Directory(String.fromCharCode((65 + i)) + ":\\");
    if (drive.existsSync()) _drives.add(drive);
  }
  return _drives;
}

class FileChooser extends StatefulWidget {
  static final RegExp FilterImages = RegExp(r'^.(jpg|png|jpeg|gif|bmp|webp)$');

  final int max;
  final RegExp chooseFilterRegExp;
  FileChooser({Key key, @required this.chooseFilterRegExp, this.max = 10})
      : super(key: key);

  @override
  _FileChooserState createState() => _FileChooserState();
}

class _FileChooserState extends State<FileChooser> {
  XFile _current;
  bool _chooseMode;
  List<XFile> _choosed;

  @override
  void initState() {
    super.initState();
    _choosed = [];
    _chooseMode = false;
    _current = UniversalPlatform.isWindows ? XFile("_root_") : XFile("/");
  }

  Future<List<FileSystemEntity>> _listCurrentFiles() async {
    return (await this._current.listFilesAsync().toList())
      ..sort((a, b) {
        if (XFile(a).isDir && XFile(b).isFile) return -1;
        if (XFile(a).isFile && XFile(b).isDir) return 1;
        return XFile(a).nameWithout.compareTo(XFile(b).basename);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            leading: CloseButton(),
            actions: [
              PopupMenuButton(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Center(child: Text("已选取${this._choosed.length}个")),
                ),
                onSelected: (value) {
                  this._current = XFile(value.file.parent);
                  setState(() {});
                },
                itemBuilder: (context) => this
                    ._choosed
                    .map((e) => PopupMenuItem(
                          value: e,
                          child: Text(e.path),
                        ))
                    .toList(),
              ),
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  Navigator.pop(context, this._choosed);
                },
              ),
            ],
            title: Text("文件选择: ${_current.path}"),
          ),
        ],
        body: _current.path == "_root_"
            ? _buildChooseDrive()
            : FutureBuilder<List<FileSystemEntity>>(
                future: _listCurrentFiles(),
                builder: (context, snap) => snap.hasData
                    ? GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          childAspectRatio: 1,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: snap.data.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return _buildBackTile();
                          }
                          index -= 1;
                          final f = XFile(snap.data[index].path);
                          final ext = f.extension.trim();
                          final icon = f.isDir
                              ? Icon(Icons.folder)
                              : ext.contains(FileChooser.FilterImages)
                                  ? ExtendedImage.file(
                                      f.file,
                                      alignment: Alignment.center,
                                    )
                                  : Icon(Icons.insert_drive_file);
                          final isFile = f.isFile;
                          return _buildTile(
                            f.basename,
                            icon,
                            onTap: () {
                              if (f.isDir) {
                                this._current = f;
                                setState(() {});
                              } else {
                                if (ext.contains(FileChooser.FilterImages)) {
                                  ImageBox.push(context,
                                      urls: [f], fileMode: true);
                                }
                              }
                            },
                            canChoose: isFile &&
                                ext.contains(widget.chooseFilterRegExp),
                            file: f,
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
      ),
    );
  }

  Widget _buildTile(final String title, final Widget icon,
      {Function onTap, bool canChoose = false, XFile file}) {
    final include = _choosed.contains(file);
    return Material(
      elevation: 2,
      child: InkWell(
        onTap: onTap ??
            () {
              if (UniversalPlatform.isWindows &&
                  this._current.path.startsWith(RegExp(r'^[a-zA-Z]:\\$')))
                this._current = XFile("_root_");
              else
                this._current = XFile(this._current.dir.parent);
              setState(() {});
            },
        child: GridTile(
          child: icon,
          header: canChoose
              ? Checkbox(
                  value: include,
                  onChanged: (value) {
                    if (this._choosed.length >= widget.max && value) {
                      Toast.show("一次最多选取${widget.max}张", context, duration: 2);
                      return;
                    }
                    value
                        ? !include ? _choosed.add(file) : () {}()
                        : _choosed.removeWhere(
                            (element) => element.path == file.path);
                    setState(() {});
                  },
                )
              : null,
          footer: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackTile() {
    return _buildTile("上一级", Icon(Icons.arrow_back));
  }

  Widget _buildChooseDrive() {
    if (UniversalPlatform.isWindows)
      return ListView(
        children: winDrives.map((drive) {
          return ListTile(
            onTap: () {
              this._current = XFile(drive.path);
              setState(() {});
            },
            title: Text(drive.path),
          );
        }).toList(),
      );
    return Text("不支持哦");
  }
}
