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
  factory NcaafTeam.fromJson(String str) => NcaafTeam.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );

  factory NcaafTeam.fromMap(Map<String, dynamic> json) => NcaafTeam(
        teamId: json['TeamID'] as int,
        key: json['Key'] as String,
        active: json['Active'] as bool,
        school: json['School'] as String,
        name: json['Name'] as String,
        stadiumId: json['StadiumID'] as int,
        apRank: json['ApRank'] as int,
        wins: json['Wins'] as int,
        losses: json['Losses'] as int,
        conferenceWins: json['ConferenceWins'] as int,
        conferenceLosses: json['ConferenceLosses'] as int,
        globalTeamId: json['GlobalTeamID'] as int,
        coachesRank: json['CoachesRank'] as int,
        playoffRank: json['PlayoffRank'] as int,
        teamLogoUrl: json['TeamLogoUrl'] as String,
        conferenceId: json['ConferenceID'] as int,
        conference: json['Conference'] as String,
        shortDisplayName: json['ShortDisplayName'] as String,
        rankWeek: json['RankWeek'] as int,
        rankSeason: json['RankSeason'] as int,
        rankSeasonType: json['RankSeasonType'] as int,
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

  Map<String, Object> toMap() => {
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
