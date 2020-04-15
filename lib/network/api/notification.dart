import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/network/model/notification.model.dart';

class NotificationApi {
  static Future<NotificationModel> getNotificationList({
    int page = 1,
    int firstItem,
    int lastItem,
  }) async {
    final resp = await Network.apiDio.get("/notification/list",
        queryParameters: {
          "page": page,
        }
          ..addAll(firstItem != null ? {"firstItem": firstItem} : {})
          ..addAll(lastItem != null ? {"lastItem": lastItem} : {}));
    return NotificationModel.fromJson(resp.data);
  }
}
