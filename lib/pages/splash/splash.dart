import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 242, 250, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
            ),

            // Image.asset('assets/images/logo.png', scale: 5),

            const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Elixir - The Tech Community',
                  style: TextStyle(
                    letterSpacing: 4.5,
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
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
