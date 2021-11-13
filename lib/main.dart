import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:elixir/common/internet_checker.dart';
import 'package:elixir/pages/splash/splash.dart';
import 'package:elixir/widgets/bottom_navbar.dart';
import 'package:elixir/widgets/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'common/initializer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
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
    return OverlaySupport(
      child: FutureBuilder(
        future: Init.main(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: SplashScreen(),
              debugShowCheckedModeBanner: false,
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: BottomNav(0),
            );
          }
        },
      ),
    );
  }
}



















// class App extends StatefulWidget {
//   @override
//   _AppState createState() => _AppState();
// }

// class _AppState extends State<App> {
//   @override
//   void initState() {
//     OverlaySupportEntry entry;
//     DataConnectivityService()
//         .connectivityStreamController
//         .stream
//         .listen((event) {
//       print(event);
//       if (event == DataConnectionStatus.disconnected) {
//         entry = showOverlayNotification((context) {
//           return NetworkErrorAnimation();
//         }, duration: Duration(hours: 1));
//       } else {
//         if (entry != null) {
//           entry.dismiss();
//         }
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return OverlaySupport(
//       child: MaterialApp(
//         title: 'Network Checker App',
//         debugShowCheckedModeBanner: false,
//         home: Homepage(),
//       ),
//     );
//   }
// }