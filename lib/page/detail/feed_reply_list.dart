import 'package:coolapk_flutter/network/api/main.api.dart';
import 'package:coolapk_flutter/network/model/reply_data_list.model.dart';
import 'package:coolapk_flutter/page/detail/feed_author_tag.dart';
import 'package:coolapk_flutter/util/html_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';

class FeedReplyList extends StatefulWidget {
  final dynamic feedId;
  const FeedReplyList(this.feedId, {Key key}) : super(key: key);

  @override
  _FeedReplyListState createState() => _FeedReplyListState();
}

class _FeedReplyListState extends State<FeedReplyList> {
  List<ReplyDataEntity> _data;
  EasyRefreshController _easyRefreshController;
  int _page = 1;
  bool _nomore = false;

  int get firstItem {
    if (_data == null) return null;
    if (_data.length == 0) return null;
    return _data
        .firstWhere((entity) => (entity.entityId?.toString()?.length ?? 0) >= 4)
        ?.entityId;
  }

  int get lastItem {
    if (_data == null) return null;
    if (_data.length == 0) return null;
    return _data
        .lastWhere((entity) => (entity.entityId?.toString()?.length ?? 0) >= 4)
        ?.entityId;
  }

  Future<bool> fetchData() async {
    final resp = await MainApi.getFeedReplyList(widget.feedId,
        page: _page, firstItem: firstItem, lastItem: lastItem);
    if (_data == null) {
      _data = resp.data;
    } else {
      _data.addAll(resp.data);
    }
    if (resp.data.length == 0) {
      _nomore = true;
    }
    setState(() {});
    return true;
  }

  @override
  void initState() {
    _easyRefreshController = EasyRefreshController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: PhoenixHeader(),
      controller: _easyRefreshController,
      firstRefresh: true,
      footer: BallPulseFooter(),
      onLoad: () async {
        if (_nomore) {
          _easyRefreshController.finishLoad();
          return;
        }
        _page++;
        await fetchData();
        _easyRefreshController.finishLoad();
      },
      onRefresh: () async {
        _page = 1;
        _data?.clear();
        _nomore = false;
        await fetchData();
        _easyRefreshController.finishRefresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return ReplyItem(
            data: _data[index],
            onClick: (uid, cid) {},
          );
        },
        shrinkWrap: true,
        itemCount: _data?.length ?? 0,
      ),
    );
  }
}

class ReplyItem extends StatelessWidget {
  final Function(int uid, int cid) onClick;
  final ReplyDataEntity data;
  const ReplyItem({Key key, @required this.data, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          // TODO:
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExtendedImage.network(
                data.userInfo.userSmallAvatar,
                width: 42,
                height: 42,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          data.username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            // fontWeight: FontWeight.bold,
                            fontSize:
                                Theme.of(context).textTheme.button.fontSize + 2,
                          ),
                        ),
                        data.isFeedAuthor == 1
                            ? FeedAuthorTag()
                            : const SizedBox(),
                      ],
                    ),
                    Divider(color: Colors.transparent, height: 4),
                    HtmlText(
                      html: data.message,
                      shrinkToFit: true,
                      defaultTextStyle: Theme.of(context).textTheme.bodyText1,
                    ),
                    Divider(color: Colors.transparent, height: 4),
                    Row(
                      children: <Widget>[
                        // TODO: time and thumbup
                      ],
                    ),
                    data.replynum == 0
                        ? const SizedBox()
                        : Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              shape: BoxShape.rectangle,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            margin: const EdgeInsets.only(top: 8, bottom: 16),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: data.replyRows
                                  .map<Widget>((row) => InReplyItem(row))
                                  .toList()
                                    ..addAll(
                                      data.replyRowsMore > data.replyRowsCount
                                          ? [
                                              InkWell(
                                                child: Text(
                                                  "显示更多",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              )
                                            ]
                                          : [],
                                    ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InReplyItem extends StatelessWidget {
  final InReplyRowEntity data;
  final Function(int uid, int cid) onClick;
  const InReplyItem(this.data, {Key key, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 2),
      child: HtmlText(
        html:
            "<a style='color: #${Theme.of(context).primaryColor.value.toRadixString(16)}'>${data.username}${data.isFeedAuthor == 1 ? " [楼主]" : ""}: </a>${data.message}",
        shrinkToFit: true,
      ),
    );
  }
}
