part of 'notification.page.dart';

class NotificationList extends StatefulWidget {
  NotificationList({Key key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  EasyRefreshController _refreshCtr = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: _refreshCtr,
      onLoad: () async {
        final store = NotificationStore.of(context);
        if (store.nomore) {
          _refreshCtr.finishLoad();
          return;
        }
        try {
          await store.fetch();
        } catch (err, stack) {
          debugPrintStack(stackTrace: stack);
          Toast.show(err.toString(), context, duration: 2);
        }
        _refreshCtr.finishLoad();
      },
      onRefresh: () async {
        final store = NotificationStore.of(context);
        try {
          await store.fetch(refresh: true);
        } catch (err, stack) {
          debugPrintStack(stackTrace: stack);
          Toast.show(err.toString(), context, duration: 2);
        }
        _refreshCtr.finishRefresh();
      },
      child: CustomScrollView(
        slivers: _buildBase(context)
          ..add(
            Selector<NotificationStore, List<NotificationModelData>>(
              selector: (_, store) => store.notifications,
              shouldRebuild: (old, tnew) {
                return tnew.length != old ||
                    tnew.any(
                        (el) => el.entityId != old[tnew.indexOf(el)].entityId);
              },
              builder: (context, notifications, child) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final notification = notifications[index];
                      final time = DateTime.fromMillisecondsSinceEpoch(
                          notification.dateline * 1000);
                      final howDaysAgo =
                          (time.difference(DateTime.now()).inDays.abs());
                      final howHoursAgo =
                          (time.difference(DateTime.now()).inHours.abs());
                      final howMinutesAge =
                          (time.difference(DateTime.now()).inMinutes.abs());
                      String titleLeading = "";
                      if (howDaysAgo > 30) {
                        titleLeading =
                            "${time.year < DateTime.now().year ? time.year.toString() + "年" : ""}${time.month}月${time.day}日";
                      } else if (howDaysAgo >= 1) {
                        titleLeading = "$howDaysAgo天前";
                      } else if (howHoursAgo >= 1) {
                        titleLeading = "$howHoursAgo小时前";
                      } else {
                        titleLeading = "$howMinutesAge}分钟前";
                      }
                      return _buildItem(
                        context,
                        index: index,
                        lastedIndex: (notifications.length - 1) < 0
                            ? 0
                            : notifications.length - 1,
                        title: notification.fromusername,
                        titleLeading: titleLeading,
                        subTitle: notification.note,
                        icon: notification.fromUserAvatar,
                        sliver: false,
                      );
                    },
                    childCount: notifications.length,
                  ),
                );
              },
            ),
          ),
      ),
    );
  }

  List<Widget> _buildBase(final BuildContext context) {
    return [
      SliverToBoxAdapter(child: Divider(color: Colors.transparent)),
      _buildItem(
        context,
        title: "@我的动态",
        leading: Icon(Icons.alternate_email, color: Colors.white),
        leadingColor: Colors.blueAccent,
        onClick: () {},
        trailing: Icon(Icons.chevron_right),
        index: 0,
        lastedIndex: 5,
      ),
      _buildItem(
        context,
        title: "@我的评论",
        leading: ExtendedImage.asset(
            "assets/images/coolapk/ic_comment_outline_white_24dp.png"),
        leadingColor: Colors.cyan,
        onClick: () {},
        trailing: Icon(Icons.chevron_right),
        index: 1,
        lastedIndex: 5,
      ),
      _buildItem(
        context,
        title: "我收到的赞",
        leading: ExtendedImage.asset(
            "assets/images/coolapk/ic_thumb_up_outline_white_24dp.png"),
        leadingColor: Colors.green,
        onClick: () {},
        trailing: Icon(Icons.chevron_right),
        index: 2,
        lastedIndex: 5,
      ),
      _buildItem(
        context,
        title: "好友关注",
        leading: Icon(Icons.add_circle_outline, color: Colors.white),
        leadingColor: Colors.red,
        onClick: () {},
        trailing: Icon(Icons.chevron_right),
        index: 3,
        lastedIndex: 5,
      ),
      _buildItem(
        context,
        title: "私信",
        leading: Icon(Icons.mail_outline, color: Colors.white),
        leadingColor: Colors.orange,
        onClick: () {},
        trailing: Icon(Icons.chevron_right),
        index: 4,
        lastedIndex: 5,
      ),
    ];
  }

  Widget _buildItem(
    final BuildContext context, {
    String icon,
    Widget leading,
    Color leadingColor,
    String titleLeading = "",
    @required String title,
    String subTitle,
    Function onClick,
    Widget trailing,
    int index,
    int lastedIndex,
    bool sliver = true,
    bool isNew = false,
  }) {
    final content = LimitedContainer(
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        decoration: index != null
            ? BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(index == 0 ? 8 : 0),
                  bottom: Radius.circular(index == lastedIndex ? 8 : 0),
                ),
              )
            : null,
        child: ListTile(
          onTap: onClick,
          trailing: trailing,
          title: Row(
            children: [
              Text(title),
              Spacer(),
              Text(titleLeading),
            ],
          ),
          subtitle: subTitle != null
              ? HtmlText(
                  html: subTitle,
                  shrinkToFit: true,
                  linkStyle: TextStyle(
                    color: isNew
                        ? Theme.of(context).accentColor
                        : Theme.of(context).textTheme.bodyText1.color,
                  ),
                )
              : null,
          leading: Container(
            padding: const EdgeInsets.all(6),
            height: double.infinity,
            child: AspectRatio(
              aspectRatio: 1,
              child: PhysicalModel(
                color: leadingColor ?? Colors.white,
                borderRadius: BorderRadius.circular(100),
                child: leading != null
                    ? Center(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: 24, maxHeight: 24),
                          child: leading,
                        ),
                      )
                    : ExtendedImage.network(
                        icon,
                        width: double.infinity,
                        height: double.infinity,
                        shape: BoxShape.circle,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
    if (!sliver) return content;
    return SliverToBoxAdapter(
      child: content,
    );
  }

  _buildIconWidgetFromAssets(String path) {
    return ExtendedImage.asset(path);
  }
}
