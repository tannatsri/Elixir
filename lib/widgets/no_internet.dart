import 'dart:ui' as ui;

import 'package:flutter/material.dart';


class NetworkErrorAnimation extends StatefulWidget {
  @override
  _NetworkErrorAnimationState createState() => _NetworkErrorAnimationState();
}

class _NetworkErrorAnimationState extends State<NetworkErrorAnimation> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaX: 5.0,
        sigmaY: 5.0,
      ),
      child: Dialog(
        insetPadding: const EdgeInsets.all(0.0),
        backgroundColor: Colors.white.withOpacity(0.1),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.99,
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
            ],
          ),
        ),
      ),
    );
  }
}
