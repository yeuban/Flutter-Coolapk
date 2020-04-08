part of 'create_feed.page.dart';

class CreateHtmlArticleFeedPage extends StatefulWidget {
  CreateHtmlArticleFeedPage({Key key}) : super(key: key);

  @override
  _CreateHtmlArticleFeedPageState createState() =>
      _CreateHtmlArticleFeedPageState();
}

class _CreateHtmlArticleFeedPageState extends State<CreateHtmlArticleFeedPage> {
  FeedPublicType _feedPublicType = FeedPublicType.anyone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () {
          //TODO:
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.crop_original),
              onPressed: () {
                // TODO:
              },
            ),
            IconButton(
              icon: Icon(Icons.sentiment_very_satisfied),
              onPressed: () {
                // TODO:
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Theme.of(context).cardColor,
            iconTheme: Theme.of(context).iconTheme,
            textTheme: Theme.of(context).textTheme,
            leading: CloseButton(),
            title: Text("发布图文"),
            expandedHeight: MediaQuery.of(context).size.width / (3 / 1),
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
                  decoration: InputDecoration(hintText: "标题"),
                ),
              ),
              SliverToBoxAdapter(
                child: TextField(
                  autofocus: false,
                  maxLines: 10,
                  decoration: InputDecoration(hintText: "正文"),
                ),
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
}
