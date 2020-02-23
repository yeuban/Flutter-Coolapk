import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/network/model/main_init.model.dart';

class MainApi {
  static Future<MainInitModel> getInitConfig() async {
    return MainInitModel.fromJson(
      (await Network.apiDio.get("/main/init")).data,
    );
  }
}
