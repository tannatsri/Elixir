import 'package:elixir/common/initializer.dart';
import 'package:elixir/pages/Events/event_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Events {
  int id;
  String event_name;
  String event_description;
  DateTime event_start_timestamp;
  DateTime event_end_timestamp;
  String event_registration_link;
  String event_organizer;
  String event_poster_link;
  String event_venue;
  Events({
    this.id,
    this.event_name,
    this.event_description,
    this.event_start_timestamp,
    this.event_end_timestamp,
    this.event_registration_link,
    this.event_organizer,
    this.event_poster_link,
    this.event_venue,
  });

  static getEventdetails() {
    List details = Init.events.data;
    List<Events> eventList = [];
    for (int i = 0; i < details.length; i++) {
      eventList.add(
        Events(
          id: details[i]['id'],
          event_name: details[i]['event_name'],
          event_description: details[i]['event_description'],
          event_start_timestamp: DateFormat("yyyy-MM-dd hh:mm:ss")
              .parse(details[i]['event_start_timestamp'].replaceAll('T', ' ')),
          event_end_timestamp: DateFormat("yyyy-MM-dd hh:mm:ss")
              .parse(details[i]['event_end_timestamp'].replaceAll('T', ' ')),
          event_registration_link: details[i]['event_registration_link'],
          event_organizer: details[i]['event_organizer'],
          event_poster_link: details[i]['event_poster_link'],
          event_venue: details[i]['event_venue'],
        ),
      );
    }
    return eventList;
  }

  static getPresentEventDetails() {
    List<Events> data = getEventdetails();
    
    List<Events> presentEvents = [];
    for (int i = 0; i < data.length; i++) {
      if ((DateTime.now().isAfter(data[i].event_start_timestamp) &&
          DateTime.now().isBefore(data[i].event_end_timestamp))) {
        presentEvents.add(data[i]);
      }
    }
    return presentEvents;
  }

  static getUpcomingEventDetails() {
    List<Events> data = getEventdetails();
    List<Events> x = [];
    for (int i = 0; i < data.length; i++) {
      if (DateTime.now().isBefore(data[i].event_start_timestamp)) {
        x.add(data[i]);
      }
    }
    return x;
  }

  static getPastEventDetails() {
    List<Events> data = getEventdetails();
    List<Events> x = [];
    for (int i = 0; i < data.length; i++) {
      if (DateTime.now().isAfter(data[i].event_end_timestamp)) {
        x.add(data[i]);
      }
    }
    return x;
  }

  static getPresentEventWidget() {
    List<Events> presentData = getPresentEventDetails();
    List<dynamic> presentEventWidget = [Container()];

    for (int i = 0; i < presentData.length; i++) {
      presentEventWidget.add(EventCard(presentData[i]));
    }

    return presentEventWidget;
  }

  static getPastEventWidget() {
    List<dynamic> pastData = getPastEventDetails();
    List<dynamic> pastEventWidget = [Container()];
    for (int i = 0; i < pastData.length; i++) {
      pastEventWidget.add(EventCard(pastData[i]));
    }
  
    return pastEventWidget;
  }

  static getFutureEventWidget() {
    List<dynamic> futureData = getUpcomingEventDetails();
    List<dynamic> futureEventWidget = [Container()];
    for (int i = 0; i < futureData.length; i++) {
      futureEventWidget.add(EventCard(futureData[i]));
    }
  
    return futureEventWidget;
  }
}
