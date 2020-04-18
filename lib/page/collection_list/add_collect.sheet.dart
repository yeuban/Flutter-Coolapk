import 'package:coolapk_flutter/network/api/main.api.dart';
import 'package:coolapk_flutter/network/model/collection.model.dart';
import 'package:coolapk_flutter/page/collection_list/new_collection.page.dart';
import 'package:coolapk_flutter/store/user.store.dart';
import 'package:coolapk_flutter/util/anim_page_route.dart';
import 'package:coolapk_flutter/widget/limited_container.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AddCollectSheet extends StatefulWidget {
  final dynamic targetId;
  AddCollectSheet({Key key, @required this.targetId}) : super(key: key);

  @override
  _AddCollectSheetState createState() => _AddCollectSheetState();
}

class _AddCollectSheetState extends State<AddCollectSheet> {
  CollectionModel _collectionModel;

  int _page = 1;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<bool> fetchData() async {
    final uid = UserStore.getUserUid(context);
    if (uid == null) {
      // showToLoginSnackBar(context);
      Toast.show("请先登录哦", context, duration: 2);
      // Navigator.pop(context);
      return false;
    }
    _collectionModel =
        await MainApi.getCollections(targetId: widget.targetId, page: _page);
    return true;
  }

  final List<int> _checkList = [];

  add(int value) {
    _checkList.add(value);
  }

  remove(int value) {
    try {
      _checkList.remove(value);
    } catch (err) {}
  }

  bool inSubmission = false;

  commit() async {
    var _cancelList = <int>[];
    var _addList = <int>[];
    _collectionModel.data.every((e) {
      if (e.isBeCollected == 1 && !_checkList.contains(e.id)) {
        _cancelList.add(e.id);
      } else if (e.isBeCollected == 0 && _checkList.contains(e.id)) {
        _addList.add(e.id);
      }
      return true;
    });
    print("$_addList" + "|$_cancelList");
    setState(() {
      inSubmission = true;
    });
    try {
      final resp = await MainApi.addCollectionItem(widget.targetId, _addList,
          cancelIds: _cancelList);
      if (resp["message"] != null) {
        Toast.show(resp["message"], context);
      } else {
        Navigator.of(context).pop(true);
      }
    } catch (err) {
      Toast.show(err.toString(), context);
    }
    setState(() {
      inSubmission = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 400),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppBar(
            elevation: 0,
            textTheme: Theme.of(context).textTheme,
            iconTheme: Theme.of(context).iconTheme,
            actionsIconTheme: Theme.of(context).iconTheme,
            backgroundColor: Theme.of(context).cardColor,
            title: Text("选择收藏单"),
            leading: BackButton(
              onPressed: () {},
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Theme.of(context).accentColor,
                child: Text("新建收藏单"),
                onPressed: () {
                  Navigator.of(context)
                      .push(ScaleInRoute(widget: NewCollectionPage()));
                },
              ),
            ],
          ),
          Expanded(
            child: LimitedContainer(
              child: FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == false){
                      Navigator.pop(context);
                    }
                    return ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: _collectionModel.data.map((entity) {
                        return _CollectionItem(data: entity);
                      }).toList(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ),
          inSubmission
              ? CircularProgressIndicator()
              : MaterialButton(
                  minWidth: double.infinity,
                  textColor: Theme.of(context).accentColor,
                  child: Text("完成"),
                  onPressed: () {
                    commit();
                  },
                ),
        ],
      ),
    );
  }
}

class _CollectionItem extends StatefulWidget {
  final CollectionEntity data;
  _CollectionItem({Key key, this.data}) : super(key: key);

  @override
  __CollectionItemState createState() => __CollectionItemState();
}

class __CollectionItemState extends State<_CollectionItem> {
  bool selected;
  CollectionEntity get data => widget.data;

  @override
  void initState() {
    selected = widget.data.isBeCollected == 1;
    super.initState();
  }

  toggle([bool value]) {
    selected = value ?? !selected;
    if (selected) {
      context.findAncestorStateOfType<_AddCollectSheetState>().add(data.id);
    } else {
      context.findAncestorStateOfType<_AddCollectSheetState>().remove(data.id);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: toggle,
      selected: selected,
      title: Text(data.title),
      subtitle:
          Text("${data.isOpenTitle} ${data.followNum}人关注 ${data.itemNum}个内容"),
      trailing: Checkbox(
        value: selected,
        onChanged: (value) => toggle(value),
      ),
    );
  }
}
