import 'package:elixir/Models/teams.dart';
import 'package:flutter/material.dart';

class ClubTeam extends StatefulWidget {
  final Map data;
  ClubTeam(this.data);

  @override
  _ClubTeamState createState() => _ClubTeamState();
}

class _ClubTeamState extends State<ClubTeam> {
  @override
  Widget build(BuildContext context) {
    bool isAdvisory = false;
    if (widget.data['id'] == 5) {
      isAdvisory = true;
    }
    Teams presidentDetail = Teams.getPresident(widget.data['id']);
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Stack(
              fit: StackFit.expand,
              children: [
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
                          Colors.deepOrange,
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
                  top: MediaQuery.of(context).size.height * 0.266,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Center(
                            child: Text(
                              widget.data['club_name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                          ),
                          subtitle: Center(
                            child: Text(
                              widget.data['club_description'],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.width * 0.3,
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.data['club_logo'],
                          scale: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 2),
          const SizedBox(height: 10),
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
          Expanded(
            flex: 4,
            child: builder(
              details: Teams.getCoreTeamDetails(widget.data['id']),
            ),
          ),
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
          const SizedBox(height: 10),
          builder(
            details: Teams.getExecutiveTeamDetails(widget.data['id']),
          ),
        ],
      ),
    );
  }
}

Widget imageView({String name, String image}) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(
        margin: const EdgeInsets.only(top: 10),
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(8, 6, 41, 1),
            width: 2,
          ),
          color: Colors.black,
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage(image),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
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
