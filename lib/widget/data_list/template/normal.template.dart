part of './template.dart';

class NormalTemplate extends StatefulWidget {
  NormalTemplate({Key key}) : super(key: key);

  @override
  _NormalTemplateState createState() => _NormalTemplateState();
}

class _NormalTemplateState extends State<NormalTemplate>
    with LoadMoreMixinState<NormalTemplate> {
  EasyRefreshController _controller = EasyRefreshController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataListConfig>(
      builder: (final context, final config, final _) {
        return EasyRefresh.custom(
          controller: _controller,
          scrollController: _scrollController,
          firstRefresh: config.state == DataListConfigState.Firstime,
          onRefresh: () async {
            await config.refresh;
            _controller.finishRefresh(success: true);
          },
          enableControlFinishLoad: false,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => AutoItemAdapter(
                  entity: config.dataList[index],
                  sliverMode: false,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
