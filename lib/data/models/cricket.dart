// To parse this JSON data, do
//
//     final newModel = newModelFromMap(jsonString);

import 'dart:convert';

class CricketModel {
  CricketModel({
    this.success,
    this.data,
  });

  final bool success;
  final List<CricketDatum> data;

  CricketModel copyWith({
    bool success,
    List<CricketDatum> data,
  }) =>
      CricketModel(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory CricketModel.fromJson(String str) =>
      CricketModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CricketModel.fromMap(Map<String, dynamic> json) => CricketModel(
        success: json["success"],
        data: List<CricketDatum>.from(
            json["data"].map((x) => CricketDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class CricketDatum {
  CricketDatum({
    this.id,
    this.sportKey,
    this.sportNice,
    this.teams,
    this.homeTeam,
    this.commenceTime,
    this.sites,
    this.sitesCount,
  });

  final String id;
  final String sportKey;
  final String sportNice;
  final List<String> teams;
  final String homeTeam;
  final DateTime commenceTime;
  final List<Site> sites;
  final int sitesCount;

  CricketDatum copyWith({
    String id,
    String sportKey,
    String sportNice,
    List<String> teams,
    String homeTeam,
    DateTime commenceTime,
    List<Site> sites,
    int sitesCount,
  }) =>
      CricketDatum(
        id: id ?? this.id,
        sportKey: sportKey ?? this.sportKey,
        sportNice: sportNice ?? this.sportNice,
        teams: teams ?? this.teams,
        homeTeam: homeTeam ?? this.homeTeam,
        commenceTime: commenceTime ?? this.commenceTime,
        sites: sites ?? this.sites,
        sitesCount: sitesCount ?? this.sitesCount,
      );

  factory CricketDatum.fromJson(String str) =>
      CricketDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CricketDatum.fromMap(Map<String, dynamic> json) => CricketDatum(
        id: json["id"],
        sportKey: json["sport_key"],
        sportNice: json["sport_nice"],
        teams: List<String>.from(json["teams"].map((x) => x)),
        homeTeam: json["home_team"],
        commenceTime: DateTime.parse(json["commence_time"]),
        sites: List<Site>.from(json["sites"].map((x) => Site.fromMap(x))),
        sitesCount: json["sites_count"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "sport_key": sportKey,
        "sport_nice": sportNice,
        "teams": List<dynamic>.from(teams.map((x) => x)),
        "home_team": homeTeam,
        "commence_time": commenceTime.toIso8601String(),
        "sites": List<dynamic>.from(sites.map((x) => x.toMap())),
        "sites_count": sitesCount,
      };
}

class Site {
  Site({
    this.siteKey,
    this.siteNice,
    this.lastUpdate,
    this.odds,
  });

  final String siteKey;
  final String siteNice;
  final DateTime lastUpdate;
  final Map<String, List<double>> odds;

  Site copyWith({
    String siteKey,
    String siteNice,
    DateTime lastUpdate,
    Map<String, List<double>> odds,
  }) =>
      Site(
        siteKey: siteKey ?? this.siteKey,
        siteNice: siteNice ?? this.siteNice,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        odds: odds ?? this.odds,
      );

  factory Site.fromJson(String str) => Site.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Site.fromMap(Map<String, dynamic> json) => Site(
        siteKey: json["site_key"],
        siteNice: json["site_nice"],
        lastUpdate: DateTime.parse(json["last_update"]),
        odds: Map.from(json["odds"]).map((k, v) =>
            MapEntry<String, List<double>>(
                k, List<double>.from(v.map((x) => x.toDouble())))),
      );

  Map<String, dynamic> toMap() => {
        "site_key": siteKey,
        "site_nice": siteNice,
        "last_update": lastUpdate.toIso8601String(),
        "odds": Map.from(odds).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
      };
}

class Odds {
  Odds({
    this.odds,
  });

  Map<String, List<double>> odds;

  factory Odds.fromJson(Map<String, dynamic> json) => Odds(
        odds: Map.from(json["odds"]).map((k, v) =>
            MapEntry<String, List<double>>(
                k, List<double>.from(v.map((x) => x.toDouble())))),
      );

  Map<String, dynamic> toJson() => {
        "odds": Map.from(odds).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
      };
}
