import 'package:cached_network_image/cached_network_image.dart';
import 'package:elixir/common/app_bar.dart';
import 'package:elixir/common/initializer.dart';
import 'package:elixir/pages/Team/club_team.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // print(Init.clubs.data);
    return Scaffold(
      appBar: const MyAppBar('Team'),
      body: Center(
        child: ListView.builder(
          itemCount: Init.clubs.data.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                pushNewScreen(
                  context,
                  screen: ClubTeam(Init.clubs.data[index]),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2,
                  child: Container(
                    color: CupertinoColors.white,
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl: Init.clubs.data[index]['club_logo'],
                              progressIndicatorBuilder: (
                                context,
                                url,
                                downloadProgress,
                              ) =>
                                  JumpingDotsProgressIndicator(
                                fontSize: 20.0,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                              ),
                            ),

                            // Image.network(
                            //   Init.clubs.data[index]['club_logo'],
                            //   fit: BoxFit.contain,
                            //   // scale: 5,
                            // ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: Text(
                              Init.clubs.data[index]['club_name'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
