import 'dart:convert';
import 'dart:math';

import 'package:coolapk_flutter/util/fake_device.dart';
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
      "X-App-Device": buildDeviceStr("Flutter Coolapk"), // 会引发一些奇怪的bug
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
  final device = FakeDevice.get();
  String androidId = randomNum("1234567890abcdefchijklmnopqrstuvwxyz");

  /**IMEI(International Mobile Equipment Identity)是国际移动设备身份码的缩写，国际移动装备辨识码，是由15位数字组成的”电子串号”，它与每台移动电话机一一对应，而且该码是全世界唯一的。每一只移动电话机在组装完成后都将被赋予一个全球唯一的一组号码，这个号码从生产到交付使用都将被制造生产的厂商所记录。
PS：通俗来讲就是标识你当前设备(手机)全世界唯一，类似于个人身份证，这个肯定唯一啦~ */
  String imei = randomNum();

/**国际移动用户识别码（IMSI：International Mobile Subscriber Identification
Number）是区别移动用户的标志，储存在SIM卡中，可用于区别移动用户的有效信息。其总长度不超过15位，同样使用0~9的数字。其中MCC是移动用户所属国家代号，占3位数字，中国的MCC规定为460；MNC是移动网号码，由两位或者三位数字组成，中国移动的移动网络编码（MNC）为00；用于识别移动用户所归属的移动通信网；MSIN是移动用户识别码，用以识别某一移动通信网中的移动用户
PS：通俗来讲就是标识你当前SIM卡(手机卡)唯一，同样类似于个人身份证，肯定唯一啦~*/
  String imsi = randomNum("1234567890abcdefchijklmnopqrstuvwxyz");
  String macAddr = randomMac();
  String manufacturer = device.manufacturer; // Meizu
  String brand = device.brand; // Meizu
  String model = device.model; // M351

  final rb64 = base64
      .encode(utf8.encode(
          "$androidId; $imei; $imsi; $macAddr; $manufacturer; $brand; $model"))
      .split("")
      .reversed
      .join()
      .replaceAll(RegExp(r'\\r\\n|\\r|\\n|='), "");
  return rb64;
}

String randomNum([a]) {
  String alphabet = a ?? '1234567890';
  int strlenght = 15;
  String left = '';
  for (var i = 0; i < strlenght; i++) {
    left = left + alphabet[Random().nextInt(alphabet.length)];
  }
  return left;
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
