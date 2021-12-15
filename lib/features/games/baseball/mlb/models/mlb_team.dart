// ignore_for_file: constant_identifier_names
import 'dart:convert';

class MlbTeam {
  MlbTeam({
    this.teamId,
    this.key,
    this.active,
    this.city,
    this.name,
    this.stadiumId,
    this.league,
    this.division,
    this.primaryColor,
    this.secondaryColor,
    this.tertiaryColor,
    this.quaternaryColor,
    this.wikipediaLogoUrl,
    this.wikipediaWordMarkUrl,
    this.globalTeamId,
  });
  factory MlbTeam.fromJson(String str) =>
      MlbTeam.fromMap(json.decode(str) as Map<String, dynamic>);

  factory MlbTeam.fromMap(Map<String, dynamic> json) => MlbTeam(
        teamId: json['TeamID'] == null ? null : json['TeamID'] as int,
        key: json['Key'] == null ? null : json['Key'] as String,
        active: json['Active'] == null ? null : json['Active'] as bool,
        city: json['City'] == null ? null : json['City'] as String,
        name: json['Name'] == null ? null : json['Name'] as String,
        stadiumId: json['StadiumID'] == null ? null : json['StadiumID'] as int,
        league:
            json['League'] == null ? null : leagueValues.map[json['League']],
        division: json['Division'] == null ? null : json['Division'] as String,
        primaryColor: json['PrimaryColor'] == null
            ? null
            : json['PrimaryColor'] as String,
        secondaryColor: json['SecondaryColor'] == null
            ? null
            : json['SecondaryColor'] as String,
        tertiaryColor: json['TertiaryColor'] == null
            ? null
            : json['TertiaryColor'] as String,
        quaternaryColor: json['QuaternaryColor'] == null
            ? null
            : json['QuaternaryColor'] as String,
        wikipediaLogoUrl: json['WikipediaLogoUrl'] == null
            ? null
            : json['WikipediaLogoUrl'] as String,
        wikipediaWordMarkUrl: json['WikipediaWordMarkUrl'] == null
            ? null
            : json['WikipediaWordMarkUrl'] as String,
        globalTeamId:
            json['GlobalTeamID'] == null ? null : json['GlobalTeamID'] as int,
      );

  final int? teamId;
  final String? key;
  final bool? active;
  final String? city;
  final String? name;
  final int? stadiumId;
  final League? league;
  final String? division;
  final String? primaryColor;
  final String? secondaryColor;
  final String? tertiaryColor;
  final String? quaternaryColor;
  final String? wikipediaLogoUrl;
  final String? wikipediaWordMarkUrl;
  final int? globalTeamId;

  MlbTeam copyWith({
    int? teamId,
    String? key,
    bool? active,
    String? city,
    String? name,
    int? stadiumId,
    League? league,
    String? division,
    String? primaryColor,
    String? secondaryColor,
    String? tertiaryColor,
    String? quaternaryColor,
    String? wikipediaLogoUrl,
    String? wikipediaWordMarkUrl,
    int? globalTeamId,
  }) =>
      MlbTeam(
        teamId: teamId ?? this.teamId,
        key: key ?? this.key,
        active: active ?? this.active,
        city: city ?? this.city,
        name: name ?? this.name,
        stadiumId: stadiumId ?? this.stadiumId,
        league: league ?? this.league,
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

  Map<String, dynamic> toMap() => <String, dynamic>{
        'TeamID': teamId,
        'Key': key,
        'Active': active,
        'City': city,
        'Name': name,
        'StadiumID': stadiumId,
        'League': league == null ? null : leagueValues.reverse[league],
        'Division': division,
        'PrimaryColor': primaryColor,
        'SecondaryColor': secondaryColor,
        'TertiaryColor': tertiaryColor,
        'QuaternaryColor': quaternaryColor,
        'WikipediaLogoUrl': wikipediaLogoUrl,
        'WikipediaWordMarkUrl': wikipediaWordMarkUrl,
        'GlobalTeamID': globalTeamId,
      };
}

enum League { NL, AL, EMPTY }

final leagueValues =
    EnumValues({'AL': League.AL, '': League.EMPTY, 'NL': League.NL});

class EnumValues<T> {
  EnumValues(this.map);

  Map<String, T> map;
  Map<T, String>? reverseMap;

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));

    return reverseMap!;
  }
}
