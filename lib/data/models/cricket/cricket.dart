// To parse this JSON data, do
//
//     final newModel = newModelFromMap(jsonString);

import 'dart:convert';

class CricketModel {
  CricketModel({
    this.success,
    this.data,
  });

  factory CricketModel.fromJson(String str) =>
      CricketModel.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CricketModel.fromMap(Map<String, dynamic> json) => CricketModel(
        success: json['success'] as bool,
        data: List<CricketDatum>.from(
          json['data'].map((Map<String, dynamic> x) => CricketDatum.fromMap(x))
              as List,
        ),
      );

  String toJson() => json.encode(toMap());

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

  Map<String, Object> toMap() => {
        'success': success,
        'data':
            List<dynamic>.from(data.map<Map<String, Object>>((x) => x.toMap())),
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

  factory CricketDatum.fromJson(String str) =>
      CricketDatum.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CricketDatum.fromMap(Map<String, dynamic> json) => CricketDatum(
        id: json['id'] as String,
        sportKey: json['sport_key'] as String,
        sportNice: json['sport_nice'] as String,
        teams: List<String>.from(json['teams'].map((String x) => x) as List),
        homeTeam: json['home_team'] as String,
        commenceTime: DateTime.parse(json['commence_time'] as String),
        sites: List<Site>.from(
          json['sites'].map((Map<String, dynamic> x) => Site.fromMap(x))
              as List,
        ),
        sitesCount: json['sites_count'] as int,
      );

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

  String toJson() => json.encode(toMap());

  Map<String, Object> toMap() => {
        'id': id,
        'sport_key': sportKey,
        'sport_nice': sportNice,
        'teams': List<dynamic>.from(teams.map<dynamic>((x) => x)),
        'home_team': homeTeam,
        'commence_time': commenceTime.toIso8601String(),
        'sites': List<dynamic>.from(sites.map<dynamic>((x) => x.toMap())),
        'sites_count': sitesCount,
      };
}

class Site {
  Site({
    this.siteKey,
    this.siteNice,
    this.lastUpdate,
    this.odds,
  });

  factory Site.fromJson(String str) =>
      Site.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Site.fromMap(Map<String, dynamic> json) => Site(
        siteKey: json['site_key'] as String,
        siteNice: json['site_nice'] as String,
        lastUpdate: DateTime.parse(json['last_update'] as String),
        odds: Map<String, List<double>>.from(json['odds'] as Map).map(
          (dynamic k, dynamic v) => MapEntry<String, List<double>>(
            k as String,
            List<double>.from(v.map((dynamic x) => x.toDouble()) as List),
          ),
        ),
      );

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

  String toJson() => json.encode(toMap());

  Map<String, Object> toMap() => {
        'site_key': siteKey,
        'site_nice': siteNice,
        'last_update': lastUpdate.toIso8601String(),
        'odds': Map<String, List<double>>.from(odds).map<String, dynamic>(
          (dynamic k, dynamic v) => MapEntry<String, dynamic>(
            k as String,
            List<dynamic>.from(v.map((dynamic x) => x) as List),
          ),
        ),
      };
}

class Odds {
  Odds({
    this.odds,
  });

  factory Odds.fromJson(Map<String, dynamic> json) => Odds(
        odds: Map<String, List<double>>.from(json['odds'] as Map).map(
          (k, v) => MapEntry<String, List<double>>(
            k,
            List<double>.from(v.map<double>((x) => x) as List),
          ),
        ),
      );

  Map<String, List<double>> odds;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'odds': Map<String, List<double>>.from(odds).map<String, dynamic>(
          (dynamic k, dynamic v) => MapEntry<String, dynamic>(
            k as String,
            List<dynamic>.from(v.map<dynamic>((dynamic x) => x) as List),
          ),
        ),
      };
}
