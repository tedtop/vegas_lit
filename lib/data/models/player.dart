class Player {
  Player(
      {this.playerID,
      this.sportsDataID,
      this.status,
      this.teamID,
      this.team,
      this.jersey,
      this.positionCategory,
      this.position,
      this.mLBAMID,
      this.firstName,
      this.lastName,
      this.batHand,
      this.throwHand,
      this.height,
      this.weight,
      this.birthDate,
      this.birthCity,
      this.birthState,
      this.birthCountry,
      this.highSchool,
      this.college,
      this.proDebut,
      this.salary,
      this.photoUrl,
      this.sportRadarPlayerID,
      this.rotoworldPlayerID,
      this.rotoWirePlayerID,
      this.fantasyAlarmPlayerID,
      this.statsPlayerID,
      this.sportsDirectPlayerID,
      this.xmlTeamPlayerID,
      this.injuryStatus,
      this.injuryBodyPart,
      this.injuryStartDate,
      this.injuryNotes,
      this.fanDuelPlayerID,
      this.draftKingsPlayerID,
      this.yahooPlayerID,
      this.upcomingGameID,
      this.fanDuelName,
      this.draftKingsName,
      this.yahooName,
      this.globalTeamID,
      this.fantasyDraftName,
      this.fantasyDraftPlayerID,
      this.experience,
      this.usaTodayPlayerID,
      this.usaTodayHeadshotUrl,
      this.usaTodayHeadshotNoBackgroundUrl,
      this.usaTodayHeadshotUpdated,
      this.usaTodayHeadshotNoBackgroundUpdated});

  Player.fromJson(Map<String, dynamic> json) {
    playerID = json['PlayerID'];
    sportsDataID = json['SportsDataID'];
    status = json['Status'];
    teamID = json['TeamID'];
    team = json['Team'];
    jersey = json['Jersey'];
    positionCategory = json['PositionCategory'];
    position = json['Position'];
    mLBAMID = json['MLBAMID'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    batHand = json['BatHand'];
    throwHand = json['ThrowHand'];
    height = json['Height'];
    weight = json['Weight'];
    birthDate = json['BirthDate'];
    birthCity = json['BirthCity'];
    birthState = json['BirthState'];
    birthCountry = json['BirthCountry'];
    highSchool = json['HighSchool'];
    college = json['College'];
    proDebut = json['ProDebut'];
    salary = json['Salary'];
    photoUrl = json['PhotoUrl'];
    sportRadarPlayerID = json['SportRadarPlayerID'];
    rotoworldPlayerID = json['RotoworldPlayerID'];
    rotoWirePlayerID = json['RotoWirePlayerID'];
    fantasyAlarmPlayerID = json['FantasyAlarmPlayerID'];
    statsPlayerID = json['StatsPlayerID'];
    sportsDirectPlayerID = json['SportsDirectPlayerID'];
    xmlTeamPlayerID = json['XmlTeamPlayerID'];
    injuryStatus = json['InjuryStatus'];
    injuryBodyPart = json['InjuryBodyPart'];
    injuryStartDate = json['InjuryStartDate'];
    injuryNotes = json['InjuryNotes'];
    fanDuelPlayerID = json['FanDuelPlayerID'];
    draftKingsPlayerID = json['DraftKingsPlayerID'];
    yahooPlayerID = json['YahooPlayerID'];
    upcomingGameID = json['UpcomingGameID'];
    fanDuelName = json['FanDuelName'];
    draftKingsName = json['DraftKingsName'];
    yahooName = json['YahooName'];
    globalTeamID = json['GlobalTeamID'];
    fantasyDraftName = json['FantasyDraftName'];
    fantasyDraftPlayerID = json['FantasyDraftPlayerID'];
    experience = json['Experience'];
    usaTodayPlayerID = json['UsaTodayPlayerID'];
    usaTodayHeadshotUrl = json['UsaTodayHeadshotUrl'];
    usaTodayHeadshotNoBackgroundUrl = json['UsaTodayHeadshotNoBackgroundUrl'];
    usaTodayHeadshotUpdated = json['UsaTodayHeadshotUpdated'];
    usaTodayHeadshotNoBackgroundUpdated =
        json['UsaTodayHeadshotNoBackgroundUpdated'];
  }

  var playerID;
  var sportsDataID;
  var status;
  var teamID;
  var team;
  var jersey;
  var positionCategory;
  var position;
  var mLBAMID;
  var firstName;
  var lastName;
  var batHand;
  var throwHand;
  var height;
  var weight;
  var birthDate;
  var birthCity;
  var birthState;
  var birthCountry;
  var highSchool;
  var college;
  var proDebut;
  var salary;
  var photoUrl;
  var sportRadarPlayerID;
  var rotoworldPlayerID;
  var rotoWirePlayerID;
  var fantasyAlarmPlayerID;
  var statsPlayerID;
  var sportsDirectPlayerID;
  var xmlTeamPlayerID;
  var injuryStatus;
  var injuryBodyPart;
  var injuryStartDate;
  var injuryNotes;
  var fanDuelPlayerID;
  var draftKingsPlayerID;
  var yahooPlayerID;
  var upcomingGameID;
  var fanDuelName;
  var draftKingsName;
  var yahooName;
  var globalTeamID;
  var fantasyDraftName;
  var fantasyDraftPlayerID;
  var experience;
  var usaTodayPlayerID;
  var usaTodayHeadshotUrl;
  var usaTodayHeadshotNoBackgroundUrl;
  var usaTodayHeadshotUpdated;
  var usaTodayHeadshotNoBackgroundUpdated;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['PlayerID'] = playerID;
    data['SportsDataID'] = sportsDataID;
    data['Status'] = status;
    data['TeamID'] = teamID;
    data['Team'] = team;
    data['Jersey'] = jersey;
    data['PositionCategory'] = positionCategory;
    data['Position'] = position;
    data['MLBAMID'] = mLBAMID;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['BatHand'] = batHand;
    data['ThrowHand'] = throwHand;
    data['Height'] = height;
    data['Weight'] = weight;
    data['BirthDate'] = birthDate;
    data['BirthCity'] = birthCity;
    data['BirthState'] = birthState;
    data['BirthCountry'] = birthCountry;
    data['HighSchool'] = highSchool;
    data['College'] = college;
    data['ProDebut'] = proDebut;
    data['Salary'] = salary;
    data['PhotoUrl'] = photoUrl;
    data['SportRadarPlayerID'] = sportRadarPlayerID;
    data['RotoworldPlayerID'] = rotoworldPlayerID;
    data['RotoWirePlayerID'] = rotoWirePlayerID;
    data['FantasyAlarmPlayerID'] = fantasyAlarmPlayerID;
    data['StatsPlayerID'] = statsPlayerID;
    data['SportsDirectPlayerID'] = sportsDirectPlayerID;
    data['XmlTeamPlayerID'] = xmlTeamPlayerID;
    data['InjuryStatus'] = injuryStatus;
    data['InjuryBodyPart'] = injuryBodyPart;
    data['InjuryStartDate'] = injuryStartDate;
    data['InjuryNotes'] = injuryNotes;
    data['FanDuelPlayerID'] = fanDuelPlayerID;
    data['DraftKingsPlayerID'] = draftKingsPlayerID;
    data['YahooPlayerID'] = yahooPlayerID;
    data['UpcomingGameID'] = upcomingGameID;
    data['FanDuelName'] = fanDuelName;
    data['DraftKingsName'] = draftKingsName;
    data['YahooName'] = yahooName;
    data['GlobalTeamID'] = globalTeamID;
    data['FantasyDraftName'] = fantasyDraftName;
    data['FantasyDraftPlayerID'] = fantasyDraftPlayerID;
    data['Experience'] = experience;
    data['UsaTodayPlayerID'] = usaTodayPlayerID;
    data['UsaTodayHeadshotUrl'] = usaTodayHeadshotUrl;
    data['UsaTodayHeadshotNoBackgroundUrl'] = usaTodayHeadshotNoBackgroundUrl;
    data['UsaTodayHeadshotUpdated'] = usaTodayHeadshotUpdated;
    data['UsaTodayHeadshotNoBackgroundUpdated'] =
        usaTodayHeadshotNoBackgroundUpdated;
    return data;
  }
}
