// To parse this JSON data, do
//
//     final ncaabTeam = ncaabTeamFromMap(jsonString);

import 'dart:convert';

class NcaabTeam {
  NcaabTeam({
    this.teamId,
    this.key,
    this.active,
    this.school,
    this.name,
    this.apRank,
    this.wins,
    this.losses,
    this.conferenceWins,
    this.conferenceLosses,
    this.globalTeamId,
    this.conferenceId,
    this.conference,
    this.teamLogoUrl,
    this.shortDisplayName,
    this.stadium,
  });

  final int? teamId;
  final String? key;
  final bool? active;
  final String? school;
  final String? name;
  final int? apRank;
  final int? wins;
  final int? losses;
  final int? conferenceWins;
  final int? conferenceLosses;
  final int? globalTeamId;
  final int? conferenceId;
  final String? conference;
  final String? teamLogoUrl;
  final String? shortDisplayName;
  final Stadium? stadium;

  NcaabTeam copyWith({
    int? teamId,
    String? key,
    bool? active,
    String? school,
    String? name,
    int? apRank,
    int? wins,
    int? losses,
    int? conferenceWins,
    int? conferenceLosses,
    int? globalTeamId,
    int? conferenceId,
    String? conference,
    String? teamLogoUrl,
    String? shortDisplayName,
    Stadium? stadium,
  }) =>
      NcaabTeam(
        teamId: teamId ?? this.teamId,
        key: key ?? this.key,
        active: active ?? this.active,
        school: school ?? this.school,
        name: name ?? this.name,
        apRank: apRank ?? this.apRank,
        wins: wins ?? this.wins,
        losses: losses ?? this.losses,
        conferenceWins: conferenceWins ?? this.conferenceWins,
        conferenceLosses: conferenceLosses ?? this.conferenceLosses,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        conferenceId: conferenceId ?? this.conferenceId,
        conference: conference ?? this.conference,
        teamLogoUrl: teamLogoUrl ?? this.teamLogoUrl,
        shortDisplayName: shortDisplayName ?? this.shortDisplayName,
        stadium: stadium ?? this.stadium,
      );

  factory NcaabTeam.fromJson(String str) =>
      NcaabTeam.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory NcaabTeam.fromMap(Map<String, dynamic> json) => NcaabTeam(
        teamId: json['TeamID'] as int?,
        key: json['Key'] as String?,
        active: json['Active'] as bool?,
        school: json['School'] as String?,
        name: json['Name'] as String?,
        apRank: json['ApRank'] as int?,
        wins: json['Wins'] as int?,
        losses: json['Losses'] as int?,
        conferenceWins: json['ConferenceWins'] as int?,
        conferenceLosses: json['ConferenceLosses'] as int?,
        globalTeamId: json['GlobalTeamID'] as int?,
        conferenceId: json['ConferenceID'] as int?,
        conference: json['Conference'] as String?,
        teamLogoUrl: json['TeamLogoUrl'] as String?,
        shortDisplayName: json['ShortDisplayName'] as String?,
        stadium: json['Stadium'] == null
            ? null
            : Stadium.fromMap(json['Stadium'] as Map<String, dynamic>),
      );

  Map<String, Object?> toMap() => {
        'TeamID': teamId,
        'Key': key,
        'Active': active,
        'School': school,
        'Name': name,
        'ApRank': apRank,
        'Wins': wins,
        'Losses': losses,
        'ConferenceWins': conferenceWins,
        'ConferenceLosses': conferenceLosses,
        'GlobalTeamID': globalTeamId,
        'ConferenceID': conferenceId,
        'Conference': conference,
        'TeamLogoUrl': teamLogoUrl,
        'ShortDisplayName': shortDisplayName,
        'Stadium': stadium == null ? null : stadium!.toMap(),
      };
}

class Stadium {
  Stadium({
    this.stadiumId,
    this.active,
    this.name,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.country,
    this.capacity,
    this.geoLat,
    this.geoLong,
  });

  final int? stadiumId;
  final bool? active;
  final String? name;
  final String? address;
  final String? city;
  final String? state;
  final String? zip;
  final String? country;
  final int? capacity;
  final double? geoLat;
  final double? geoLong;

  Stadium copyWith({
    int? stadiumId,
    bool? active,
    String? name,
    String? address,
    String? city,
    String? state,
    String? zip,
    String? country,
    int? capacity,
    double? geoLat,
    double? geoLong,
  }) =>
      Stadium(
        stadiumId: stadiumId ?? this.stadiumId,
        active: active ?? this.active,
        name: name ?? this.name,
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        zip: zip ?? this.zip,
        country: country ?? this.country,
        capacity: capacity ?? this.capacity,
        geoLat: geoLat ?? this.geoLat,
        geoLong: geoLong ?? this.geoLong,
      );

  factory Stadium.fromJson(String str) =>
      Stadium.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory Stadium.fromMap(Map<String, dynamic> json) => Stadium(
        stadiumId: json['StadiumID'] as int?,
        active: json['Active'] as bool?,
        name: json['Name'] as String?,
        address: json['Address'] as String?,
        city: json['City'] as String?,
        state: json['State'] as String?,
        zip: json['Zip'] as String?,
        country: json['Country'] as String?,
        capacity: json['Capacity'] as int?,
        geoLat:
            json['GeoLat'] == null ? null : json['GeoLat'].toDouble() as double,
        geoLong: json['GeoLong'] == null
            ? null
            : json['GeoLong'].toDouble() as double,
      );

  Map<String, Object?> toMap() => {
        'StadiumID': stadiumId,
        'Active': active,
        'Name': name,
        'Address': address,
        'City': city,
        'State': state,
        'Zip': zip,
        'Country': country,
        'Capacity': capacity,
        'GeoLat': geoLat,
        'GeoLong': geoLong,
      };
}
