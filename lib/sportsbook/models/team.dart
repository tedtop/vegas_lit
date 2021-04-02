import 'dart:convert';

class Team {
  Team({
    this.teamId,
    this.key,
    this.active,
    this.city,
    this.name,
    this.stadiumId,
    this.conference,
    this.division,
    this.primaryColor,
    this.secondaryColor,
    this.tertiaryColor,
    this.quaternaryColor,
    this.wikipediaLogoUrl,
    this.wikipediaWordMarkUrl,
    this.globalTeamId,
  });

  final int teamId;
  final String key;
  final bool active;
  final String city;
  final String name;
  final int stadiumId;
  final Conference conference;
  final Division division;
  final String primaryColor;
  final String secondaryColor;
  final String tertiaryColor;
  final String quaternaryColor;
  final String wikipediaLogoUrl;
  final String wikipediaWordMarkUrl;
  final int globalTeamId;

  Team copyWith({
    int teamId,
    String key,
    bool active,
    String city,
    String name,
    int stadiumId,
    Conference conference,
    Division division,
    String primaryColor,
    String secondaryColor,
    String tertiaryColor,
    String quaternaryColor,
    String wikipediaLogoUrl,
    String wikipediaWordMarkUrl,
    int globalTeamId,
  }) =>
      Team(
        teamId: teamId ?? this.teamId,
        key: key ?? this.key,
        active: active ?? this.active,
        city: city ?? this.city,
        name: name ?? this.name,
        stadiumId: stadiumId ?? this.stadiumId,
        conference: conference ?? this.conference,
        division: division ?? this.division,
        primaryColor: primaryColor ?? this.primaryColor,
        secondaryColor: secondaryColor ?? this.secondaryColor,
        tertiaryColor: tertiaryColor ?? this.tertiaryColor,
        quaternaryColor: quaternaryColor ?? this.quaternaryColor,
        wikipediaLogoUrl: wikipediaLogoUrl ?? this.wikipediaLogoUrl,
        wikipediaWordMarkUrl: wikipediaWordMarkUrl ?? this.wikipediaWordMarkUrl,
        globalTeamId: globalTeamId ?? this.globalTeamId,
      );

  factory Team.fromJson(String str) => Team.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Team.fromMap(Map<String, dynamic> json) => Team(
        teamId: json["TeamID"] == null ? null : json["TeamID"],
        key: json["Key"] == null ? null : json["Key"],
        active: json["Active"] == null ? null : json["Active"],
        city: json["City"] == null ? null : json["City"],
        name: json["Name"] == null ? null : json["Name"],
        stadiumId: json["StadiumID"] == null ? null : json["StadiumID"],
        conference: json["Conference"] == null
            ? null
            : conferenceValues.map[json["Conference"]],
        division: json["Division"] == null
            ? null
            : divisionValues.map[json["Division"]],
        primaryColor:
            json["PrimaryColor"] == null ? null : json["PrimaryColor"],
        secondaryColor:
            json["SecondaryColor"] == null ? null : json["SecondaryColor"],
        tertiaryColor:
            json["TertiaryColor"] == null ? null : json["TertiaryColor"],
        quaternaryColor:
            json["QuaternaryColor"] == null ? null : json["QuaternaryColor"],
        wikipediaLogoUrl:
            json["WikipediaLogoUrl"] == null ? null : json["WikipediaLogoUrl"],
        wikipediaWordMarkUrl: json["WikipediaWordMarkUrl"] == null
            ? null
            : json["WikipediaWordMarkUrl"],
        globalTeamId:
            json["GlobalTeamID"] == null ? null : json["GlobalTeamID"],
      );

  Map<String, dynamic> toMap() => {
        "TeamID": teamId == null ? null : teamId,
        "Key": key == null ? null : key,
        "Active": active == null ? null : active,
        "City": city == null ? null : city,
        "Name": name == null ? null : name,
        "StadiumID": stadiumId == null ? null : stadiumId,
        "Conference":
            conference == null ? null : conferenceValues.reverse[conference],
        "Division": division == null ? null : divisionValues.reverse[division],
        "PrimaryColor": primaryColor == null ? null : primaryColor,
        "SecondaryColor": secondaryColor == null ? null : secondaryColor,
        "TertiaryColor": tertiaryColor == null ? null : tertiaryColor,
        "QuaternaryColor": quaternaryColor == null ? null : quaternaryColor,
        "WikipediaLogoUrl": wikipediaLogoUrl == null ? null : wikipediaLogoUrl,
        "WikipediaWordMarkUrl":
            wikipediaWordMarkUrl == null ? null : wikipediaWordMarkUrl,
        "GlobalTeamID": globalTeamId == null ? null : globalTeamId,
      };
}

enum Conference { EASTERN, WESTERN }

final conferenceValues =
    EnumValues({"Eastern": Conference.EASTERN, "Western": Conference.WESTERN});

enum Division { EAST, CENTRAL, NORTH, WEST }

final divisionValues = EnumValues({
  "Central": Division.CENTRAL,
  "East": Division.EAST,
  "North": Division.NORTH,
  "West": Division.WEST
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
