import 'dart:convert';

class NcaafTeam {
  NcaafTeam({
    this.teamId,
    this.key,
    this.active,
    this.school,
    this.name,
    this.stadiumId,
    this.apRank,
    this.wins,
    this.losses,
    this.conferenceWins,
    this.conferenceLosses,
    this.globalTeamId,
    this.coachesRank,
    this.playoffRank,
    this.teamLogoUrl,
    this.conferenceId,
    this.conference,
    this.shortDisplayName,
    this.rankWeek,
    this.rankSeason,
    this.rankSeasonType,
  });
  factory NcaafTeam.fromJson(String str) => NcaafTeam.fromMap(json.decode(str));

  factory NcaafTeam.fromMap(Map<String, dynamic> json) => NcaafTeam(
        teamId: json['TeamID'],
        key: json['Key'],
        active: json['Active'],
        school: json['School'],
        name: json['Name'],
        stadiumId: json['StadiumID'],
        apRank: json['ApRank'],
        wins: json['Wins'],
        losses: json['Losses'],
        conferenceWins: json['ConferenceWins'],
        conferenceLosses: json['ConferenceLosses'],
        globalTeamId: json['GlobalTeamID'],
        coachesRank: json['CoachesRank'],
        playoffRank: json['PlayoffRank'],
        teamLogoUrl: json['TeamLogoUrl'],
        conferenceId: json['ConferenceID'],
        conference: json['Conference'],
        shortDisplayName: json['ShortDisplayName'],
        rankWeek: json['RankWeek'],
        rankSeason: json['RankSeason'],
        rankSeasonType: json['RankSeasonType'],
      );

  final int teamId;
  final String key;
  final bool active;
  final String school;
  final String name;
  final int stadiumId;
  final int apRank;
  final int wins;
  final int losses;
  final int conferenceWins;
  final int conferenceLosses;
  final int globalTeamId;
  final int coachesRank;
  final int playoffRank;
  final String teamLogoUrl;
  final int conferenceId;
  final String conference;
  final String shortDisplayName;
  final int rankWeek;
  final int rankSeason;
  final int rankSeasonType;

  NcaafTeam copyWith({
    int teamId,
    String key,
    bool active,
    String school,
    String name,
    int stadiumId,
    int apRank,
    int wins,
    int losses,
    int conferenceWins,
    int conferenceLosses,
    int globalTeamId,
    int coachesRank,
    int playoffRank,
    String teamLogoUrl,
    int conferenceId,
    String conference,
    String shortDisplayName,
    int rankWeek,
    int rankSeason,
    int rankSeasonType,
  }) =>
      NcaafTeam(
        teamId: teamId ?? this.teamId,
        key: key ?? this.key,
        active: active ?? this.active,
        school: school ?? this.school,
        name: name ?? this.name,
        stadiumId: stadiumId ?? this.stadiumId,
        apRank: apRank ?? this.apRank,
        wins: wins ?? this.wins,
        losses: losses ?? this.losses,
        conferenceWins: conferenceWins ?? this.conferenceWins,
        conferenceLosses: conferenceLosses ?? this.conferenceLosses,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        coachesRank: coachesRank ?? this.coachesRank,
        playoffRank: playoffRank ?? this.playoffRank,
        teamLogoUrl: teamLogoUrl ?? this.teamLogoUrl,
        conferenceId: conferenceId ?? this.conferenceId,
        conference: conference ?? this.conference,
        shortDisplayName: shortDisplayName ?? this.shortDisplayName,
        rankWeek: rankWeek ?? this.rankWeek,
        rankSeason: rankSeason ?? this.rankSeason,
        rankSeasonType: rankSeasonType ?? this.rankSeasonType,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'TeamID': teamId,
        'Key': key,
        'Active': active,
        'School': school,
        'Name': name,
        'StadiumID': stadiumId,
        'ApRank': apRank,
        'Wins': wins,
        'Losses': losses,
        'ConferenceWins': conferenceWins,
        'ConferenceLosses': conferenceLosses,
        'GlobalTeamID': globalTeamId,
        'CoachesRank': coachesRank,
        'PlayoffRank': playoffRank,
        'TeamLogoUrl': teamLogoUrl,
        'ConferenceID': conferenceId,
        'Conference': conference,
        'ShortDisplayName': shortDisplayName,
        'RankWeek': rankWeek,
        'RankSeason': rankSeason,
        'RankSeasonType': rankSeasonType,
      };
}
