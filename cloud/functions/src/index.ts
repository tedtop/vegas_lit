import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
const axios = require("axios").default;
import moment = require("moment-timezone");

var app = admin.initializeApp();

export const resolveBets = functions.pubsub
  .schedule("50 23 * * *")
  .onRun(async (context) => {
    let valueUpdateNumber = 0;
    let alreadyUpdateNumber = 0;

    console.log("This function will be run everyday at 11:50 PM!");
    await app
      .firestore()
      .collection("bets")
      .where("isClosed", "==", false)
      .get()
      .then(function (snapshots) {
        const promises: any = [];

        snapshots.docs.forEach(async (document) => {
          const data = document.data();

          const dateTime = formatTime(data.gameDateTime);
          const league = data.league.toLowerCase();
          const isClosedFirestore = data.isClosed;
          const apikey = whichKey(league);
          const gameId = data.gameId;
          const documentId = data.id;
          const uid = data.user;
          const betType = data.betType;
          const betTeam = data.betTeam;
          const amountBet = data.betAmount;
          const amountWin = data.betProfit;
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
                betTeam
              );

              if (isClosed != isClosedFirestore) {
                if (homeTeamScore != null && awayTeamScore != null) {
                  const gameNumber =
                    betType == "pointspread"
                      ? pointSpread
                      : specificGame.OverUnder;
                  const finalWinTeam = whichTeamWin(
                    homeTeamScore,
                    awayTeamScore,
                    betType,
                    gameNumber,
                    betTeam
                  );
                  const finalWinTeamKey =
                    finalWinTeam == "away"
                      ? specificGame.AwayTeam
                      : specificGame.HomeTeam;
                  const isWin = betTeam == finalWinTeam;

                  await app
                    .firestore()
                    .collection("bets")
                    .doc(documentId)
                    .update({
                      isClosed: isClosed,
                      homeTeamScore: homeTeamScore,
                      awayTeamScore: awayTeamScore,
                      winningTeamName: finalWinTeam,
                      winningTeam: finalWinTeamKey,
                    })
                    .then(async (_) => {
                      await app
                        .firestore()
                        .collection("wallets")
                        .doc(uid)
                        .update({
                          totalOpenBets: admin.firestore.FieldValue.increment(
                            -1
                          ),
                          totalProfit: isWin
                            ? admin.firestore.FieldValue.increment(amountWin)
                            : admin.firestore.FieldValue.increment(-amountBet),
                          accountBalance: isWin
                            ? admin.firestore.FieldValue.increment(
                                totalWinAmount
                              )
                            : admin.firestore.FieldValue.increment(0),
                          totalWinBets: isWin
                            ? admin.firestore.FieldValue.increment(1)
                            : admin.firestore.FieldValue.increment(0),
                          totalLoseBets: isWin
                            ? admin.firestore.FieldValue.increment(0)
                            : admin.firestore.FieldValue.increment(1),
                          potentialWinAmount: admin.firestore.FieldValue.increment(
                            -amountWin
                          ),
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
      gameNumber: any,
      betTeam: string
    ): string {
      if (betType == "moneyline") {
        return homeTeamScore > awayTeamScore ? "home" : "away";
      }
      if (betType == "pointspread") {
        const finalWinTeam = homeTeamScore > awayTeamScore ? "home" : "away";
        const scoreDifference = homeTeamScore - awayTeamScore;
        if (gameNumber >= 0) {
          // Positive Value
          // Underdog Betting Team
          if (betTeam != finalWinTeam) {
            if (scoreDifference <= Math.abs(gameNumber)) {
              return betTeam == "home" ? "home" : "away";
            } else {
              return betTeam == "home" ? "away" : "home";
            }
          } else {
            return betTeam == "home" ? "away" : "home";
          }
        } else {
          // Negative Value
          // Favorite Betting Team
          if (betTeam == finalWinTeam) {
            if (scoreDifference >= Math.abs(gameNumber)) {
              return betTeam == "home" ? "home" : "away";
            } else {
              return betTeam == "home" ? "away" : "home";
            }
          } else {
            return betTeam == "home" ? "away" : "home";
          }
        }
      }
      if (betType == "total") {
        const totalScore = homeTeamScore + awayTeamScore;
        return totalScore <= gameNumber ? "home" : "away";
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
  .schedule("55 23 * * *")
  .onRun(async (context) => {
    console.log("This function will be run everyday at 11:55 PM!");

    const documentName = getCurrentDate();

    await app
      .firestore()
      .collection("wallets")
      .get()
      .then(async (snapshots) => {
        await app
          .firestore()
          .collection("leaderboard")
          .doc(documentName)
          .set({ isArchive: true })
          .then((_) => {
            const promises: any = [];
            snapshots.docs.forEach(async (element) => {
              const promise = await app
                .firestore()
                .collection("leaderboard")
                .doc(documentName)
                .collection("wallets")
                .doc(element.id)
                .set(element.data())
                .then(async () => {
                  await app
                    .firestore()
                    .collection("wallets")
                    .doc(element.id)
                    .update({
                      totalProfit: 0,
                      accountBalance: 1000,
                      totalWinBets: 0,
                      totalLoseBets: 0,
                      totalBets: 0,
                      totalOpenBets: 0,
                      totalRiskedAmount: 0,
                      potentialWinAmount: 0,
                    });
                  return null;
                });
              promises.push(promise);
            });
            return Promise.all(promises);
          });
      })
      .catch(function (error: any) {
        console.log(error);
        return null;
      })
      .then(() => {
        console.log("Leaderboard Resolved!");
        return null;
      });

    return null;

    function getCurrentDate(): string {
      const today = new Date();
      const walletsDayFormat = "YYYY-MM-DD";
      const todayFormat = moment(today).format(walletsDayFormat);
      return todayFormat;
    }

    // async function getWeekDate(): Promise<string> {
    //   const constants = await app
    //     .firestore()
    //     .collection("constants")
    //     .doc("cloud")
    //     .get()
    //     .then((doc) => {
    //       return doc.data();
    //     })
    //     .then(async (data) => {
    //       await app
    //         .firestore()
    //         .collection("constants")
    //         .doc("cloud")
    //         .update({ nextWeek: admin.firestore.FieldValue.increment(1) });
    //       return data != null ? data.nextWeek : 0;
    //     });
    //   const start = new Date();
    //   var end = moment(start).add(7, "days");
    //   const myDatetimeFormat = "MM.DD.YY";
    //   const startFormat = moment(start).format(myDatetimeFormat);
    //   const endFormat = moment(end).format(myDatetimeFormat);
    //   const totalDocumentName = `Week ${constants} (${startFormat} - ${endFormat})`;
    //   return totalDocumentName;
    // }
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
