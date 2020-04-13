import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

class TokenInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    options.headers.addAll({
      "X-App-Id": "com.coolapk.market",
      "X-Requested-With": "XMLHttpRequest",
      "X-Api-Version": "10",
      "X-App-Code": "2001021",
      "X-App-Version": "10-beta1",
      "X-Sdk-Int": "23",
      "X-Sdk-Locale": "zh-CN",
      "X-App-Token": buildToken(),
      // "X-App-Device": buildDeviceStr("Flutter Coolapk"), 会引发一些奇怪的bug
    });
    return super.onRequest(options);
  }

  // @override
  // Future onResponse(Response response) {
  //   if (response.data?.data != null) {
  //     response.data = response.data.data;
  //   }
  //   return super.onResponse(response);
  // }

  buildToken() {
    const t = "token://com.coolapk.market/c67ef5943784d09750dcfbb31020f0ab?";
    final did = Uuid().v4();
    const pn = "com.coolapk.market";

    final ts = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    final salt = t +
        md5.convert(utf8.encode(ts.toString())).toString() +
        "\$" +
        did +
        "&" +
        pn;
    final saltMd5 =
        md5.convert(utf8.encode(base64.encode(utf8.encode(salt)))).toString();
    final hexTime = "0x" + ts.toRadixString(16);
    return saltMd5 + did + hexTime;
  }
}

buildDeviceStr(final String device) {
  const androidID = "coolapk-Web";
  const imeiOrMeid = "null";
  const imsi = "null";
  final macAddr = randomMac();
  const manu = "FlutterCoolapk";
  final brand = device;
  final model = device;
  final f = '$androidID; $imeiOrMeid; $imsi; $macAddr; $manu; $brand; $model';
  final f1 = ((base64.encode(utf8.encode(f))).split("")..reversed)
      .join("")
      .replaceAll(r'\\r\\n|\\r|\\n|=', "");
  return f1;
}

randomMac() {
  return [
    (0x52).toRadixString(16),
    (0x54).toRadixString(16),
    (0x00).toRadixString(16),
    (Random().nextDouble() * 0xff).floor().toRadixString(16),
    (Random().nextDouble() * 0xff).floor().toRadixString(16),
    (Random().nextDouble() * 0xff).floor().toRadixString(16),
  ].join(":");
}
