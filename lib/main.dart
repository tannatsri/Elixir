import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:elixir/common/internet_checker.dart';
import 'package:elixir/pages/Login/login.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'common/initializer.dart';

import 'widgets/widgets.dart';
import 'pages/pages.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    OverlaySupportEntry entry;
    DataConnectivityService().connectivityStreamController.stream.listen(
      (event) {
        if (event == DataConnectionStatus.disconnected) {
          entry = showOverlayNotification(
            (context) {
              return NetworkErrorAnimation();
            },
            duration: const Duration(hours: 2),
          );
        } else {
          if (entry != null) {
            entry.dismiss();
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return OverlaySupport(
      child: FutureBuilder(
        future: Init.main(context),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: SplashScreen(),
              debugShowCheckedModeBanner: false,
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Init.userStatus ? BottomNav(0) : LoginScreen(),
            );
          }
        },
      ),

    );
  }
}
