import 'package:connectivity_plus/connectivity_plus.dart';

Future<dynamic> isThereInternetConnection() async {
  // bool value = await canLaunch('https://www.google.com/');
  // return value;

  // try {
  //   final result = await InternetAddress.lookup('https://www.google.com/');
  //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //     return true;
  //   }
  //   return false;
  // } on SocketException catch (_) {
  //   return false;
  // }
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network.
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a wifi network.
    return true;
  }
  return false;
}
