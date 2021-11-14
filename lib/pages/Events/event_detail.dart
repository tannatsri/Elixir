import 'package:elixir/Models/events.dart';
import 'package:elixir/common/constants.dart';
import 'package:elixir/pages/NoInternet/no_internet_page.dart';
import 'package:elixir/widgets/animations.dart';
import 'package:elixir/common/internet_checker.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailPage extends StatefulWidget {
  // @override
  final Events event;
  const EventDetailPage(key, this.event);
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  List<Widget> clickableForm(String link, DateTime time) {
    if (link == 'NA') {
      return [];
    }
    bool activeForm = false;
    if (DateTime.now().isBefore(time)) {
      activeForm = true;
    }

    return [
      const FadeAnimation(
        1.6,
        Text(
          "Register Now!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      FadeAnimation(
        1.6,
        ElevatedButton(
          onPressed: () async {
            if (!activeForm) {
              return;
            }

            bool status = await isThereInternetConnection();

            var url = link;

            if (status) {
              await launch('http://' + url);
            } else {
              pushNewScreen(
                context,
                screen: NoInternetPage(),
                withNavBar: false,
              );
              Navigator.of(context).pushReplacement(
                (MaterialPageRoute(
                  builder: (BuildContext context) {
                    return NoInternetPage();
                  },
                )),
              );
            }
          },
          child: Text(
            activeForm ? "Register" : 'Registration Over',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 3,
            primary: activeForm ? Colors.deepPurple[900] : Colors.grey[400],
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    String venue = "NA";
    if (widget.event.event_venue != null) venue = widget.event.event_venue;
    return Scaffold(
      body: Material(
        color: Constants.backgroundColor,
        child: Stack(
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 450,
                  backgroundColor: Colors.black,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Hero(
                      placeholderBuilder: (
                        BuildContext context,
                        Size heroSize,
                        Widget child,
                      ) {
                        return Container(
                          color: Constants.backgroundColor,
                        );
                      },
                      tag: 'as' + widget.event.event_start_timestamp.toString(),
                      transitionOnUserGestures: false,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.event.event_poster_link,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                                Colors.black,
                                Colors.black.withOpacity(.3),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FadeAnimation(
                                  1,
                                  Text(
                                    widget.event.event_name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: <Widget>[
                                    FadeAnimation(
                                      1.2,
                                      Text(
                                        widget.event.event_start_timestamp
                                            .toString()
                                            .substring(0, 10),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    FadeAnimation(
                                      1.3,
                                      Text(
                                        widget.event.event_start_timestamp
                                            .toString()
                                            .substring(11, 16),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FadeAnimation(
                              1.6,
                              Text(
                                widget.event.event_description,
                                style: const TextStyle(
                                  color: Colors.black,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            ...clickableForm(
                                widget.event.event_registration_link,
                                widget.event.event_start_timestamp),
                            const SizedBox(
                              height: 20,
                            ),
                            const FadeAnimation(
                              1.6,
                              Text(
                                "Event venue",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FadeAnimation(
                              1.6,
                              Text(
                                venue,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                              1.6,
                              Text(
                                "Organised by -: " +
                                    widget.event.event_organizer,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 120,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
