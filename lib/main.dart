import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:elixir/common/internet_checker.dart';
import 'package:elixir/pages/Events/event_page.dart';
import 'package:elixir/pages/splash/splash.dart';
import 'package:elixir/widgets/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'common/initializer.dart';
import 'pages/ContactUs/contact_page.dart';
import 'pages/Home/homepage.dart';
import 'pages/Team/team_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

List<PersistentBottomNavBarItem> navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.home),
      title: "Home",
      iconSize: 17,
      activeColorPrimary: Colors.deepPurple.shade900,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      iconSize: 17,
      icon: const Icon(CupertinoIcons.calendar),
      title: ("Events"),
      activeColorPrimary: Colors.deepPurple.shade900,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      iconSize: 17,
      icon: const Icon(CupertinoIcons.person_3_fill),
      title: ("Team"),
      activeColorPrimary: Colors.deepPurple.shade900,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      iconSize: 17,
      icon: const Icon(CupertinoIcons.info_circle_fill),
      title: ("Connnect"),
      activeColorPrimary: Colors.deepPurple.shade900,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}

List<Widget> buildScreens() {
  return [
    const HomePage(),
    EventPage(),
    const TeamPage(),
    const ContactUsPage()
  ];
}

class BottomNav extends StatefulWidget {
  final int index;
  BottomNav(this.index);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  void initState() {
    OverlaySupportEntry entry;
    DataConnectivityService()
        .connectivityStreamController
        .stream
        .listen((event) {
      print(event);
      if (event == DataConnectionStatus.disconnected) {
        entry = showOverlayNotification((context) {
          return NetworkErrorAnimation();
        }, duration: Duration(hours: 1));
      } else {
        if (entry != null) {
          entry.dismiss();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: const NavBarDecoration(
        // borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        // animateTabTransition: true,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}

class MyApp extends StatelessWidget {
  // const MyApp({ Key? key }) : super(key: key);

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