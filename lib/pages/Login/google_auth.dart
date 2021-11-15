
import 'package:elixir/widgets/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn google_sign_in = GoogleSignIn();
final FirebaseAuth firebase_auth = FirebaseAuth.instance;




Future<bool> signIn(BuildContext context) async {
  try {
    final GoogleSignInAccount account = await google_sign_in.signIn();
    if (account != null) {
      final GoogleSignInAuthentication gauthentication =
          await account.authentication;

      print(gauthentication);
      final AuthCredential authentication = GoogleAuthProvider.credential(
        accessToken: gauthentication.accessToken,
        idToken: gauthentication.idToken,
      );

      final UserCredential authResult =
          await firebase_auth.signInWithCredential(authentication);

      final User user = authResult.user;
      var userData = {
        'name': account.displayName,
        'email': account.email,
        'photoUrl': account.photoUrl,
        'provider': 'google',
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', user?.uid);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomNav(0)),
      );
    }
  } catch (e) {}

  return true;
}

class Signout {
  static signout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('uid');
    google_sign_in.signOut();
    firebase_auth.signOut();

  }
}
