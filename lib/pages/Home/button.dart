import 'package:elixir/common/initializer.dart';
import 'package:elixir/common/internet_checker.dart';
import 'package:elixir/pages/No_Internet/no_internet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';

class JoinUsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String getFormLink() {
      for (int i = 0; i < Init.resources.data.length; ++i) {
        if (Init.resources.data[i]['resource_name'] == 'join_us_form_link') {
          return Init.resources.data[i]['resource_link'].toString();
        }
      }
      return "";
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedButton(
        onPress: () async {
          var url = getFormLink();
          var status = await isThereInternetConnection();

          if (status) {
            await launch('http://' + url);
          } else {
            pushNewScreen(
              context,
              screen: NoInternetPage(),
              withNavBar: false,
            );
            Navigator.of(context).pushReplacement((MaterialPageRoute(
              builder: (BuildContext context) {
                return NoInternetPage();
              },
            )));
          }
        },
        height: 40,
        width: 120,
        text: 'Join Us',
        isReverse: true,
        selectedTextColor: Colors.white,
        selectedBackgroundColor: Colors.black,
        transitionType: TransitionType.RIGHT_BOTTOM_ROUNDER,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple.shade900,
        borderColor: Colors.deepPurple.shade900,
        borderWidth: 1,
      ),
    );
  }
}
