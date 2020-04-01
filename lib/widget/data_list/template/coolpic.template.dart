part of './template.dart';

class CoolpicTemplate extends StatefulWidget {
  const CoolpicTemplate({Key key}) : super(key: key);

  @override
  _CoolpicTemplateState createState() => _CoolpicTemplateState();
}

class _CoolpicTemplateState extends State<CoolpicTemplate> {
  DataListConfig innerDataListConfig;

  @override
  void initState() {
    super.initState();
    final config = Provider.of<DataListConfig>(context, listen: false);
    final configCard = config.dataList[0];
    final extraData = jsonDecode(configCard["extraData"]);
    final url = extraData["url"];
    final title = extraData["pageTitle"];
    innerDataListConfig = DataListConfig(url: url, title: title);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<DataListConfig, List<dynamic>>(
      selector: (final _, final config) => config.dataList,
      builder: (context, dataList, child) {
        return EasyRefresh(
          firstRefresh: true,
          onRefresh: () async {
            await innerDataListConfig.refresh;
          },
          onLoad: () async => await innerDataListConfig.nextPage,
          child: CustomScrollView(
            // controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: Theme.of(context).accentColor,
                  height: 60,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    "因Flutter自身问题+我代码问题，酷图页有严重的 性能问题！！\n为了酷安的土豆服务器，和您的电脑运行内存着想，请尽量少用~",
                    style: TextStyle(
                      color: Theme.of(context).accentTextTheme.bodyText1.color,
                    ),
                  ),
                ),
              )
            ]
              ..addAll(dataList
                  .map<Widget>((entity) => AutoItemAdapter(
                        entity: entity,
                        sliverMode: true,
                      ))
                  .toList())
              ..add(
                ChangeNotifierProvider.value(
                  value: innerDataListConfig,
                  child: SliverPadding(
                    padding: const EdgeInsets.all(16).copyWith(top: 8),
                    sliver: CoolpicList(),
                  ),
                ),
              ),
          ),
        );
      },
    );
  }
}

class CoolpicList extends StatelessWidget {
  const CoolpicList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final axisCount = ((width > 860 ? 860 : width) / 280).floor() ?? 1;
    return Consumer<DataListConfig>(
      builder: (context, config, final _) {
        final dataList = config.dataList;
        return SliverWaterfallFlow(
          gridDelegate: SliverWaterfallFlowDelegate(
            crossAxisCount: axisCount <= 0 ? 1 : axisCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final picUrl = dataList[index]["pic"];
              final picRatio = getImageRatio(picUrl);
              return AspectRatio(
                aspectRatio: picRatio,
                child: ExtendedImage.network(
                  picUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  cache: true,
                  filterQuality: FilterQuality.medium,
                ),
              );
            },
            childCount: dataList.length,
          ),
        );
      },
    );
  }
}
