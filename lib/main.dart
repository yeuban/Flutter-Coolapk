import 'dart:io';

import 'package:coolapk_flutter/network/dio_setup.dart';
import 'package:coolapk_flutter/widget/common_error_widget.dart';
import 'package:coolapk_flutter/page/home/home.page.dart';
import 'package:coolapk_flutter/store/theme.store.dart';
import 'package:coolapk_flutter/store/user.store.dart';
import 'package:coolapk_flutter/util/global_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<bool> setupComponent() async {
  await GlobalStorage.setupGlobalStorage();
  await Network.setupNetwork();
  return true;
}

Future<bool> init(final BuildContext context) async {
  //
  await Provider.of<UserStore>(context).checkLoginInfo();
  return true;
}

void main() {
  Provider.debugCheckInvalidValueType = null;
  if (Platform.isWindows || Platform.isLinux) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  runApp(
    FutureBuilder(
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          return MultiProvider(providers: [
            ChangeNotifierProvider(
              create: (context) => ThemeStore(),
            ),
            ChangeNotifierProvider(
              create: (context) => UserStore(), // 然后在init 中 checkLoginInfo
            ),
          ], child: MyApp());
        } else {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
      future: setupComponent(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeStore>(
      builder: (context, theme, child) {
        return MaterialApp(
          title: 'Coolapk Flutter',
          theme: ThemeData(
            primarySwatch: theme.swatch,
            brightness: theme.brightness,
            fontFamily: "Sarasa-UI-SC-Regular",
          ),
          home: child,
          debugShowCheckedModeBanner: false,
        );
      },
      child: FutureBuilder(
        builder: (context, snap) {
          if (snap.hasData) {
            return HomePage();
          } else if (snap.hasError) {
            return CommonErrorWidget(
              error: snap.error,
              onRetry: () {
                setState(() {});
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: init(context),
      ),
    );
  }
}
