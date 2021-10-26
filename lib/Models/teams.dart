import 'package:elixir/common/initializer.dart';

class Teams {
  int id;
  String team_member_name;
  String image;
  int designation;
  int team_belongs_to;
  Teams(
      {this.id,
      this.team_belongs_to,
      this.designation,
      this.image,
      this.team_member_name});

  static getTeamdetails() {
    List details = Init.teams.data;
    List<Teams> teamList = [];
    for (int i = 0; i < details.length; i++) {
      teamList.add(
        Teams(
          id: details[i]['id'],
          team_member_name: details[i]['team_member_name'],
          image: details[i]['team_member_image_link'],
          designation: details[i]['team_member_designation'],
          team_belongs_to: details[i]['team_belongs_to'],
        ),
      );
    }
    return teamList;
  }

  static getPresident() {
    List<Teams> data = getTeamdetails();
    Teams x;
    for (int i = 0; i < data.length; i++) {
      if (data[i].designation == 1) {
        x = data[i];
      }
    }
    return x;
  }

  static getCoreTeamDetails(){
    List<Teams> data = getTeamdetails();
    List<Teams> x = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].designation == 2) {
        x.add(data[i]);
      }
    }
    return x;
  }
  static getExecutiveTeamDetails(){
    List<Teams> data = getTeamdetails();
    List<Teams> x = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].designation == 3) {
        x.add(data[i]);
      }
    }
    return x;
  }
}
