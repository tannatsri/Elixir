import 'package:elixir/common/app_bar.dart';
import 'package:elixir/common/initializer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

List<Widget> getContactCardList() {
  List<Widget> contactCardList = [];
  // print(Init.resources.data[0]['id']);
  for (int i = 0; i < Init.resources.data.length; i++) {
    dynamic data = Init.resources.data[i];
    if (data["resource_page"] == "ContactUs") {
      contactCardList.add(
        contactCard(
          data["resource_title"],
          data["resource_link"],
          data["resource_image_url"],
        ),
      );
    }
  }
  return contactCardList;
}

String getLogoLink() {
  for (int i = 0; i < Init.resources.data.length; i++) {
    dynamic data = Init.resources.data[i];
    if (data["resource_page"] == "Common") {
      return data["resource_image_url"];
    }
  }
  return "";
}

Widget contactCard(String title, String link, String imageUrl) {
  return Card(
    elevation: 5,
    child: ListTile(
      leading: Image.network(
        imageUrl,
        width: 50,
      ),
      title: Text(title),
      subtitle: Text(link),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        launchURL(link);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
    ),
  );
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    getContactCardList();
    return Scaffold(
      appBar: const MyAppBar('Connect with us'),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepPurple,
                    Color.fromRGBO(8, 6, 41, 1),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.6,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: getContactCardList(),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.width * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
