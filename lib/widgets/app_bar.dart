import 'package:elixir/common/constants.dart';
import 'package:elixir/pages/Login/google_auth.dart';
import 'package:elixir/pages/Login/login.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar(this.title);

  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // iconTheme: const IconThemeData(color: Colors.black),
      elevation: 1,
      backgroundColor: const Color.fromRGBO(8, 6, 41, 1),
      // centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Constants.backgroundColor,
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      child: const Text('No'),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.deepPurple.shade900,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Yes'),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.deepPurple.shade900,
                      ),
                      onPressed: () {
                        Signout.signout();
                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => LoginScreen(),
                          ),
                          (route) =>
                              false, //if you want to disable back feature set to false
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }
}
