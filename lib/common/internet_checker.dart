import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

Future<dynamic> isThereInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}









// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Map _source = {ConnectivityResult.none: false};
//   final MyConnectivity _connectivity = MyConnectivity.instance;

//   @override
//   void initState() {
    // super.initState();
    // _connectivity.initialise();
    // _connectivity.myStream.listen((source) {
    //   setState(() => _source = source);
    // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     String string;
//     switch (_source.keys.toList()[0]) {
//       case ConnectivityResult.mobile:
//         string = 'Mobile: Online';
//         break;
//       case ConnectivityResult.wifi:
//         string = 'WiFi: Online';
//         break;
//       case ConnectivityResult.none:
//       default:
//         string = 'Offline';
//     }

//     return Scaffold(
//       body: Center(child: Text(string)),
//     );
//   }

//   @override
//   void dispose() {
//     _connectivity.disposeStream();
//     super.dispose();
//   }
// }

// class MyConnectivity {
//   MyConnectivity._();

//   static final _instance = MyConnectivity._();
//   static MyConnectivity get instance => _instance;
//   final _connectivity = Connectivity();
//   final _controller = StreamController.broadcast();
//   Stream get myStream => _controller.stream;

//   void initialise() async {
//     ConnectivityResult result = await _connectivity.checkConnectivity();
//     _checkStatus(result);
//     _connectivity.onConnectivityChanged.listen((result) {
//       _checkStatus(result);
//     });
//   }

//   void _checkStatus(ConnectivityResult result) async {
//     bool isOnline = false;
    
//     try {
//       final result = await InternetAddress.lookup('https://www.google.com');
//       isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } on SocketException catch (_) {
//       isOnline = false;
//     }
//     _controller.sink.add({result: isOnline});
//   }

//   void disposeStream() => _controller.close();
// }






class DataConnectivityService {
  StreamController<DataConnectionStatus> connectivityStreamController =
      StreamController<DataConnectionStatus>();
  DataConnectivityService() {
    DataConnectionChecker().onStatusChange.listen((dataConnectionStatus) {
      connectivityStreamController.add(dataConnectionStatus);
    });
  }
}