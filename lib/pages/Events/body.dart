import 'package:elixir/Models/events.dart';
import 'package:elixir/common/constants.dart';
import 'package:elixir/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: const MyAppBar('Events'),
      body: ListView(
        children: [
          ...Events.getPresentEventWidget(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey),
          ),
          ...Events.getPastEventWidget(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey),
          ),
          ...Events.getFutureEventWidget()
        ],
      ),

      // EventCard(Init.events.data),
    );
  }
}
