import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
const axios = require("axios").default;
import moment = require("moment-timezone");

var app = admin.initializeApp();

export const resolveBets = functions.pubsub
  .schedule("every 4 hours")
  .onRun(async (context) => {
    let valueUpdateNumber = 0;
    let alreadyUpdateNumber = 0;

    console.log("This will be run every 4 hours!");
    await app
      .firestore()
      .collection("bets")
      .where("isClosed", "==", false)
      .get()
      .then(function (snapshots) {
        const promises: any = [];

        snapshots.docs.forEach(async (document) => {
          const data = document.data();

          const dateTime = formatTime(data.dateTime);
          const league = data.league.toLowerCase();
          const isClosedFirestore = data.isClosed;
          const apikey = whichKey(league);
          const gameId = data.gameID;
          const documentId = data.id;
          const uid = data.user;
          const betType = data.betType;
          const winTeam = data.winTeam;
          // const spread = data.spread;
          const amountBet = data.amountBet;
          const amountWin = data.amountWin;
          const totalWinAmount = amountWin + amountBet;

          const promise = axios
            .get(
              `https://fly.sportsdata.io/v3/${league}/scores/json/GamesByDate/${dateTime}`,
              {
                params: {
                  key: apikey,
                },
              }
            )
            .then(async function (data: any) {
              const jsonData: Game[] = data["data"];
              const specificGame = jsonData.filter(
                (game) => game.GameID == gameId
              )[0];
              const isClosed = specificGame.IsClosed;
              const homeTeamScore =
                league == "mlb"
                  ? specificGame.HomeTeamRuns
                  : specificGame.HomeTeamScore;
              const awayTeamScore =
                league == "mlb"
                  ? specificGame.AwayTeamRuns
                  : specificGame.AwayTeamScore;

              const pointSpread = pointSpreadAssign(
                specificGame.PointSpread,
                winTeam
              );

              if (isClosed != isClosedFirestore) {
                if (homeTeamScore != null && awayTeamScore != null) {
                  const spread =
                    betType == "POINT SPREAD"
                      ? pointSpread
                      : specificGame.OverUnder;
                  const finalWinTeam = whichTeamWin(
                    homeTeamScore,
                    awayTeamScore,
                    betType,
                    spread,
                    winTeam
                  );
                  const isWin = winTeam == finalWinTeam;

                  await app
                    .firestore()
                    .collection("bets")
                    .doc(documentId)
                    .update({
                      isClosed: isClosed,
                      homeTeamScore: homeTeamScore,
                      awayTeamScore: awayTeamScore,
                      finalWinTeam: finalWinTeam,
                    })
                    .then(async (_) => {
                      await app
                        .firestore()
                        .collection("users")
                        .doc(uid)
                        .update({
                          openBets: admin.firestore.FieldValue.increment(-1),
                          profit: isWin
                            ? admin.firestore.FieldValue.increment(amountWin)
                            : admin.firestore.FieldValue.increment(0),
                          accountBalance: isWin
                            ? admin.firestore.FieldValue.increment(
                                totalWinAmount
                              )
                            : admin.firestore.FieldValue.increment(0),
                          correctBets: isWin
                            ? admin.firestore.FieldValue.increment(1)
                            : admin.firestore.FieldValue.increment(0),
                        });
                      valueUpdateNumber++;
                    });
                }
              } else {
                alreadyUpdateNumber++;
              }
            })
            .catch(function (error: any) {
              console.log(error);
              return null;
            });

          promises.push(promise);
        });

        return Promise.all(promises);
      })
      .catch(function (error: any) {
        console.log(error);
        return null;
      })
      .then(function () {
        console.log(`${valueUpdateNumber} value updated!`);
        console.log(`${alreadyUpdateNumber} value already updated!`);
        functions.logger.info("Function Completed!", { structuredData: true });
        return null;
      });

    return null;

    function pointSpreadAssign(pointSpread: any, winTeam: string) {
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

    function whichTeamWin(
      homeTeamScore: number,
      awayTeamScore: number,
      betType: string,
      spread: any,
      winTeam: string
    ): string {
      if (betType == "moneyline") {
        return homeTeamScore > awayTeamScore ? "home" : "away";
      }
      if (betType == "pointSpread") {
        const finalWinTeam = homeTeamScore > awayTeamScore ? "home" : "away";
        const scoreDifference = homeTeamScore - awayTeamScore;
        if (spread >= 0) {
          // Positive Value
          // Underdog Betting Team
          if (winTeam != finalWinTeam) {
            if (scoreDifference <= Math.abs(spread)) {
              return winTeam == "home" ? "home" : "away";
            } else {
              return winTeam == "home" ? "away" : "home";
            }
          } else {
            return winTeam == "home" ? "away" : "home";
          }
        } else {
          // Negative Value
          // Favorite Betting Team
          if (winTeam == finalWinTeam) {
            if (scoreDifference >= Math.abs(spread)) {
              return winTeam == "home" ? "home" : "away";
            } else {
              return winTeam == "home" ? "away" : "home";
            }
          } else {
            return winTeam == "home" ? "away" : "home";
          }
        }
      }
      if (betType == "total") {
        const totalScore = homeTeamScore + awayTeamScore;
        return totalScore <= spread ? "home" : "away";
      } else {
        return "";
      }
    }

    function formatTime(dateTime: string): string {
      const d = new Date(dateTime);
      const myDatetimeFormat = "yyyy-MMM-DD";
      return moment(d).format(myDatetimeFormat);
    }

    function whichKey(league: string): string {
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
        default:
          return "";
          break;
      }
    }
  });

export const resolveLeaderboard = functions.pubsub
  .schedule("0 0 * * *")
  .onRun(async (context) => {
    console.log("This will be run every 1 days!");

    const documentName = await getWeekDate();

    await app
      .firestore()
      .collection("users")
      .get()
      .then((snapshots) => {
        snapshots.docs.forEach(async (element) => {
          await app
            .firestore()
            .collection("leaderboard")
            .doc(documentName)
            .set({ isArchive: true })
            .then(async (value) => {
              await app
                .firestore()
                .collection("leaderboard")
                .doc(documentName)
                .collection("users")
                .doc(element.id)
                .set(element.data())
                .then(async () => {
                  await app
                    .firestore()
                    .collection("users")
                    .doc(element.id)
                    .update({
                      profit: 0,
                      accountBalance: 1000,
                      correctBets: 0,
                      numberBets: 0,
                      openBets: 0,
                    });

                  return null;
                });
            });
        });
      })
      .then(() => {
        console.log("Leaderboard Function Completed");
        return null;
      });

    return null;

    async function getWeekDate(): Promise<string> {
      const constants = await app
        .firestore()
        .collection("constants")
        .doc("cloud")
        .get()
        .then((doc) => {
          return doc.data();
        })
        .then(async (data) => {
          await app
            .firestore()
            .collection("constants")
            .doc("cloud")
            .update({ nextWeek: admin.firestore.FieldValue.increment(1) });
          return data != null ? data.nextWeek : 0;
        });
      const start = new Date();
      var end = moment(start).add(7, "days");
      const myDatetimeFormat = "MM.DD.YY";
      const startFormat = moment(start).format(myDatetimeFormat);
      const endFormat = moment(end).format(myDatetimeFormat);
      const totalDocumentName = `Week ${constants} (${startFormat} - ${endFormat})`;
      return totalDocumentName;
    }
  });

export interface Game {
  GameID?: number;
  Season?: number;
  SeasonType?: number;
  Status?: string;
  Day?: Date;
  DateTime?: Date;
  AwayTeam?: string;
  HomeTeam?: string;
  AwayTeamID?: number;
  HomeTeamID?: number;
  StadiumID?: number;
  Channel?: string;
  Attendance?: null;
  AwayTeamScore?: number;
  HomeTeamScore?: number;
  AwayTeamRuns?: number;
  HomeTeamRuns?: number;
  Updated?: Date;
  Quarter?: null;
  TimeRemainingMinutes?: null;
  TimeRemainingSeconds?: null;
  PointSpread?: number;
  OverUnder?: number;
  AwayTeamMoneyLine?: number;
  HomeTeamMoneyLine?: number;
  GlobalGameID?: number;
  GlobalAwayTeamID?: number;
  GlobalHomeTeamID?: number;
  PointSpreadAwayTeamMoneyLine?: number;
  PointSpreadHomeTeamMoneyLine?: number;
  LastPlay?: null;
  IsClosed?: boolean;
  GameEndDateTime?: Date;
  HomeRotationNumber?: number;
  AwayRotationNumber?: number;
  NeutralVenue?: boolean;
  OverPayout?: number;
  UnderPayout?: number;
  Quarters?: Quarter[];
}

export interface Quarter {
  QuarterID?: number;
  GameID?: number;
  Number?: number;
  Name?: string;
  AwayScore?: number;
  HomeScore?: number;
}