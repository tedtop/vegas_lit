import moment = require("moment-timezone");

// Get current week in format
export function getCurrentWeek(): string {
  const currentDate = moment().tz("America/New_York");
  if (currentDate.day() <= 3) {
    const todayWeekNumber = currentDate.format("w");
    const todayWeekFormat = currentDate.format("YYYY");
    const weekFormatFirst = Number.parseInt(todayWeekNumber) - 1;
    const weekFormatSecond = Number.parseInt(todayWeekNumber);
    const leaderboardWeekName = `${todayWeekFormat}-${weekFormatFirst}-${weekFormatSecond}`;
    return leaderboardWeekName;
  } else {
    const todayWeekNumber = currentDate.format("w");
    const todayWeekFormat = currentDate.format("YYYY");
    const weekFormatFirst = Number.parseInt(todayWeekNumber);
    const weekFormatSecond = Number.parseInt(todayWeekNumber) + 1;
    const leaderboardWeekName = `${todayWeekFormat}-${weekFormatFirst}-${weekFormatSecond}`;
    return leaderboardWeekName;
  }
}

// Get current week in format
export function getCurrentWeekByDate(date: Date): string {
  const currentDate = moment(date);
  if (currentDate.day() <= 3) {
    const todayWeekNumber = currentDate.format("w");
    const todayWeekFormat = currentDate.format("YYYY");
    const weekFormatFirst = Number.parseInt(todayWeekNumber) - 1;
    const weekFormatSecond = Number.parseInt(todayWeekNumber);
    const leaderboardWeekName = `${todayWeekFormat}-${weekFormatFirst}-${weekFormatSecond}`;
    return leaderboardWeekName;
  } else {
    const todayWeekNumber = currentDate.format("w");
    const todayWeekFormat = currentDate.format("YYYY");
    const weekFormatFirst = Number.parseInt(todayWeekNumber);
    const weekFormatSecond = Number.parseInt(todayWeekNumber) + 1;
    const leaderboardWeekName = `${todayWeekFormat}-${weekFormatFirst}-${weekFormatSecond}`;
    return leaderboardWeekName;
  }
}

// Finding point spread sign
export function pointSpreadAssign(pointSpread: any, winTeam: string) {
  if (pointSpread != null) {
    const isPointSpreadNegative = pointSpread > 0 ? false : true;
    if (winTeam == "home") {
      const homeTeamPointSpread = isPointSpreadNegative
        ? -Math.abs(pointSpread)
        : Math.abs(pointSpread);
      return homeTeamPointSpread;
    } else {
      const awayTeamPointSpread = isPointSpreadNegative
        ? Math.abs(pointSpread)
        : -Math.abs(pointSpread);
      return awayTeamPointSpread;
    }
  } else {
    return null;
  }
}

// Team win logic
export function whichTeamWin(
  homeTeamScore: number,
  awayTeamScore: number,
  betType: string,
  gameNumber: any,
  betTeam: string
): string {
  // Moneyline type calculation
  if (betType == "moneyline") {
    return homeTeamScore > awayTeamScore ? "home" : "away";
  }
  // Point spread type calculation
  if (betType == "pointspread") {
    const finalWinTeam = homeTeamScore > awayTeamScore ? "home" : "away";
    const scoreDifference = homeTeamScore - awayTeamScore;
    if (gameNumber >= 0) {
      // Positive value
      // Underdog betting team
      if (betTeam != finalWinTeam) {
        if (Math.abs(scoreDifference) <= Math.abs(gameNumber)) {
          return betTeam == "home" ? "home" : "away";
        } else {
          return betTeam == "home" ? "away" : "home";
        }
      } else {
        return betTeam == "home" ? "home" : "away";
      }
    } else {
      // Negative value
      // Favorite betting team
      // if (betTeam == finalWinTeam) {
      if (Math.abs(scoreDifference) >= Math.abs(gameNumber)) {
        return betTeam == "home" ? "home" : "away";
      } else {
        return betTeam == "home" ? "away" : "home";
      }
      // } else {
      //   return betTeam == "home" ? "away" : "home";
      // }
    }
  }
  // Total type calculation
  if (betType == "total") {
    const totalScore = homeTeamScore + awayTeamScore;
    return totalScore <= gameNumber ? "home" : "away";
  } else {
    return "";
  }
}

// Format given date in specific format
export function formatTime(dateTime: string): string {
  const date = Date.parse(dateTime);
  const myDatetimeFormat = "yyyy-MMM-DD";
  return moment(date).format(myDatetimeFormat);
}

// Key checking for specific game
export function whichKey(league: string): string {
  switch (league) {
    case "nba":
      return "4d77c75bcd884680ba8493da19f1aece";
      break;
    case "mlb":
      return "d569ee15932e4266bf5e0fc8330dbb90";
      break;
    case "nhl":
      return "d02fe5a19d1249daa5879948da06f627";
      break;
    case "ccb":
      return "c4ddc8ca2fcd4c659c0910eabc75a4c6";
      break;
    case "nfl":
      return "f45a65cc1d7642f7950644d49ec749fc";
      break;
    case "cfb":
      return "bb98e463c5e34a86bb246ff4574a598f";
      break;
    default:
      return "";
      break;
  }
}
