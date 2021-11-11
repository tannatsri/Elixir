import 'package:elixir/common/internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/internet.gif'),
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(26.0),
                child: Text(
                  'No Internet Connection Found! \n\nCheck your internet connection and try again.',
                  style: TextStyle(
                    letterSpacing: 4.5,
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 38.0),
                child: ElevatedButton(
                  onPressed: () async {
                    bool value = await isThereInternetConnection();
                    // print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbb');
                    // print(value);
                    if (value == true) {
                      // pushNewScreen(
                      //   context,
                      //   screen: HomePage(),
                      //   withNavBar: true, // OPTIONAL VALUE. True by default.
                      //   pageTransitionAnimation:
                      //       PageTransitionAnimation.cupertino,
                      // );
                      Navigator.of(context).pop();
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('No Internet Connection found!'),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  primary: Colors.deepPurple[900],
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                ),
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    primary: Colors.deepPurple[900],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    'Home',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
