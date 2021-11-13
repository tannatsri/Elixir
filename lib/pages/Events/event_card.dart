import 'package:elixir/Models/events.dart';
import 'package:elixir/pages/Events/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class EventCard extends StatelessWidget {
  final Events event;
  EventCard(this.event);
  final List<String> months = [
    'Jan',
    "Feb",
    "Mar",
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  @override
  Widget build(BuildContext context) {
    // print(event.event_name);s
    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          screen: EventDetailPage(key, event),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 200,
              margin: const EdgeInsets.fromLTRB(0, 15, 20, 0),
              child: Column(
                children: <Widget>[
                  Text(
                    event.event_start_timestamp.toString().substring(8, 10),
                    style: const TextStyle(
                      color: Color.fromRGBO(8, 6, 41, 0.8),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    months[int.parse(event.event_start_timestamp
                            .toString()
                            .substring(5, 7)) -
                        1],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Hero(
                flightShuttleBuilder: (
                  BuildContext flightContext,
                  Animation<double> animation,
                  HeroFlightDirection flightDirection,
                  BuildContext fromHeroContext,
                  BuildContext toHeroContext,
                ) {
                  final Hero toHero = toHeroContext.widget;
                  return ScaleTransition(
                    scale: Tween<double>(
                      begin: 1,
                      end: 1.0,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                    child: toHero.child,
                  );
                },
                tag: 'as' + event.event_start_timestamp.toString(),
                transitionOnUserGestures: true,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                        event.event_poster_link,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(.4),
                          Colors.black.withOpacity(.1),
                        ],
                      ),
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            event.event_name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.access_time,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                event.event_start_timestamp
                                    .toString()
                                    .substring(11, 16),
                                style: const TextStyle(
                                  color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
