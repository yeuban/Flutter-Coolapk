import 'package:coolapk_flutter/util/xfile.dart';
import 'package:coolapk_flutter/widget/limited_container.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class NewCollectionPage extends StatefulWidget {
  NewCollectionPage({Key key}) : super(key: key);

  @override
  _NewCollectionPageState createState() => _NewCollectionPageState();
}

class _NewCollectionPageState extends State<NewCollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新建收藏单"),
      ),
      body: LimitedContainer(
        child: Form(
          autovalidate: true,
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                color: Theme.of(context).cardColor,
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _CoverSelecter(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoverSelecter extends StatefulWidget {
  _CoverSelecter({Key key}) : super(key: key);

  @override
  __CoverSelecterState createState() => __CoverSelecterState();
}

class __CoverSelecterState extends State<_CoverSelecter> {
  XFile coverFile;

  _onSelectCover() {
    // TODO: 选取封面
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: _onSelectCover,
        child: AspectRatio(
          aspectRatio: 3,
          child: coverFile == null
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).dividerColor.withAlpha(40),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          size: 34,
                        ),
                        Text("选择头图")
                      ],
                    ),
                  ),
                )
              : ExtendedImage.file(coverFile.file),
        ),
      ),
    );
  }
}
