import 'package:coolapk_flutter/widget/limited_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
 * 返回机型相关信息
 * model e.g. M57A
 * brand e.g. 魅蓝
 * name e.g. 魅蓝 metal 公开版
 */
class ModelSelectorPage extends StatefulWidget {
  ModelSelectorPage({Key key}) : super(key: key);

  @override
  _ModelSelectorPageState createState() => _ModelSelectorPageState();
}

class _ModelSelectorPageState extends State<ModelSelectorPage> {
  DeviceInfo _nowSelected;
  List<DeviceInfo> _mobileList;

  @override
  void initState() {
    super.initState();
    _getAll();
  }

  Future<void> _getAll() async {
    final str = await rootBundle.loadString("assets/res/mobile");
    List<DeviceInfo> list = [];
    str.replaceAll("\r", "").split("\n").every((line) {
      final splited = line.split(":");
      // #型号:名称:品牌:品牌厂商中文:品牌厂商英文:品牌中文:品牌英文
      list.add(DeviceInfo(
          model: splited[0],
          name: splited[1],
          brand: splited[6],
          manufacturer: splited[4]));
      return true;
    });
    _mobileList = list;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: DeviceSearchDelegate(this._mobileList ?? []));
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context, this._nowSelected);
            },
            icon: Icon(Icons.check),
          ),
        ],
        title: Text(
            "选择机型: ${_nowSelected != null ? "当前选择: ${_nowSelected.manufacturer} ${_nowSelected.name} ${_nowSelected.model}" : ""}"),
      ),
      body: _mobileList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final now = _mobileList[index];
                return LimitedContainer(
                  child: RadioListTile(
                    selected: _nowSelected == now,
                    groupValue: _mobileList.indexOf(_nowSelected),
                    value: index,
                    title: Text("${now.name}"),
                    subtitle: Text("${now.model}"),
                    onChanged: (value) {
                      this._nowSelected = now;
                      setState(() {});
                    },
                  ),
                );
              },
              itemCount: _mobileList?.length ?? 0,
            ),
    );
  }
}

class DeviceSearchDelegate extends SearchDelegate {
  List<DeviceInfo> _mobileList;
  DeviceSearchDelegate(this._mobileList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return LimitedContainer(
      child: Text("未完成"),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return LimitedContainer(
      child: Text("未完成"),
    );
  }
}

class DeviceInfo {
  String brand;
  String name;
  String model;
  String manufacturer;
  DeviceInfo({
    this.brand,
    this.name,
    this.model,
    this.manufacturer,
  });
}
