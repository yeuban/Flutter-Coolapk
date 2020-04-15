import 'package:coolapk_flutter/network/api/notification.dart';
import 'package:coolapk_flutter/network/model/notification.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NotificationStore extends ChangeNotifier {
  List<NotificationModelData> _notifications = [];
  List<NotificationModelData> get notifications => _notifications;

  NotificationStore() {}

  int _page = 1;
  bool _nomore = false;
  bool get nomore => _nomore;
  bool _fetching = false;
  int get _firstItem => _notifications.length > 0 ? _notifications.first.entityId : null;
  int get _lastItem => _notifications.length > 0 ?_notifications.last.entityId : null;
  Future<void> fetch({
    bool nextPage = true,
    bool refresh = false,
  }) async {
    if (_fetching) return;
    if (nextPage) _page++;
    if (refresh) {
      _page = 1;
      _notifications.clear();
    }
    _fetching = true;
    notifyListeners();
    try {
      final resp = await NotificationApi.getNotificationList(
          page: _page, firstItem: _firstItem, lastItem: _lastItem);
      if (resp.data.length == 0) {
        _nomore = true;
        notifyListeners();
        return;
      }
      this._notifications.addAll(resp.data);
    } catch (err, stack) {
      debugPrintStack(stackTrace: stack, label: "/lib/store/notifaction.store.dart:40");
      _fetching = false;
      notifyListeners();
      throw err;
    }
    _fetching = false;
    notifyListeners();
  }

  static NotificationStore of(final BuildContext context,
          {bool listen: false}) =>
      Provider.of<NotificationStore>(context, listen: listen);
}
