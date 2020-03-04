part of './template.dart';

mixin LoadMoreMixinState<T extends StatefulWidget> on State<T> {
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final config = Provider.of<DataListConfig>(context, listen: false);
      if (_scrollController.position.pixels >=
              (_scrollController.position.maxScrollExtent - 200) &&
          config.dataList.length > 0 &&
          config.state != DataListConfigState.NoMore &&
          config.state != DataListConfigState.Loading &&
          config.state != DataListConfigState.Firstime) {
        config.nextPage;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
