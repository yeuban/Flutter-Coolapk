import 'package:coolapk_flutter/widget/data_list/data_list.dart';
import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  final dynamic data;

  TabPage({Key key, @required this.data}) : super(key: key);

  @override
  TabPageState createState() => TabPageState();
}

class TabPageState extends State<TabPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  DataListConfig _dataListConfig;
  @override
  void initState() {
    _dataListConfig = DataListConfig(
      title: widget.data.title,
      url: widget.data.url,
    );
    super.initState();
  }

  refresh() {
    _dataListConfig.refresh;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DataListPage(_dataListConfig);
    // return DataListPageFrameWidget();
  }
}
