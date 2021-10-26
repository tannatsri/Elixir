import 'package:elixir/Models/teams.dart';
import 'package:elixir/common/initializer.dart';
import 'package:flutter/material.dart';

class ClubTeam extends StatefulWidget {
  final Map data;
  ClubTeam(this.data);

  @override
  _ClubTeamState createState() => _ClubTeamState();
}

Teams presidentDetail = Teams.getPresident();

class _ClubTeamState extends State<ClubTeam> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          child: ListView(
            shrinkWrap: true,
            children: [
              Image.network(widget.data['club_logo']),
              const SizedBox(height: 10),
              ListTile(
                title: Text(
                  widget.data['club_name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 19),
                ),
                subtitle: Text(widget.data['club_description']),
              ),
              const Divider(height: 2),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "President",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              imageView(
                image: presidentDetail.image,
                name: presidentDetail.team_member_name,
              ),
              const SizedBox(height: 10),
              const Divider(height: 2),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Core Team",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              builder(details: Teams.getCoreTeamDetails()),
              const SizedBox(height: 10),
              const Divider(height: 2),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Executive Team",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              builder(details: Teams.getExecutiveTeamDetails())
            ],
          ),
        ),
      ),
    );
  }
}

Widget imageView({String name, String image}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        margin: const EdgeInsets.only(top: 10),
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage(image),
          ),
        ),
      ),
      Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget builder({List<Teams> details}) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
    ),
    itemCount: details.length,
    itemBuilder: (BuildContext context, int index) {
      List<Teams> data = details;
      return imageView(
        image: data[index].image,
        name: data[index].team_member_name,
      );
    },
  );
}
