part of 'create_feed.page.dart';

class CreateHtmlArticleFeedPage extends StatefulWidget {
  CreateHtmlArticleFeedPage({Key key}) : super(key: key);

  @override
  _CreateHtmlArticleFeedPageState createState() =>
      _CreateHtmlArticleFeedPageState();
}

class _CreateHtmlArticleFeedPageState extends State<CreateHtmlArticleFeedPage> {
  FeedPublicType _feedPublicType = FeedPublicType.anyone;
  FocusNode _focusNode;
  GlobalKey<PictextEditorState> _pictextEditorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final expandedHeight = MediaQuery.of(context).size.width / (3 / 1);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () {
          //TODO:
        },
      ),
      bottomNavigationBar: _buildToolBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Theme.of(context).cardColor,
            iconTheme: Theme.of(context).iconTheme,
            textTheme: Theme.of(context).textTheme,
            leading: CloseButton(),
            title: Text("发布图文"),
            expandedHeight: expandedHeight > 300 ? 300 : expandedHeight,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: InkWell(
                onTap: () {
                  //TODO:
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add),
                    Text("设置头图"),
                  ],
                ),
              ),
              stretchModes: [
                StretchMode.fadeTitle,
              ],
            ),
          ),
        ],
        body: LimitedContainer(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: TextField(
                  autofocus: false,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  decoration:
                      InputDecoration(hintText: "标题", border: InputBorder.none),
                ),
              ),
              SliverToBoxAdapter(
                child: Divider(),
              ),
              SliverToBoxAdapter(
                child: PictextEditor(
                  key: _pictextEditorKey,
                ),
              ),
              SliverToBoxAdapter(
                child: Divider(),
              ),
              SliverToBoxAdapter(
                child: ListTile(
                  leading: Icon(Icons.visibility),
                  title: Text("谁可以看"),
                  trailing: DropdownButton<FeedPublicType>(
                    value: _feedPublicType,
                    items: [
                      DropdownMenuItem(
                        value: FeedPublicType.anyone,
                        child: Text("公开"),
                      ),
                      DropdownMenuItem(
                        value: FeedPublicType.onlyself,
                        child: Text("仅自己"),
                      ),
                    ],
                    onChanged: (final FeedPublicType v) =>
                        setState(() => _feedPublicType = v),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolBar(final BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.crop_original),
            onPressed: () async {
              final List<XFile> resp =
                  await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FileChooser(
                  chooseFilterRegExp: FileChooser.FilterImages,
                  max: 10,
                ),
              ));
              if (resp != null) {
                resp.every((element) {
                  _pictextEditorKey.currentState.addNode(PicNode(
                    imageFile: element,
                  ));
                  _pictextEditorKey.currentState.addNode(TextNode());
                  return true;
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.sentiment_very_satisfied),
            onPressed: () {
              // TODO:
              // 获取正在编辑器的编辑器的焦点
              // this._pictextEditorKey.currentState.textEditingCtr.text;
              showModalBottomSheet(
                  enableDrag: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return FittedBox(
                      fit: BoxFit.contain,
                      child: Center(
                        child: EmojiPanel(),
                      ),
                    );
                  });
            },
          ),
          IconButton(
            icon: Icon(Icons.alternate_email),
            onPressed: () {
              // TODO:
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: IconButton(
              icon: Text(
                '#',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                // TODO:
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.apps),
            onPressed: () {
              // TODO:
            },
          ),
        ],
      ),
    );
  }
}

class PictextEditor extends StatefulWidget {
  PictextEditor({Key key}) : super(key: key);

  @override
  PictextEditorState createState() => PictextEditorState();
}

class PictextEditorState extends State<PictextEditor> {
  List<Widget> _nodes;

  TextEditingController _focusTextEditingController;

  TextEditingController get textEditingCtr => _focusTextEditingController;

  @override
  void initState() {
    super.initState();
    _nodes = [
      TextNode(),
    ];
  }

  onFocus(TextEditingController textEditingController, {bool hasFocus = true}) {
    if (!hasFocus && textEditingController == this._focusTextEditingController)
      this._focusTextEditingController = null;
    else if (hasFocus) this._focusTextEditingController = textEditingController;
    // setState(() {});
  }

  addNode(Widget value) {
    this._nodes.add(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _nodes,
    );
  }
}

class PicNode extends StatefulWidget {
  final XFile imageFile;
  final Function(TextEditingController, {bool hasFocus}) onFocus;
  PicNode({Key key, this.imageFile, this.onFocus}) : super(key: key);
  @override
  _PicNodeState createState() => _PicNodeState();
}

class _PicNodeState extends State<PicNode> {
  TextEditingController _textNodeFieldController;
  FocusNode _focusNode;

  bool get hasFocus => _focusNode.hasFocus;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textNodeFieldController = TextEditingController();
    _focusNode.addListener(() {
      widget.onFocus(this._textNodeFieldController,
          hasFocus: this._focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExtendedImage.file(widget.imageFile.file),
        TextField(
          focusNode: _focusNode,
          controller: _textNodeFieldController,
          decoration: InputDecoration(
            hintText: "图片描述",
            alignLabelWithHint: true,
            border: InputBorder.none,
          ),
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class TextNode extends StatefulWidget {
  final Function(TextEditingController, {bool hasFocus}) onFocus;
  TextNode({Key key, this.onFocus}) : super(key: key);
  @override
  _TextNodeState createState() => _TextNodeState();
}

class _TextNodeState extends State<TextNode> {
  FocusNode _focusNode;
  TextEditingController _textNodeFieldController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textNodeFieldController = TextEditingController();
    _focusNode.addListener(() {
      widget.onFocus(this._textNodeFieldController,
          hasFocus: this._focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 10,
      minLines: 1,
      autocorrect: true,
      focusNode: FocusNode(),
      controller: _textNodeFieldController,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
    );
  }
}
