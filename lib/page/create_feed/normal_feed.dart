part of 'create_feed.page.dart';

class CreateNormalFeedPage extends StatefulWidget {
  CreateNormalFeedPage({Key key}) : super(key: key);

  @override
  Create_NormalFeedPageState createState() => Create_NormalFeedPageState();
}

class Create_NormalFeedPageState extends State<CreateNormalFeedPage> {
  TextEditingController _fieldCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发布动态"),
        leading: CloseButton(),
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).cardColor,
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final CancelToken cancelToken = CancelToken();
          BuildContext dialogContent;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              dialogContent = context;
              return AlertDialog(
                content: Container(
                  height: 60,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  ),
                ),
                title: Text("发布中..."),
                actions: [
                  FlatButton(
                    child: Text("取消"),
                    onPressed: () {
                      cancelToken.cancel();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
          try {
            final resp = await FeedApi.createFeed(
                message: _fieldCtr.text, cancelToken: cancelToken);
            if (resp["message"] != null) {
              Toast.show(resp["message"], context, duration: 3);
              return;
            }
            print(resp);
            Navigator.pop(context, true);
          } catch (err) {
            Toast.show(err.toString(), context, duration: 3);
          } finally {
            try {
              Navigator.pop(dialogContent);
            } catch (_) {}
          }
        },
        child: Icon(Icons.send),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: _buildBottomToolbar(),
      body: LimitedContainer(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: TextField(
                controller: _fieldCtr,
                decoration: InputDecoration(hintText: "分享你此刻的想法"),
                autocorrect: true,
                minLines: 1,
                maxLines: 10000,
                autofocus: false,
                maxLength: 10000,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomToolbar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        children: [
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
