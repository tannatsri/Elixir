import 'package:elixir/common/app_bar.dart';
import 'package:elixir/pages/Home/image_carousel.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('Home'),
      body: Column(
        children: [
          ImageCarousel(),
        ],
      ),
    );
  }
}
