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

class SpamWordManagePage extends StatefulWidget {
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
      content: TextField(controller: _ctr, maxLength: 100),
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
