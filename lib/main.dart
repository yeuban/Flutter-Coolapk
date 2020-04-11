import 'dart:io';

import 'package:coolapk_flutter/page/launcher/launcher.page.dart';
import 'package:coolapk_flutter/store/theme.store.dart';
import 'package:coolapk_flutter/store/user.store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  if (Platform.isWindows || Platform.isLinux) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeStore(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserStore(), // 然后在init 中 checkLoginInfo
        ),
      ],
      child: Consumer<ThemeStore>(
        builder: (context, theme, child) {
          return MaterialApp(
            title: 'Coolapk Flutter',
            theme: ThemeData(
              primarySwatch: theme.swatch,
              brightness: theme.brightness,
              fontFamily: "Sarasa-UI-SC-Regular",
              scaffoldBackgroundColor: Color.fromRGBO(242, 242, 246, 1),
            ),
            darkTheme: ThemeData(),
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
