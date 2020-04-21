part of 'settings.page.dart';

const _aboutSpamWord = """一、0级用户没有屏蔽名额，每升1级，可以获得3个名额，上限30个名额。

二、「屏蔽板块」「屏蔽用户」「屏蔽关键词」，3种屏蔽类型共用屏蔽名额。

三、屏蔽功能仅在首页的头条、热榜等几个tab页生效，并非全局生效。

四、屏蔽只对以后新加载的动态有效，对已经加载过的动态无法生效。""";

class BlockManageTile extends StatelessWidget {
  const BlockManageTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        UserStore.getUserUid(context) == null
            ? showToLoginSnackBar(context)
            : Navigator.push(context,
                MaterialPageRoute(builder: (contexxt) => BlockManagePage()));
      },
      title: Text("屏蔽管理"),
      trailing: Icon(Icons.chevron_right),
    );
  }
}

class BlockManagePage extends StatefulWidget {
  BlockManagePage({Key key}) : super(key: key);

  @override
  BlockManagePageState createState() => BlockManagePageState();
}

class BlockManagePageState extends State<BlockManagePage> {
  Map _spamWordConfig;

  fetchData() async {
    try {
      _spamWordConfig = await MainApi.getSpamWordList();
      setState(() {});
    } catch (err) {
      Toast.show("获取信息失败", context, duration: 2);
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("屏蔽管理")),
      body: AnimatedCrossFade(
        firstChild: Center(child: CircularProgressIndicator()),
        secondChild: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text("屏蔽模块"),
              subtitle: Text("施工中"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text("屏蔽用户"),
              subtitle: Text("施工中"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
                title: Text("屏蔽关键词"),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SpamWordManagePage(
                            initSpamWordConfig: _spamWordConfig)))),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_aboutSpamWord),
            ),
          ],
        ),
        crossFadeState: _spamWordConfig == null
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: Duration(milliseconds: 300),
      ),
    );
  }
}

class ModuleBlockManagePage extends StatefulWidget {
  ModuleBlockManagePage({Key key}) : super(key: key);

  @override
  _ModuleBlockManagePageState createState() => _ModuleBlockManagePageState();
}

class _ModuleBlockManagePageState extends State<ModuleBlockManagePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class SpamWordManagePage extends StatefulWidget {
  /**
   * {
   * "custom": {
   *    "key": "word"
   *  }
   * }
   */
  final Map initSpamWordConfig;
  SpamWordManagePage({Key key, @required this.initSpamWordConfig})
      : super(key: key);

  @override
  _SpamWordManagePageState createState() => _SpamWordManagePageState();
}

class _SpamWordManagePageState extends State<SpamWordManagePage> {
  Map<String, dynamic> _customWord;

  @override
  void initState() {
    _customWord = widget.initSpamWordConfig["custom"];
    super.initState();
  }

  Future<bool> add(String word) async {
    try {
      final resp = await UserApi.updateConfig(
          key: "spam_word_config",
          value: jsonEncode({
            "word": {
              "add": word,
            }
          }));
      return resp["data"] == 1 ? true : false;
    } catch (err) {
      Toast.show("添加失败:" + err.toString(), context, duration: 2);
    }
    return false;
  }

  Future<bool> cancel(String word) async {
    try {
      final resp = await UserApi.updateConfig(
          key: "spam_word_config",
          value: jsonEncode({
            "word": {
              "cancel": word,
            }
          }));
      return resp["data"] == 1 ? true : false;
    } catch (err) {
      Toast.show("删除失败:" + err.toString(), context, duration: 2);
    }
    return false;
  }

  Widget _buildAddDialog(final BuildContext context) {
    TextEditingController _ctr = TextEditingController();
    return AlertDialog(
      title: Text("添加自定义屏蔽关键词"),
      content: TextFormField(
        controller: _ctr,
        maxLength: 15,
        decoration: InputDecoration(hintText: "2-15字"),
        validator: (str) {
          if (str.length < 2) {
            return "2-15字";
          }
          return null;
        },
        autovalidate: true,
      ),
      actions: [
        FlatButton(
          child: Text("取消"),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("确定"),
          onPressed: () async {
            if (_customWord.keys.contains(_ctr.text)) {
              Toast.show("已有此项", context, duration: 2);
              return;
            }
            await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return SimpleDialog(
                    children: [
                      FutureBuilder(
                        future: () async {
                          if (await this.add(_ctr.text)) {
                            _customWord.addAll({
                              md5.convert(utf8.encode(_ctr.text)).toString():
                                  _ctr.text
                            });
                          }
                          Navigator.pop(context);
                        }(),
                        builder: (context, snapshot) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                    ],
                  );
                });
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _buildDeleteDialog(final BuildContext context, index) {
    return SimpleDialog(
      children: [
        FutureBuilder(
          future: () async {
            if (await this.cancel(_customWord.values.toList()[index])) {
              _customWord.removeWhere(
                  (k, v) => v == _customWord.values.toList()[index]);
            }
            Navigator.pop(context);
            return true;
          }(),
          builder: (context, snapshot) {
            return Center(child: CircularProgressIndicator());
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("屏蔽关键词管理"),
        actions: [
          FlatButton(
            child: Text(
              "添加",
              style: TextStyle(
                  color: Theme.of(context).accentTextTheme.bodyText1.color),
            ),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => _buildAddDialog(context),
              );
              setState(() {});
            },
          ),
        ],
      ),
      body: _customWord.length == 0
          ? Center(
              child: Text(
              "你还没有设置任何屏蔽的关键词哦~",
              style: TextStyle(
                fontSize: 22,
                color:
                    Theme.of(context).textTheme.headline6.color.withAlpha(130),
              ),
            ))
          : ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_customWord.values.toList()[index]),
                  trailing: OutlineButton(
                    child: Text("删除"),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return _buildDeleteDialog(context, index);
                        },
                      );
                      setState(() {});
                    },
                  ),
                );
              },
              itemCount: _customWord.length,
            ),
    );
  }
}

class BlockDialog extends StatefulWidget {
  final dynamic source;
  BlockDialog({Key key, @required this.source}) : super(key: key);

  @override
  _BlockDialogState createState() => _BlockDialogState();
}

class _BlockInfo {
  final dynamic tid;
  final String name;
  bool selected = false;
  _BlockInfo({
    @required this.name,
    this.tid = 0,
  });
}

class _BlockDialogState extends State<BlockDialog> {
  _BlockInfo _blockUser; // uid
  List<_BlockInfo> _blockList = [];

  @override
  void initState() {
    analyzeAvailableConent();
    super.initState();
  }

  void analyzeAvailableConent() {
    widget.source["tags"].toString().split(",")
      ..forEach((tag) {
        tag = tag.replaceAll("#", "");
        this._blockList.add(_BlockInfo(name: tag));
      });

    if (widget.source["tid"].toString() != "0") {
      _blockList.add(_BlockInfo(
        tid: widget.source["tid"],
        name: widget.source["ttitle"],
      ));
    }
    _blockUser = _BlockInfo(name: widget.source["username"], tid: -1);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("选择你想在首页屏蔽的内容", textAlign: TextAlign.center),
      content: Container(
        constraints: BoxConstraints(maxWidth: 400),
        child: Wrap(
          spacing: 8,
          children: []
            ..addAll(_blockList.map((entity) {
              return _buildChip(entity);
            }).toList())
            ..addAll([_buildChip(_blockUser)]),
        ),
      ),
      actions: _buildAction(context),
    );
  }

  bool _doing = false;

  void _submit() async {
    /**
     * {
     *  "node": {
     *    "add": [
     *      {
     *        "tid": 0, // 话题
     *        "name": "" // 话题名称
     *      }
     *    ]
     *  },
     *  "user": {
     *    "add": "" // uid
     *  }
     * }
     */
    final _param = {
      "user": {
        "add": _blockUser?.selected ?? false
            ? _blockUser?.name != null ? widget.source["uid"].toString() : ""
            : "",
      },
      "node": {
        "add": _blockList
            .where((e) => e.selected)
            .map((e) => {
                  "tid": e.tid.toString(),
                  "name": e.name,
                })
            .toList(),
      }
    };
    _doing = true;
    setState(() {});
    try {
      final resp = await UserApi.updateConfig(
          key: "spam_word_config", value: jsonEncode(_param));
      if (resp["message"] != null) {
        throw Exception(resp["message"]);
      }
      Navigator.pop(context, true);
    } catch (err) {
      Toast.show(err.message, context, duration: 2);
    } finally {
      _doing = false;
      setState(() {});
    }
  }

  Widget _buildChip(_BlockInfo _blockInfo) {
    return ChoiceChip(
      onSelected: (value) {
        _blockInfo.selected = value;
        setState(() {});
      },
      selected: _blockInfo.selected,
      label: Text(
          "${_blockInfo.tid == 0 ? "(话题) " : _blockInfo.tid == -1 ? "(用户) " : "(数码) "}${_blockInfo.name}"),
    );
  }

  List<Widget> _buildAction(final BuildContext context) {
    return [
      Align(
        alignment: Alignment.centerLeft,
        child: FlatButton(
          child: Text("屏蔽关键词"),
          onPressed: _doing ? null : () => _showSpamWordDialog(context),
        ),
      ),
      FlatButton(
        child: Text("取消"),
        onPressed: _doing ? null : () => Navigator.pop(context),
      ),
      FlatButton(
        child: Text(_doing ? "请求中..." : "确定"),
        onPressed: _doing ||
                (!(_blockUser?.selected ?? false) &&
                    !_blockList.any((e) => e.selected))
            ? null
            : () => _submit(),
      ),
    ];
  }

  void _showSpamWordDialog(final BuildContext context) {
    showDialog(context: context, builder: (context) => AddSpamWordDialog());
  }
}

class AddSpamWordDialog extends StatefulWidget {
  AddSpamWordDialog({Key key}) : super(key: key);

  @override
  _AddSpamWordDialogState createState() => _AddSpamWordDialogState();
}

class _AddSpamWordDialogState extends State<AddSpamWordDialog> {
  TextEditingController _ctr = TextEditingController();
  bool _doing = false;
  void _submit() async {
    try {
      _doing = true;
      setState(() {});
      final resp = await UserApi.updateConfig(
          key: "spam_word_config",
          value: jsonEncode({
            "word": {
              "add": _ctr.text,
            }
          }));
      if (resp["message"] != null) throw Exception(resp["message"]);
      Toast.show("添加成功", context, duration: 2);
      Navigator.pop(context);
    } catch (err) {
      Toast.show("添加失败:" + err.message, context, duration: 2);
      _doing = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("添加屏蔽关键词"),
      content: TextFormField(
        validator: (string) {
          if (string.length < 2) {
            return "2-15字";
          }
          return null;
        },
        autovalidate: true,
        maxLength: 15,
        maxLines: 1,
        controller: _ctr,
      ),
      actions: [
        FlatButton(
          child: Text("取消"),
          onPressed: _doing ? null : () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text(_doing ? "请求中..." : "确定"),
          onPressed: _doing ? null : () => _submit(),
        ),
      ],
    );
  }
}
