import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import moment = require("moment-timezone");
import { sendMessageToSlack } from "./slack";
import { Game } from "../models";
const axios = require("axios").default;
const performance = require("perf_hooks").performance;

export const resolveBets = functions.pubsub
  .schedule("0 * * * *")
  .timeZone("America/New_York")
  .onRun(async (context) => {
    const startTime = performance.now();
    await sendMessageToSlack(`:mega: Resolving bets...`);
    console.log("This will be run every 1 hour!");
    let valueUpdateNumber = 0;
    let alreadyUpdateNumber = 0;

    await admin
      .firestore()
      .collection("bets")
      .where("isClosed", "==", false)
      .get()
      .then(async function (snapshots) {
        await Promise.all(
          snapshots.docs.map(async (document) => {
            const batch = admin.firestore().batch();

            const data = document.data();

            const dateTime = formatTime(data.gameStartDateTime);
            const league = data.league.toLowerCase();
            const isClosedFirestore = data.isClosed;
            const apikey = whichKey(league);
            const gameId = data.gameId;
            const documentId = data.id;
            const uid = data.uid;
            const betType = data.betType;
            const week = data.week;
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

                    const betRef = admin
                      .firestore()
                      .collection("bets")
                      .doc(documentId);

                    batch.update(betRef, {
                      isClosed: isClosed,
                      homeTeamScore: homeTeamScore,
                      awayTeamScore: awayTeamScore,
                      winningTeamName: finalWinTeamName,
                      totalGameScore: totalGameScore,
                      winningTeam: finalWinTeam,
                    });

                    const documentName = getCurrentWeek();
                    if (week == documentName) {
                      const walletRef = admin
                        .firestore()
                        .collection("wallets")
                        .doc(uid);
                      if (isWin) {
                        batch.update(walletRef, {
                          totalOpenBets:
                            admin.firestore.FieldValue.increment(-1),
                          totalProfit:
                            admin.firestore.FieldValue.increment(amountWin),
                          accountBalance:
                            admin.firestore.FieldValue.increment(
                              totalWinAmount
                            ),
                          pendingRiskedAmount:
                            admin.firestore.FieldValue.increment(-amountBet),
                          totalBetsWon: admin.firestore.FieldValue.increment(1),
                          potentialWinAmount:
                            admin.firestore.FieldValue.increment(-amountWin),
                        });
                        await sendMessageToSlack(
                          `:dart: *${username}* won their $${amountBet} bet and won $${amountWin}`
                        );
                      } else {
                        batch.update(walletRef, {
                          totalOpenBets:
                            admin.firestore.FieldValue.increment(-1),
                          totalLoss:
                            admin.firestore.FieldValue.increment(amountBet),
                          totalBetsLost:
                            admin.firestore.FieldValue.increment(1),
                          potentialWinAmount:
                            admin.firestore.FieldValue.increment(-amountWin),
                          pendingRiskedAmount:
                            admin.firestore.FieldValue.increment(-amountBet),
                        });
                        await sendMessageToSlack(
                          `:moneybag: *${username}* lost their bet for $${amountBet}`
                        );
                      }
                    } else {
                      const walletRef = admin
                        .firestore()
                        .collection("leaderboard")
                        .doc("global")
                        .collection("weeks")
                        .doc(week)
                        .collection("wallets")
                        .doc(uid);
                      if (isWin) {
                        batch.update(walletRef, {
                          totalOpenBets:
                            admin.firestore.FieldValue.increment(-1),
                          totalProfit:
                            admin.firestore.FieldValue.increment(amountWin),
                          accountBalance:
                            admin.firestore.FieldValue.increment(
                              totalWinAmount
                            ),
                          pendingRiskedAmount:
                            admin.firestore.FieldValue.increment(-amountBet),
                          totalBetsWon: admin.firestore.FieldValue.increment(1),
                          potentialWinAmount:
                            admin.firestore.FieldValue.increment(-amountWin),
                        });
                        await sendMessageToSlack(
                          `:dart: *${username}* won their $${amountBet} bet and won $${amountWin}`
                        );
                      } else {
                        batch.update(walletRef, {
                          totalOpenBets:
                            admin.firestore.FieldValue.increment(-1),
                          totalLoss:
                            admin.firestore.FieldValue.increment(amountBet),
                          totalBetsLost:
                            admin.firestore.FieldValue.increment(1),
                          potentialWinAmount:
                            admin.firestore.FieldValue.increment(-amountWin),
                          pendingRiskedAmount:
                            admin.firestore.FieldValue.increment(-amountBet),
                        });
                        await sendMessageToSlack(
                          `:moneybag: *${username}* lost their bet for $${amountBet}`
                        );
                      }
                    }
                    await batch.commit();
                    valueUpdateNumber++;
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
    await sendMessageToSlack(":rocket: Updating leaderboard...");

    await sendLeaderboardToSlack();

    return true;

    // Sending top 5 leaderboard players
    async function sendLeaderboardToSlack() {
      await admin
        .firestore()
        .collection("wallets")
        .orderBy("rank", "desc")
        .limit(5)
        .get()
        .then(async (snapshots) => {
          var rankNumber = 1;

          for (const docs of snapshots.docs) {
            await sendMessageToSlack(`${rankNumber}. ${docs.data().username}`);
            rankNumber++;
          }
        });
    }

    // Get current week in format
    function getCurrentWeek(): string {
      const currentDate = moment().tz("America/New_York");
      if (currentDate.day() <= 3) {
        const todayWeekNumber = currentDate.format("w");
        const todayWeekFormat = currentDate.format("YYYY-w");
        const nextWeekFormatInteger = Number.parseInt(todayWeekNumber) + 1;
        const leaderboardWeekName = `${todayWeekFormat}-${nextWeekFormatInteger}`;
        return leaderboardWeekName;
      } else {
        const todayWeekNumber = currentDate.format("w");
        const todayWeekFormat = currentDate.format("YYYY");
        const nextWeekFormatFirst = Number.parseInt(todayWeekNumber) + 1;
        const nextWeekFormatSecond = nextWeekFormatFirst + 1;
        const leaderboardWeekName = `${todayWeekFormat}-${nextWeekFormatFirst}-${nextWeekFormatSecond}`;
        return leaderboardWeekName;
      }
    }

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
