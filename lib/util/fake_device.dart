import 'package:coolapk_flutter/page/model_selector/model_selector.page.dart'
    show DeviceInfo;
import 'package:coolapk_flutter/util/global_storage.dart';

class FakeDevice {
  static DeviceInfo get() {
    final brand = GlobalStorage()
        .get(box: "fake_device", key: "brand", defaultValue: "魅蓝");
    final name = GlobalStorage()
        .get(box: "fake_device", key: "name", defaultValue: "魅蓝 metal 公开版");
    final model = GlobalStorage()
        .get(box: "fake_device", key: "model", defaultValue: "M57A");
    final manufacturer = GlobalStorage()
        .get(box: "fake_device", key: "manufacturer", defaultValue: "Meizu");
    return DeviceInfo(
        brand: brand, name: name, model: model, manufacturer: manufacturer);
  }

  static set(DeviceInfo info) {
    GlobalStorage()
      ..set(box: "fake_device", key: "brand", value: info.brand)
      ..set(box: "fake_device", key: "name", value: info.name)
      ..set(box: "fake_device", key: "model", value: info.model)
      ..set(box: "fake_device", key: "manufacturer", value: info.manufacturer);
  }
}
