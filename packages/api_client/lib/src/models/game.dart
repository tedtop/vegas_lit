import 'dart:convert';

import 'package:equatable/equatable.dart';

class Game extends Equatable {
  Game({
    this.schedule,
    this.summary,
    this.details,
    this.status,
    this.teams,
    this.lastUpdated,
    this.gameId,
    this.venue,
    this.scoreboard,
    this.odds,
  });

  final Schedule schedule;
  final String summary;
  final Details details;
  final Status status;
  final Teams teams;
  final DateTime lastUpdated;
  final int gameId;
  final Venue venue;
  final Scoreboard scoreboard;
  final List<Odd> odds;

  Game copyWith({
    Schedule schedule,
    String summary,
    Details details,
    Status status,
    Teams teams,
    DateTime lastUpdated,
    int gameId,
    Venue venue,
    Scoreboard scoreboard,
    List<Odd> odds,
  }) =>
      Game(
        schedule: schedule ?? this.schedule,
        summary: summary ?? this.summary,
        details: details ?? this.details,
        status: status ?? this.status,
        teams: teams ?? this.teams,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        gameId: gameId ?? this.gameId,
        venue: venue ?? this.venue,
        scoreboard: scoreboard ?? this.scoreboard,
        odds: odds ?? this.odds,
      );

  factory Game.fromRawJson(String str) => Game.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        schedule: json["schedule"] == null
            ? null
            : Schedule.fromJson(json["schedule"]),
        summary: json["summary"],
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        status:
            json["status"] == null ? null : statusValues.map[json["status"]],
        teams: json["teams"] == null ? null : Teams.fromJson(json["teams"]),
        lastUpdated: json["lastUpdated"] == null
            ? null
            : DateTime.parse(json["lastUpdated"]),
        gameId: json["gameId"],
        venue: json["venue"] == null ? null : Venue.fromJson(json["venue"]),
        scoreboard: json["scoreboard"] == null
            ? null
            : Scoreboard.fromJson(json["scoreboard"]),
        odds: json["odds"] == null
            ? null
            : List<Odd>.from(json["odds"].map((x) => Odd.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "schedule": schedule == null ? null : schedule.toJson(),
        "summary": summary,
        "details": details == null ? null : details.toJson(),
        "status": status == null ? null : statusValues.reverse[status],
        "teams": teams == null ? null : teams.toJson(),
        "lastUpdated":
            lastUpdated == null ? null : lastUpdated.toIso8601String(),
        "gameId": gameId,
        "venue": venue == null ? null : venue.toJson(),
        "scoreboard": scoreboard == null ? null : scoreboard.toJson(),
        "odds": odds == null
            ? null
            : List<dynamic>.from(odds.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [
        schedule,
        summary,
        details,
        status,
        teams,
        lastUpdated,
        gameId,
        venue,
        scoreboard,
        odds
      ];
}

class Details extends Equatable {
  Details({
    this.league,
    this.seasonType,
    this.season,
    this.conferenceGame,
    this.divisionGame,
  });

  final League league;
  final SeasonType seasonType;
  final int season;
  final bool conferenceGame;
  final bool divisionGame;

  Details copyWith({
    League league,
    SeasonType seasonType,
    int season,
    bool conferenceGame,
    bool divisionGame,
  }) =>
      Details(
        league: league ?? this.league,
        seasonType: seasonType ?? this.seasonType,
        season: season ?? this.season,
        conferenceGame: conferenceGame ?? this.conferenceGame,
        divisionGame: divisionGame ?? this.divisionGame,
      );

  factory Details.fromRawJson(String str) => Details.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        league:
            json["league"] == null ? null : leagueValues.map[json["league"]],
        seasonType: json["seasonType"] == null
            ? null
            : seasonTypeValues.map[json["seasonType"]],
        season: json["season"],
        conferenceGame: json["conferenceGame"],
        divisionGame: json["divisionGame"],
      );

  Map<String, dynamic> toJson() => {
        "league": league == null ? null : leagueValues.reverse[league],
        "seasonType":
            seasonType == null ? null : seasonTypeValues.reverse[seasonType],
        "season": season,
        "conferenceGame": conferenceGame,
        "divisionGame": divisionGame,
      };

  @override
  List<Object> get props => [
        league,
        seasonType,
        season,
        conferenceGame,
        divisionGame,
      ];
}

enum League { mlb, ncaab, nhl }

final leagueValues =
    EnumValues({"MLB": League.mlb, "NCAAB": League.ncaab, "NHL": League.nhl});

enum SeasonType { preseason, regular }

final seasonTypeValues = EnumValues(
    {"preseason": SeasonType.preseason, "regular": SeasonType.regular});

class Odd extends Equatable {
  Odd({
    this.spread,
    this.moneyline,
    this.total,
    this.openDate,
    this.lastUpdated,
  });

  final Spread spread;
  final Moneyline moneyline;
  final Total total;
  final DateTime openDate;
  final DateTime lastUpdated;

  Odd copyWith({
    Spread spread,
    Moneyline moneyline,
    Total total,
    DateTime openDate,
    DateTime lastUpdated,
  }) =>
      Odd(
        spread: spread ?? this.spread,
        moneyline: moneyline ?? this.moneyline,
        total: total ?? this.total,
        openDate: openDate ?? this.openDate,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );

  factory Odd.fromRawJson(String str) => Odd.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Odd.fromJson(Map<String, dynamic> json) => Odd(
        spread: json["spread"] == null ? null : Spread.fromJson(json["spread"]),
        moneyline: json["moneyline"] == null
            ? null
            : Moneyline.fromJson(json["moneyline"]),
        total: json["total"] == null ? null : Total.fromJson(json["total"]),
        openDate:
            json["openDate"] == null ? null : DateTime.parse(json["openDate"]),
        lastUpdated: json["lastUpdated"] == null
            ? null
            : DateTime.parse(json["lastUpdated"]),
      );

  Map<String, dynamic> toJson() => {
        "spread": spread == null ? null : spread.toJson(),
        "moneyline": moneyline == null ? null : moneyline.toJson(),
        "total": total == null ? null : total.toJson(),
        "openDate": openDate == null ? null : openDate.toIso8601String(),
        "lastUpdated":
            lastUpdated == null ? null : lastUpdated.toIso8601String(),
      };

  @override
  List<Object> get props => [
        spread,
        moneyline,
        total,
        openDate,
        lastUpdated,
      ];
}

class Moneyline extends Equatable {
  Moneyline({
    this.open,
    this.current,
  });

  final MoneylineCurrent open;
  final MoneylineCurrent current;

  Moneyline copyWith({
    MoneylineCurrent open,
    MoneylineCurrent current,
  }) =>
      Moneyline(
        open: open ?? this.open,
        current: current ?? this.current,
      );

  factory Moneyline.fromRawJson(String str) =>
      Moneyline.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Moneyline.fromJson(Map<String, dynamic> json) => Moneyline(
        open: json["open"] == null
            ? null
            : MoneylineCurrent.fromJson(json["open"]),
        current: json["current"] == null
            ? null
            : MoneylineCurrent.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "open": open == null ? null : open.toJson(),
        "current": current == null ? null : current.toJson(),
      };

  @override
  List<Object> get props => [open, current];
}

class MoneylineCurrent extends Equatable {
  MoneylineCurrent({
    this.awayOdds,
    this.homeOdds,
  });

  final int awayOdds;
  final int homeOdds;

  MoneylineCurrent copyWith({
    int awayOdds,
    int homeOdds,
  }) =>
      MoneylineCurrent(
        awayOdds: awayOdds ?? this.awayOdds,
        homeOdds: homeOdds ?? this.homeOdds,
      );

  factory MoneylineCurrent.fromRawJson(String str) =>
      MoneylineCurrent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MoneylineCurrent.fromJson(Map<String, dynamic> json) =>
      MoneylineCurrent(
        awayOdds: json["awayOdds"],
        homeOdds: json["homeOdds"],
      );

  Map<String, dynamic> toJson() => {
        "awayOdds": awayOdds,
        "homeOdds": homeOdds,
      };

  @override
  List<Object> get props => [awayOdds, homeOdds];
}

class Spread extends Equatable {
  Spread({
    this.open,
    this.current,
  });

  final SpreadCurrent open;
  final SpreadCurrent current;

  Spread copyWith({
    SpreadCurrent open,
    SpreadCurrent current,
  }) =>
      Spread(
        open: open ?? this.open,
        current: current ?? this.current,
      );

  factory Spread.fromRawJson(String str) => Spread.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Spread.fromJson(Map<String, dynamic> json) => Spread(
        open:
            json["open"] == null ? null : SpreadCurrent.fromJson(json["open"]),
        current: json["current"] == null
            ? null
            : SpreadCurrent.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "open": open == null ? null : open.toJson(),
        "current": current == null ? null : current.toJson(),
      };

  @override
  List<Object> get props => [open, current];
}

class SpreadCurrent extends Equatable {
  SpreadCurrent({
    this.away,
    this.home,
    this.awayOdds,
    this.homeOdds,
  });

  final double away;
  final double home;
  final int awayOdds;
  final int homeOdds;

  SpreadCurrent copyWith({
    double away,
    double home,
    int awayOdds,
    int homeOdds,
  }) =>
      SpreadCurrent(
        away: away ?? this.away,
        home: home ?? this.home,
        awayOdds: awayOdds ?? this.awayOdds,
        homeOdds: homeOdds ?? this.homeOdds,
      );

  factory SpreadCurrent.fromRawJson(String str) =>
      SpreadCurrent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SpreadCurrent.fromJson(Map<String, dynamic> json) => SpreadCurrent(
        away: json["away"] == null ? null : json["away"].toDouble(),
        home: json["home"] == null ? null : json["home"].toDouble(),
        awayOdds: json["awayOdds"],
        homeOdds: json["homeOdds"],
      );

  Map<String, dynamic> toJson() => {
        "away": away,
        "home": home,
        "awayOdds": awayOdds,
        "homeOdds": homeOdds,
      };

  @override
  List<Object> get props => [away, home, awayOdds, homeOdds];
}

class Total extends Equatable {
  Total({
    this.open,
    this.current,
  });

  final TotalCurrent open;
  final TotalCurrent current;

  Total copyWith({
    TotalCurrent open,
    TotalCurrent current,
  }) =>
      Total(
        open: open ?? this.open,
        current: current ?? this.current,
      );

  factory Total.fromRawJson(String str) => Total.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        open: json["open"] == null ? null : TotalCurrent.fromJson(json["open"]),
        current: json["current"] == null
            ? null
            : TotalCurrent.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "open": open == null ? null : open.toJson(),
        "current": current == null ? null : current.toJson(),
      };

  @override
  List<Object> get props => [open, current];
}

class TotalCurrent extends Equatable {
  TotalCurrent({
    this.total,
    this.overOdds,
    this.underOdds,
  });

  final double total;
  final int overOdds;
  final int underOdds;

  TotalCurrent copyWith({
    double total,
    int overOdds,
    int underOdds,
  }) =>
      TotalCurrent(
        total: total ?? this.total,
        overOdds: overOdds ?? this.overOdds,
        underOdds: underOdds ?? this.underOdds,
      );

  factory TotalCurrent.fromRawJson(String str) =>
      TotalCurrent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TotalCurrent.fromJson(Map<String, dynamic> json) => TotalCurrent(
        total: json["total"] == null ? null : json["total"].toDouble(),
        overOdds: json["overOdds"],
        underOdds: json["underOdds"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "overOdds": overOdds,
        "underOdds": underOdds,
      };

  @override
  List<Object> get props => [total, overOdds, underOdds];
}

class Schedule extends Equatable {
  Schedule({
    this.date,
    this.tbaTime,
  });

  final DateTime date;
  final bool tbaTime;

  Schedule copyWith({
    DateTime date,
    bool tbaTime,
  }) =>
      Schedule(
        date: date ?? this.date,
        tbaTime: tbaTime ?? this.tbaTime,
      );

  factory Schedule.fromRawJson(String str) =>
      Schedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        tbaTime: json["tbaTime"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date.toIso8601String(),
        "tbaTime": tbaTime,
      };

  @override
  List<Object> get props => [date, tbaTime];
}

class Scoreboard extends Equatable {
  Scoreboard({
    this.score,
    this.currentPeriod,
    this.periodTimeRemaining,
  });

  final Score score;
  final int currentPeriod;
  final String periodTimeRemaining;

  Scoreboard copyWith({
    Score score,
    int currentPeriod,
    String periodTimeRemaining,
  }) =>
      Scoreboard(
        score: score ?? this.score,
        currentPeriod: currentPeriod ?? this.currentPeriod,
        periodTimeRemaining: periodTimeRemaining ?? this.periodTimeRemaining,
      );

  factory Scoreboard.fromRawJson(String str) =>
      Scoreboard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Scoreboard.fromJson(Map<String, dynamic> json) => Scoreboard(
        score: json["score"] == null ? null : Score.fromJson(json["score"]),
        currentPeriod: json["currentPeriod"],
        periodTimeRemaining: json["periodTimeRemaining"],
      );

  Map<String, dynamic> toJson() => {
        "score": score == null ? null : score.toJson(),
        "currentPeriod": currentPeriod,
        "periodTimeRemaining": periodTimeRemaining,
      };

  @override
  List<Object> get props => [score, currentPeriod, periodTimeRemaining];
}

class Score extends Equatable {
  Score({
    this.away,
    this.home,
    this.awayPeriods,
    this.homePeriods,
  });

  final int away;
  final int home;
  final List<int> awayPeriods;
  final List<int> homePeriods;

  Score copyWith({
    int away,
    int home,
    List<int> awayPeriods,
    List<int> homePeriods,
  }) =>
      Score(
        away: away ?? this.away,
        home: home ?? this.home,
        awayPeriods: awayPeriods ?? this.awayPeriods,
        homePeriods: homePeriods ?? this.homePeriods,
      );

  factory Score.fromRawJson(String str) => Score.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        away: json["away"],
        home: json["home"],
        awayPeriods: json["awayPeriods"] == null
            ? null
            : List<int>.from(json["awayPeriods"].map((x) => x)),
        homePeriods: json["homePeriods"] == null
            ? null
            : List<int>.from(json["homePeriods"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "away": away,
        "home": home,
        "awayPeriods": awayPeriods == null
            ? null
            : List<dynamic>.from(awayPeriods.map((x) => x)),
        "homePeriods": homePeriods == null
            ? null
            : List<dynamic>.from(homePeriods.map((x) => x)),
      };

  @override
  List<Object> get props => [away, home, awayPeriods, homePeriods];
}

enum Status { FINAL, IN_PROGRESS, SCHEDULED, CANCELED }

final statusValues = EnumValues({
  "canceled": Status.CANCELED,
  "final": Status.FINAL,
  "in progress": Status.IN_PROGRESS,
  "scheduled": Status.SCHEDULED
});

class Teams extends Equatable {
  Teams({
    this.away,
    this.home,
  });

  final Away away;
  final Away home;

  Teams copyWith({
    Away away,
    Away home,
  }) =>
      Teams(
        away: away ?? this.away,
        home: home ?? this.home,
      );

  factory Teams.fromRawJson(String str) => Teams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
        away: json["away"] == null ? null : Away.fromJson(json["away"]),
        home: json["home"] == null ? null : Away.fromJson(json["home"]),
      );

  Map<String, dynamic> toJson() => {
        "away": away == null ? null : away.toJson(),
        "home": home == null ? null : home.toJson(),
      };

  @override
  List<Object> get props => [away, home];
}

class Away extends Equatable {
  Away({
    this.team,
    this.location,
    this.mascot,
    this.abbreviation,
    this.conference,
    this.division,
  });

  final String team;
  final String location;
  final String mascot;
  final String abbreviation;
  final String conference;
  final Division division;

  Away copyWith({
    String team,
    String location,
    String mascot,
    String abbreviation,
    String conference,
    Division division,
  }) =>
      Away(
        team: team ?? this.team,
        location: location ?? this.location,
        mascot: mascot ?? this.mascot,
        abbreviation: abbreviation ?? this.abbreviation,
        conference: conference ?? this.conference,
        division: division ?? this.division,
      );

  factory Away.fromRawJson(String str) => Away.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Away.fromJson(Map<String, dynamic> json) => Away(
        team: json["team"],
        location: json["location"],
        mascot: json["mascot"],
        abbreviation: json["abbreviation"],
        conference: json["conference"],
        division: json["division"] == null
            ? null
            : divisionValues.map[json["division"]],
      );

  Map<String, dynamic> toJson() => {
        "team": team,
        "location": location,
        "mascot": mascot,
        "abbreviation": abbreviation,
        "conference": conference,
        "division": division == null ? null : divisionValues.reverse[division],
      };

  @override
  List<Object> get props {
    return [
      team,
      location,
      mascot,
      abbreviation,
      conference,
      division,
    ];
  }
}

enum Division { EAST, CENTRAL, WEST, METROPOLITAN, ATLANTIC }

final divisionValues = EnumValues({
  "Atlantic": Division.ATLANTIC,
  "Central": Division.CENTRAL,
  "East": Division.EAST,
  "Metropolitan": Division.METROPOLITAN,
  "West": Division.WEST
});

class Venue extends Equatable {
  Venue({
    this.name,
    this.city,
    this.state,
    this.neutralSite,
  });

  final String name;
  final String city;
  final String state;
  final bool neutralSite;

  Venue copyWith({
    String name,
    String city,
    String state,
    bool neutralSite,
  }) =>
      Venue(
        name: name ?? this.name,
        city: city ?? this.city,
        state: state ?? this.state,
        neutralSite: neutralSite ?? this.neutralSite,
      );

  factory Venue.fromRawJson(String str) => Venue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        name: json["name"],
        city: json["city"],
        state: json["state"],
        neutralSite: json["neutralSite"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "city": city,
        "state": state,
        "neutralSite": neutralSite,
      };

  @override
  List<Object> get props => [name, city, state, neutralSite];
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
