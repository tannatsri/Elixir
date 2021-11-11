import 'package:elixir/Models/events.dart';
import 'package:elixir/common/animations.dart';
import 'package:elixir/common/internet_checker.dart';
import 'package:elixir/pages/No_Internet/no_internet_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailPage extends StatefulWidget {
  // @override    
  final Events event;
  const EventDetailPage(this.event);
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  List<Widget> clickableForm(String link) {
    if (link == 'NA') {
      return [];
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
            bool status = await isThereInternetConnection();

            if (status == true) {
              launch(link);
            } else {
              Navigator.of(context).pushReplacement(
                (MaterialPageRoute(
                  builder: (BuildContext context) {
                    return NoInternetPage();
                  },
                )),
              );
            }
          },
          child: const Text(
            "Click here",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 3,
            primary: Colors.deepPurple[900],
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
          ),
        ),

        // Text(
        //   link,
        //   style: const TextStyle(
        //     color: Colors.grey,
        //   ),
        // ),
      ),
    ];
  }

  Widget build(BuildContext context) {
    String venue = "NA";
    if (widget.event.event_venue != null) venue = widget.event.event_venue;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                        width: heroSize.width,
                        height: heroSize.height,
                        color: Colors.white,
                      );
                    },
                    tag: 'as' + widget.event.event_start_timestamp.toString(),
                    transitionOnUserGestures: true,
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
                          ),
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
                              "Organised by -: " + widget.event.event_organizer,
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
    );
  }
}
