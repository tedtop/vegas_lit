import 'dart:convert';

class NflTeam {
  NflTeam({
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

  factory NflTeam.fromJson(String str) => NflTeam.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );

  factory NflTeam.fromMap(Map<String, dynamic> json) => NflTeam(
        teamId: json['TeamID'] as int,
        key: json['Key'] as String,
        active: json['Active'] as bool,
        city: json['City'] as String,
        name: json['Name'] as String,
        stadiumId: json['StadiumID'] as int,
        conference: json['Conference'] == null
            ? null
            : conferenceValues.map[json['Conference']],
        division: json['Division'] == null
            ? null
            : divisionValues.map[json['Division']],
        primaryColor: json['PrimaryColor'] as String,
        secondaryColor: json['SecondaryColor'] as String,
        tertiaryColor: json['TertiaryColor'] as String,
        quaternaryColor: json['QuaternaryColor'] as String,
        wikipediaLogoUrl: json['WikipediaLogoUrl'] as String,
        wikipediaWordMarkUrl: json['WikipediaWordMarkUrl'] as String,
        globalTeamId: json['GlobalTeamID'] as int,
      );

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

  NflTeam copyWith({
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
      NflTeam(
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

  String toJson() => json.encode(toMap());

  Map<String, Object> toMap() => {
        'TeamID': teamId,
        'Key': key,
        'Active': active,
        'City': city,
        'Name': name,
        'StadiumID': stadiumId,
        'Conference':
            conference == null ? null : conferenceValues.reverse[conference],
        'Division': division == null ? null : divisionValues.reverse[division],
        'PrimaryColor': primaryColor,
        'SecondaryColor': secondaryColor,
        'TertiaryColor': tertiaryColor,
        'QuaternaryColor': quaternaryColor,
        'WikipediaLogoUrl': wikipediaLogoUrl,
        'WikipediaWordMarkUrl': wikipediaWordMarkUrl,
        'GlobalTeamID': globalTeamId,
      };
}

enum Conference { eastern, western }

final conferenceValues =
    EnumValues({'Eastern': Conference.eastern, 'Western': Conference.western});

enum Division { east, central, north, west }

final divisionValues = EnumValues({
  'Central': Division.central,
  'East': Division.east,
  'North': Division.north,
  'West': Division.west
});

class EnumValues<T> {
  EnumValues(this.map);

  Map<String, T> map;
  Map<T, String> reverseMap;

  Map<T, String> get reverse {
    // ignore: join_return_with_assignment
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
