import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
const axios = require("axios").default;
const IncomingWebhook = require("@slack/client").IncomingWebhook;
const url =
  "https://hooks.slack.com/services/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";
const webhook = new IncomingWebhook(url);
import moment = require("moment-timezone");
const performance = require("perf_hooks").performance;

var app = admin.initializeApp();

export const resolveBets = functions.pubsub
  .schedule("0 * * * *")
  .timeZone("America/New_York")
  .onRun(async (context) => {
    const startTime = performance.now();
    await sendMessageToSlack(`:mega: Resolving bets...`);
    console.log("This will be run every 1 hour!");
    let valueUpdateNumber = 0;
    let alreadyUpdateNumber = 0;

    await app
      .firestore()
      .collection("bets")
      .where("isClosed", "==", false)
      .get()
      .then(async function (snapshots) {
        await Promise.all(
          snapshots.docs.map(async (document) => {
            const data = document.data();

            const dateTime = formatTime(data.gameStartDateTime);
            const league = data.league.toLowerCase();
            const isClosedFirestore = data.isClosed;
            const apikey = whichKey(league);
            const gameId = data.gameId;
            const documentId = data.id;
            const uid = data.uid;
            const betType = data.betType;
            const betTeam = data.betTeam;
            const amountBet = data.betAmount;
            const username = data.username;
            const amountWin = data.betProfit;
            const totalWinAmount = amountWin + amountBet;

            await axios
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

                    const totalGameScore = homeTeamScore + awayTeamScore;
                    const finalWinTeam = whichTeamWin(
                      homeTeamScore,
                      awayTeamScore,
                      betType,
                      gameNumber,
                      betTeam
                    );
                    const finalWinTeamName =
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
                        winningTeamName: finalWinTeamName,
                        totalGameScore: totalGameScore,
                        winningTeam: finalWinTeam,
                      })
                      .then(async (_) => {
                        if (isWin) {
                          await app
                            .firestore()
                            .collection("wallets")
                            .doc(uid)
                            .update({
                              totalOpenBets:
                                admin.firestore.FieldValue.increment(-1),
                              totalProfit:
                                admin.firestore.FieldValue.increment(amountWin),
                              accountBalance:
                                admin.firestore.FieldValue.increment(
                                  totalWinAmount
                                ),
                              pendingRiskedAmount:
                                admin.firestore.FieldValue.increment(
                                  -amountBet
                                ),
                              totalBetsWon:
                                admin.firestore.FieldValue.increment(1),
                              potentialWinAmount:
                                admin.firestore.FieldValue.increment(
                                  -amountWin
                                ),
                            });
                          await sendMessageToSlack(
                            `:dart: *${username}* won their $${amountBet} bet and won $${amountWin}`
                          );
                        } else {
                          await app
                            .firestore()
                            .collection("wallets")
                            .doc(uid)
                            .update({
                              totalOpenBets:
                                admin.firestore.FieldValue.increment(-1),
                              totalLoss:
                                admin.firestore.FieldValue.increment(amountBet),
                              totalBetsLost:
                                admin.firestore.FieldValue.increment(1),
                              potentialWinAmount:
                                admin.firestore.FieldValue.increment(
                                  -amountWin
                                ),
                              pendingRiskedAmount:
                                admin.firestore.FieldValue.increment(
                                  -amountBet
                                ),
                            });
                          await sendMessageToSlack(
                            `:moneybag: *${username}* lost their bet for $${amountBet}`
                          );
                        }

                        valueUpdateNumber++;
                      });
                  }
                } else {
                  alreadyUpdateNumber++;
                }
              })
              .catch(function (error: any) {
                console.log(error);
              });
          })
        );
      })
      .catch(function (error: any) {
        console.log(error);
      })
      .then(async function () {
        console.log(`${valueUpdateNumber} value updated!`);
        console.log(`${alreadyUpdateNumber} value already updated!`);
        await sendMessageToSlack(
          `:white_check_mark: ${valueUpdateNumber} bets resolved, ${alreadyUpdateNumber} bets remain open`
        );
        functions.logger.info("Function Completed!", { structuredData: true });
      });

    const endTime = performance.now();
    const timeTakeInExecution = endTime - startTime;
    await sendMessageToSlack(
      `:checkered_flag: Bet resolutions finished in ${timeTakeInExecution.toFixed(
        1
      )}ms`
    );
    // await sendMessageToSlack(":rocket: Updating leaderboard...");

    // await sendLeaderboardToSlack();

    return true;

    // Sending top 10 leaderboard users
    // async function sendLeaderboardToSlack() {
    //   await app
    //     .firestore()
    //     .collection("wallets")
    //     .orderBy("totalProfit", "desc")
    //     .limit(10)
    //     .get()
    //     .then(async (snapshots) => {
    //       var rankNumber = 1;

    //       for (const docs of snapshots.docs) {
    //         await sendMessageToSlack(`${rankNumber}. ${docs.data().username}`);
    //         rankNumber++;
    //       }
    //     });
    // }

    // Finding point spread sign
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

    // Team win logic
    function whichTeamWin(
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
            if (scoreDifference <= Math.abs(gameNumber)) {
              return betTeam == "home" ? "home" : "away";
            } else {
              return betTeam == "home" ? "away" : "home";
            }
          } else {
            return betTeam == "home" ? "away" : "home";
          }
        } else {
          // Negative value
          // Favorite betting team
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
      // Total type calculation
      if (betType == "total") {
        const totalScore = homeTeamScore + awayTeamScore;
        return totalScore <= gameNumber ? "home" : "away";
      } else {
        return "";
      }
    }

    // Format given date in specific format
    function formatTime(dateTime: string): string {
      const date = Date.parse(dateTime);
      const myDatetimeFormat = "yyyy-MMM-DD";
      return moment(date).format(myDatetimeFormat);
    }

    // Key checking for specific game
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

// export const resetContestDay = functions.pubsub
//   .schedule("59 23 * * *")
//   .timeZone("America/New_York")
//   .onRun(async (context) => {
//     console.log("This function will be run everyday at 11:58 PM!");

//     const documentName = getTodayDate();

//     // Fetching user's wallet
//     await app
//       .firestore()
//       .collection("wallets")
//       .get()
//       .then(async (snapshots) => {
//         // Create today's date document in leaderboard
//         await app
//           .firestore()
//           .collection("leaderboard")
//           .doc(documentName)
//           .set({ isArchived: true })
//           .then((_) => {
//             const promises: any = [];
//             // Run loop over all user's wallet document
//             snapshots.docs.map(async (element) => {
//               // For every document, save it to today's date document in leaderboard
//               const promise = await app
//                 .firestore()
//                 .collection("leaderboard")
//                 .doc(documentName)
//                 .collection("wallets")
//                 .doc(element.id)
//                 .set(element.data())
//                 .then(async (_) => {
//                   // After saving, reset that specific user wallets
//                   await app
//                     .firestore()
//                     .collection("wallets")
//                     .doc(element.id)
//                     .update({
//                       totalProfit: 0,
//                       accountBalance: 1000,
//                       totalBetsWon: 0,
//                       totalBetsLost: 0,
//                       totalLoss: 0,
//                       totalBets: 0,
//                       totalOpenBets: 0,
//                       totalRiskedAmount: 0,
//                       potentialWinAmount: 0,
//                     });
//                 });
//               promises.push(promise);
//             });
//             return Promise.all(promises);
//           });
//       })
//       .catch(function (error: any) {
//         console.log(error);
//       })
//       .then(() => {
//         functions.logger.info("Leaderboard Resolved!", {
//           structuredData: true,
//         });
//       });

//     return null;

//     function getTodayDate(): string {
//       let today = new Date();
//       const walletsDayFormat = "YYYY-MM-DD";
//       const todayFormat = moment(today).format(walletsDayFormat);
//       return todayFormat;
//     }
//   });

export const resetContestWeek = functions.pubsub
  .schedule("58 23 * * 3")
  .timeZone("America/New_York")
  .onRun(async (context) => {
    console.log("This function will be run every saturday at 11:58 PM!");

    const documentName = getCurrentWeek();

    // Fetching user's wallet
    await app
      .firestore()
      .collection("wallets")
      .get()
      .then(async (snapshots) => {
        // Create today's date document in leaderboard
        await app
          .firestore()
          .collection("leaderboard")
          .doc("global")
          .collection("weeks")
          .doc(documentName)
          .set({ isArchived: true })
          .then((_) => {
            const promises: any = [];
            // Run loop over all user's wallet document
            snapshots.docs.map(async (element) => {
              // For every document, save it to today's date document in leaderboard
              const promise = await app
                .firestore()
                .collection("leaderboard")
                .doc("global")
                .collection("weeks")
                .doc(documentName)
                .collection("wallets")
                .doc(element.id)
                .set(element.data())
                .then(async (_) => {
                  // After saving, reset that specific user wallets
                  await app
                    .firestore()
                    .collection("wallets")
                    .doc(element.id)
                    .update({
                      totalProfit: 0,
                      accountBalance: 1000,
                      totalBetsWon: 0,
                      totalBetsLost: 0,
                      totalLoss: 0,
                      totalBets: 0,
                      rank: 0,
                      pendingRiskedAmount: 0,
                      totalRewards: 0,
                      totalOpenBets: 0,
                      totalRiskedAmount: 0,
                      potentialWinAmount: 0,
                    });
                });
              promises.push(promise);
            });
            return Promise.all(promises);
          });
      })
      .catch(function (error: any) {
        console.log(error);
      })
      .then(() => {
        functions.logger.info("Leaderboard Resolved!", {
          structuredData: true,
        });
      });

    return null;

    function getCurrentWeek(): string {
      let today = new Date();
      const weekNextFormat = moment(today).format("w");
      const nextWeekFormatInteger = Number.parseInt(weekNextFormat) + 1;
      const walletsDayFormat = "YYYY-w";
      const weekFormat = moment(today).format(walletsDayFormat);
      const fullData = `${weekFormat}-${nextWeekFormatInteger}`;
      return fullData;
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

export const sendBetCreatedToSlack = functions.firestore
  .document("bets/{docId}")
  .onCreate(async (snapshot, context) => {
    const data = snapshot.data();

    const teamCity =
      data.betTeam == "away" ? data.awayTeamCity : data.homeTeamCity;
    const teamName =
      data.betTeam == "away" ? data.awayTeamName : data.homeTeamName;
    const msg = `:slot_machine: *${data.username}* placed a $${data.betAmount} ${data.betType} bet on the ${teamCity} ${teamName}`;

    await sendMessageToSlack(msg);
    return true;
  });

async function sendMessageToSlack(message: any) {
  await webhook.send(
    message,
    function (err: any, header: any, statusCode: any, body: any) {
      if (err) {
        console.log("Error:", err);
      } else {
        console.log("Received", statusCode, "from Slack");
      }
    }
  );
}

export const rankLeaderboard = functions.pubsub
  .schedule("2 * * * *")
  .timeZone("America/New_York")
  .onRun(async (context) => {
    await app
      .firestore()
      .collection("wallets")
      .get()
      .then(async function (snapshots) {
        let rankNumber = 1;
        const sortedList = snapshots.docs.sort((a, b) =>
          a.data().accountBalance + a.data().pendingRiskedAmount >
          b.data().accountBalance + b.data().pendingRiskedAmount
            ? -1
            : 1
        );
        await Promise.all(
          sortedList.map(async (document) => {
            await document.ref.update({ rank: rankNumber });
            rankNumber++;
          })
        );
      })
      .catch(function (error: any) {
        console.log(error);
      });
  });
