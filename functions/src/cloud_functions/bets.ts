import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import moment = require("moment-timezone");
import { sendMessageToSlack } from "./slack";
import { Game } from "../models";
const axios = require("axios").default;
const performance = require("perf_hooks").performance;

export const resolveBets = functions.pubsub
  .schedule("*/30 * * * *")
  .timeZone("America/New_York")
  .onRun(async (context) => {
    // Send slack notification and start timer
    const startTime = performance.now();
    await sendMessageToSlack(`:mega: Resolving bets...`);

    let betsResolved = 0;
    let betsRemainOpen = 0;

    await admin
      .firestore()
      .collection("bets")
      .where("isClosed", "==", false)
      .get()
      .then(async function (snapshots) {
        await Promise.all(
          snapshots.docs.map(async (bet) => {
            const data = bet.data();
            const league = data.league.toLowerCase();
            const isClosedFirestore = data.isClosed;
            const betTeam = data.betTeam;
            const amountBet = data.betAmount;
            const uid = data.uid;
            const betPlacedTime = data.dateTime;
            const amountWin = data.betProfit;
            const username = data.username;
            const documentId = data.id;
            const totalWinAmount = amountWin + amountBet;

            const cumulativeVaultRef = admin
              .firestore()
              .collection("vault")
              .doc("cumulative");

            const betDateInVaultFormat =
              moment(betPlacedTime).format("yyyy-MM-DD");

            const dailyVaultRef = admin
              .firestore()
              .collection("vault")
              .doc("regular")
              .collection("daily")
              .doc(betDateInVaultFormat);

            if (league == "olympics") {
              const batch = admin.firestore().batch();
              const week = getCurrentWeekByDate(data.dateTime);
              const gameId: string = data.gameId;

              await admin
                .firestore()
                .collection("custom_matches")
                .doc("olympics_2021_tokyo")
                .collection("matches")
                .doc(gameId)
                .get()
                .then(async (match) => {
                  const matchData = match.data();
                  if (matchData != undefined) {
                    const isClosed = matchData.isClosed;
                    const finalWinner = matchData.winner;

                    if (isClosed != isClosedFirestore) {
                      if (finalWinner == "none") {
                        const betRef = admin
                          .firestore()
                          .collection("bets")
                          .doc(documentId);

                        batch.update(betRef, {
                          isClosed: null,
                          winner: finalWinner,
                        });

                        batch.set(
                          cumulativeVaultRef,
                          {
                            moneyIn: admin.firestore.FieldValue.increment(
                              -amountBet
                            ),
                            totalBets: admin.firestore.FieldValue.increment(-1),
                          },
                          { merge: true }
                        );

                        batch.set(
                          dailyVaultRef,
                          {
                            moneyIn: admin.firestore.FieldValue.increment(
                              -amountBet
                            ),
                            totalBets: admin.firestore.FieldValue.increment(-1),
                          },
                          { merge: true }
                        );

                        const documentName = getCurrentWeek();
                        if (week == documentName) {
                          const walletRef = admin
                            .firestore()
                            .collection("wallets")
                            .doc(uid);

                          batch.update(walletRef, {
                            totalOpenBets:
                              admin.firestore.FieldValue.increment(-1),

                            accountBalance:
                              admin.firestore.FieldValue.increment(amountBet),
                            pendingRiskedAmount:
                              admin.firestore.FieldValue.increment(-amountBet),
                            potentialWinAmount:
                              admin.firestore.FieldValue.increment(-amountWin),
                          });
                          await sendMessageToSlack(
                            `:hourglass_flowing_sand: Postponed match bet refunded to *${username}*`
                          );
                        } else {
                          const walletRef = admin
                            .firestore()
                            .collection("leaderboard")
                            .doc("global")
                            .collection("weeks")
                            .doc(week)
                            .collection("wallets")
                            .doc(uid);

                          batch.update(walletRef, {
                            totalOpenBets:
                              admin.firestore.FieldValue.increment(-1),
                            accountBalance:
                              admin.firestore.FieldValue.increment(amountBet),
                            pendingRiskedAmount:
                              admin.firestore.FieldValue.increment(-amountBet),
                            potentialWinAmount:
                              admin.firestore.FieldValue.increment(-amountWin),
                          });
                          await sendMessageToSlack(
                            `:hourglass_flowing_sand: Postponed match bet refunded to *${username}*`
                          );
                        }
                        await batch.commit();
                        betsResolved++;
                      } else {
                        const isWin = betTeam == finalWinner;

                        const betRef = admin
                          .firestore()
                          .collection("bets")
                          .doc(documentId);

                        batch.update(betRef, {
                          isClosed: isClosed,
                          winner: finalWinner,
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
                            batch.set(
                              cumulativeVaultRef,
                              {
                                moneyOut:
                                  admin.firestore.FieldValue.increment(
                                    totalWinAmount
                                  ),
                              },
                              { merge: true }
                            );

                            batch.set(
                              dailyVaultRef,
                              {
                                moneyOut:
                                  admin.firestore.FieldValue.increment(
                                    totalWinAmount
                                  ),
                              },
                              { merge: true }
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

                            batch.set(
                              cumulativeVaultRef,
                              {
                                moneyOut:
                                  admin.firestore.FieldValue.increment(
                                    totalWinAmount
                                  ),
                              },
                              { merge: true }
                            );

                            batch.set(
                              dailyVaultRef,
                              {
                                moneyOut:
                                  admin.firestore.FieldValue.increment(
                                    totalWinAmount
                                  ),
                              },
                              { merge: true }
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
                        }
                        await batch.commit();
                        betsResolved++;
                      }
                    } else {
                      betsRemainOpen++;
                    }
                  }
                })
                .catch(function (error: any) {
                  console.log(error);
                });
            } else {
              const batch = admin.firestore().batch();

              const dateTime = formatTime(data.gameStartDateTime);
              const week = getCurrentWeekByDate(data.dateTime);
              const apikey = whichKey(league);
              const gameId = data.gameId;
              const betType = data.betType;

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
                  const status = specificGame.Status;
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
                  if (status == "Postponed") {
                    const betRef = admin
                      .firestore()
                      .collection("bets")
                      .doc(documentId);

                    batch.update(betRef, {
                      isClosed: null,
                    });

                    batch.set(
                      cumulativeVaultRef,
                      {
                        moneyIn: admin.firestore.FieldValue.increment(
                          -amountBet
                        ),
                        totalBets: admin.firestore.FieldValue.increment(-1),
                      },
                      { merge: true }
                    );

                    batch.set(
                      dailyVaultRef,
                      {
                        moneyIn: admin.firestore.FieldValue.increment(
                          -amountBet
                        ),
                        totalBets: admin.firestore.FieldValue.increment(-1),
                      },
                      { merge: true }
                    );

                    const documentName = getCurrentWeek();
                    if (week == documentName) {
                      const walletRef = admin
                        .firestore()
                        .collection("wallets")
                        .doc(uid);

                      batch.update(walletRef, {
                        totalOpenBets: admin.firestore.FieldValue.increment(-1),

                        accountBalance:
                          admin.firestore.FieldValue.increment(amountBet),
                        pendingRiskedAmount:
                          admin.firestore.FieldValue.increment(-amountBet),
                        potentialWinAmount:
                          admin.firestore.FieldValue.increment(-amountWin),
                      });
                      await sendMessageToSlack(
                        `:hourglass_flowing_sand: Postponed match bet refunded to *${username}*`
                      );
                    } else {
                      const walletRef = admin
                        .firestore()
                        .collection("leaderboard")
                        .doc("global")
                        .collection("weeks")
                        .doc(week)
                        .collection("wallets")
                        .doc(uid);

                      batch.update(walletRef, {
                        totalOpenBets: admin.firestore.FieldValue.increment(-1),
                        accountBalance:
                          admin.firestore.FieldValue.increment(amountBet),
                        pendingRiskedAmount:
                          admin.firestore.FieldValue.increment(-amountBet),
                        potentialWinAmount:
                          admin.firestore.FieldValue.increment(-amountWin),
                      });
                      await sendMessageToSlack(
                        `:hourglass_flowing_sand: Postponed match bet refunded to *${username}*`
                      );
                    }
                    await batch.commit();
                    betsResolved++;
                  } else {
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
                            batch.set(
                              cumulativeVaultRef,
                              {
                                moneyOut:
                                  admin.firestore.FieldValue.increment(
                                    totalWinAmount
                                  ),
                              },
                              { merge: true }
                            );

                            batch.set(
                              dailyVaultRef,
                              {
                                moneyOut:
                                  admin.firestore.FieldValue.increment(
                                    totalWinAmount
                                  ),
                              },
                              { merge: true }
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

                            batch.set(
                              cumulativeVaultRef,
                              {
                                moneyOut:
                                  admin.firestore.FieldValue.increment(
                                    totalWinAmount
                                  ),
                              },
                              { merge: true }
                            );

                            batch.set(
                              dailyVaultRef,
                              {
                                moneyOut:
                                  admin.firestore.FieldValue.increment(
                                    totalWinAmount
                                  ),
                              },
                              { merge: true }
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
                        }
                        await batch.commit();
                        betsResolved++;
                      }
                    } else {
                      betsRemainOpen++;
                    }
                  }
                })
                .catch(function (error: any) {
                  console.log(error);
                });
            }
          })
        );
      })
      .catch(function (error: any) {
        console.log(error);
      })
      .then(async function () {
        await sendMessageToSlack(
          `:white_check_mark: ${betsResolved} bets resolved, ${betsRemainOpen} bets remain open`
        );
        // Rank Leaderboard after resolving bets
        await sendMessageToSlack(":rocket: Updating leaderboard...");
        await admin
          .firestore()
          .collection("wallets")
          .where("totalBets", ">=", 5)
          .get()
          .then(async function (snapshots) {
            let rankNumber = 1;
            const documents = snapshots.docs.sort((a, b) => {
              const firstData = a.data();
              const secondData = b.data();
              if (
                firstData.accountBalance +
                  firstData.pendingRiskedAmount -
                  firstData.totalRewards >
                secondData.accountBalance +
                  secondData.pendingRiskedAmount -
                  secondData.totalRewards
              )
                return -1;
              if (
                firstData.accountBalance +
                  firstData.pendingRiskedAmount -
                  firstData.totalRewards <
                secondData.accountBalance +
                  secondData.pendingRiskedAmount -
                  secondData.totalRewards
              )
                return 1;
              if (firstData.totalBets > secondData.totalBets) return -1;
              if (firstData.totalBets < secondData.totalBets) return 1;
              return 0;
            });
            for (const document of documents) {
              await document.ref.update({ rank: rankNumber });
              rankNumber++;
            }
          })
          .catch(function (error: any) {
            console.log(error);
          });
      });

    const endTime = performance.now();
    const timeTakeInExecution = endTime - startTime;
    await sendMessageToSlack(
      `:checkered_flag: Bet resolutions finished in ${timeTakeInExecution.toFixed(
        1
      )}ms`
    );

    // await sendLeaderboardToSlack();

    return true;

    // // Sending top 5 leaderboard players
    // async function sendLeaderboardToSlack() {
    //   await admin
    //     .firestore()
    //     .collection("wallets")
    //     .orderBy("rank", "desc")
    //     .limit(5)
    //     .get()
    //     .then(async (snapshots) => {
    //       var rankNumber = 1;

    //       for (const docs of snapshots.docs) {
    //         await sendMessageToSlack(`${rankNumber}. ${docs.data().username}`);
    //         rankNumber++;
    //       }
    //     });
    // }

    // Get current week in format
    function getCurrentWeek(): string {
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
    function getCurrentWeekByDate(date: Date): string {
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
            if (Math.abs(scoreDifference) <= Math.abs(gameNumber)) {
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
            if (Math.abs(scoreDifference) >= Math.abs(gameNumber)) {
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
