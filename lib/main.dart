import 'package:coolapk_flutter/page/launcher/launcher.page.dart';
import 'package:coolapk_flutter/store/theme.store.dart';
import 'package:coolapk_flutter/store/user.store.dart';
import 'package:coolapk_flutter/util/global_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  final globalStorage = GlobalStorage();
  await globalStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeStore(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserStore(), // 然后在init 中 checkLoginInfo
        ),
        Provider.value(
          value: globalStorage,
        )
      ],
      child: Consumer<ThemeStore>(
        builder: (context, theme, child) {
          return MaterialApp(
            title: 'Coolapk Flutter',
            theme: ThemeData(
              primarySwatch: theme.swatch,
              brightness: theme.brightness,
              fontFamily: "Sarasa-UI-SC-Regular",
              scaffoldBackgroundColor:
                  theme.dark ? null : Color.fromRGBO(242, 242, 246, 1),
            ),
            darkTheme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.black,
            ),
            home: LauncherPage(),
            // home: child,
            debugShowCheckedModeBanner: false,
          );
        },
        child: LauncherPage(),
      ),
    ),
  );
}
