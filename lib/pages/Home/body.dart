import 'package:animated_text_kit/animated_text_kit.dart' as text;
import 'package:elixir/common/constants.dart';
import 'package:elixir/widgets/app_bar.dart';
import 'package:elixir/common/initializer.dart';
import 'package:elixir/pages/Home/button.dart';
import 'package:elixir/pages/Home/image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String getElixirDescription() {
    dynamic details = Init.resources.data;
    if (details == null) return '';
    for (var i = 0; i < details.length; i++) {
      if (details[i]['resource_name'] == 'Elixir_description') {
        return details[i]['resource_desciption'].toString();
      }
    }
    return '';
  }

  List<text.RotateAnimatedText> getAnimatedWidgetList() {
    List<text.RotateAnimatedText> animatedWidgetList = [];
    dynamic details = Init.clubs.data;
    for (var i = 0; i < details.length; i++) {
      if (details[i]['club_name'] != 'Advisory Board') {
        animatedWidgetList.add(
          text.RotateAnimatedText(
            details[i]['club_name'],
            textStyle: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: 25,
                color: Color(
                  int.parse('FF' + details[i]['color_code'], radix: 16),
                ),
              ),
            ),
          ),
        );
      }
    }
    return animatedWidgetList;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: const MyAppBar('Home'),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            alignment: Alignment.topLeft,
            child: text.AnimatedTextKit(
              animatedTexts: [
                text.TypewriterAnimatedText(
                  'Hola Developer 👋🏻 ',
                  textStyle: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ),
          const ImageCarousel(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              getElixirDescription(),
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Clubs Associated',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: 100,
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Horizon',
                color: Colors.deepPurple[900],
              ),
              child: text.AnimatedTextKit(
                repeatForever: true,
                animatedTexts: getAnimatedWidgetList(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Row(
                children: const [
                  Text(
                    'Want to join Elixir - Team? ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Click on the button below',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(child: JoinUsButton()),
        ],
      ),
    );
  }
}
