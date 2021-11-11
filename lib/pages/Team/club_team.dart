import 'package:cached_network_image/cached_network_image.dart';
import 'package:elixir/Models/teams.dart';
import 'package:elixir/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ClubTeam extends StatefulWidget {
  final Map data;
  const ClubTeam(this.data);

  @override
  _ClubTeamState createState() => _ClubTeamState();
}

class _ClubTeamState extends State<ClubTeam> {

  List<Widget> clubDetailsWidgetList() {
    Teams presidentDetail = Teams.getPresident(widget.data['id']);
    List<Widget> clubDetails = [];
    clubDetails.add(Container(
      alignment: Alignment.center,
      child: const Text(
        "President",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ));
    clubDetails.add(ImageCard(
        presidentDetail.image, presidentDetail.team_member_name, context));
    clubDetails.add(const SizedBox(height: 10));
    clubDetails.add(const Divider(height: 2));
    clubDetails.add(const SizedBox(height: 10));
    clubDetails.add(Container(
      alignment: Alignment.center,
      child: const Text(
        "Core Team",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ));
    clubDetails.add(builder(
      context,
      Teams.getCoreTeamDetails(
        widget.data['id'],
      ),
    ));
    clubDetails.add(const SizedBox(height: 14));
    clubDetails.add(const Divider(height: 2));
    clubDetails.add(const SizedBox(height: 14));
    clubDetails.add(Container(
      alignment: Alignment.center,
      child: const Text(
        "Executive Team",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
    clubDetails.add(const SizedBox(height: 10));
    clubDetails.add(builder(
      context,
      Teams.getExecutiveTeamDetails(
        widget.data['id'],
      ),
    ));

    return clubDetails;
  }

  List<Widget> advisoryBoardWidgetList() {
    List<Widget> advisoryBoard = [];

    advisoryBoard.add(const SizedBox(height: 10));

    advisoryBoard.add(builder(
      context,
      Teams.getAdviosryBoardDetails(),
    ));
    return advisoryBoard;
  }

  bool isAdvisory() {
    if (widget.data['club_name'] == "Advisory Board") return true;
    return false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(widget.data['club_name']),
      body: ListView(
        addAutomaticKeepAlives: true,
        shrinkWrap: true,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Center(
                    child: Text(
                      widget.data['club_name'] + '\n',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  subtitle: Container(
                    child: Text(
                      widget.data['club_description'],
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 2),
          const SizedBox(height: 10),
          if (isAdvisory())
            ...advisoryBoardWidgetList()
          else
            ...clubDetailsWidgetList(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ImageCard extends StatefulWidget {
  final String image, name;
  final BuildContext context;
  // @immutable
  const ImageCard(this.image, this.name, this.context);
  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    return imageView(widget.image, widget.name, context);
  }
}

Widget imageView(String image, String name, context) {
  return GestureDetector(
    onTap: () {},
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          height: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(8, 6, 41, 1),
              width: 2,
            ),
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: image,
                progressIndicatorBuilder: (
                  context,
                  url,
                  downloadProgress,
                ) =>
                    JumpingDotsProgressIndicator(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget builder(context, List<Teams> data) {
  return GridView.builder(
    // cacheExtent: double.infinity,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 0.6,
    ),
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return ImageCard(
        data[index].image,
        data[index].team_member_name,
        context,
      );
    },
  );
}
