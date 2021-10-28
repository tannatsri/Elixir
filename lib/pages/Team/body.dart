import 'dart:convert';

import 'package:elixir/common/app_bar.dart';
import 'package:elixir/common/initializer.dart';
import 'package:elixir/pages/Team/club_team.dart';
import 'package:flutter/material.dart';

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
      appBar: MyAppBar('Team'),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: Init.clubs.data.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      print(Init.clubs.data[index]);
                      return ClubTeam(Init.clubs.data[index]);
                    },
                  ),
                );
              },
              child: Card(
                elevation: 5,
                color: const Color.fromRGBO(8, 6, 41, 0.80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          Init.clubs.data[index]['club_logo'],
                          fit: BoxFit.contain,
                          // scale: 5,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        Init.clubs.data[index]['club_name'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
