import {
  formatTime,
  getCurrentWeek,
  getCurrentWeekByDate,
  pointSpreadAssign,
  whichKey,
  whichTeamWin,
} from "../helper_functions";
import * as admin from "firebase-admin";
import moment = require("moment");
import { NhlGame } from "../models/games/nhl_game";
import { NhlBet } from "../models/bets/nhl_bet";
const axios = require("axios").default;

export async function NhlResolve(data: NhlBet) {
  const batch = admin.firestore().batch();

  const league = data.league.toLowerCase();
  const dateTime = formatTime(data.gameStartDateTime);
  const week = getCurrentWeekByDate(data.dateTime);
  const apikey = whichKey(league);
  const gameId = data.gameId;
  const betType = data.betType;
  const isClosedFirestore = data.isClosed;
  const betTeam = data.betTeam;
  const amountBet = data.betAmount;
  const uid = data.uid;
  const betPlacedTime = data.dateTime;
  const amountWin = data.betProfit;
  const documentId = data.id;
  const totalWinAmount = amountWin + amountBet;

  const cumulativeVaultRef = admin
    .firestore()
    .collection("vault")
    .doc("cumulative");

  const betDateInVaultFormat = moment(betPlacedTime).format("yyyy-MM-DD");

  const dailyVaultRef = admin
    .firestore()
    .collection("vault")
    .doc("regular")
    .collection("daily")
    .doc(betDateInVaultFormat);

  return await axios
    .get(
      `https://fly.sportsdata.io/v3/${league}/scores/json/ScoresByDate/${dateTime}`,
      {
        params: {
          key: apikey,
        },
      }
    )
    .then(async function (data: any) {
      const jsonData: NhlGame[] = data["data"];
      const specificGame = jsonData.filter((game) => game.GameID == gameId)[0];
      const isClosed = specificGame.IsClosed;
      const status = specificGame.Status;
      const homeTeamScore = specificGame.HomeTeamScore;
      const awayTeamScore = specificGame.AwayTeamScore;

      const pointSpread = pointSpreadAssign(specificGame.PointSpread, betTeam);
      if (status == "Postponed") {
        const betRef = admin.firestore().collection("bets").doc(documentId);

        batch.update(betRef, {
          isClosed: null,
        });

        batch.set(
          cumulativeVaultRef,
          {
            moneyIn: admin.firestore.FieldValue.increment(-amountBet),
            totalBets: admin.firestore.FieldValue.increment(-1),
          },
          { merge: true }
        );

        batch.set(
          dailyVaultRef,
          {
            moneyIn: admin.firestore.FieldValue.increment(-amountBet),
            totalBets: admin.firestore.FieldValue.increment(-1),
          },
          { merge: true }
        );

        const documentName = getCurrentWeek();
        if (week == documentName) {
          const walletRef = admin.firestore().collection("wallets").doc(uid);

          batch.update(walletRef, {
            totalOpenBets: admin.firestore.FieldValue.increment(-1),

            accountBalance: admin.firestore.FieldValue.increment(amountBet),
            pendingRiskedAmount: admin.firestore.FieldValue.increment(
              -amountBet
            ),
            potentialWinAmount: admin.firestore.FieldValue.increment(
              -amountWin
            ),
          });
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
            accountBalance: admin.firestore.FieldValue.increment(amountBet),
            pendingRiskedAmount: admin.firestore.FieldValue.increment(
              -amountBet
            ),
            potentialWinAmount: admin.firestore.FieldValue.increment(
              -amountWin
            ),
          });
        }
        await batch.commit();
        // betsResolved++;
      } else {
        if (isClosed != isClosedFirestore) {
          if (homeTeamScore != null && awayTeamScore != null) {
            const gameNumber =
              betType == "pointspread" ? pointSpread : specificGame.OverUnder;

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

            const betRef = admin.firestore().collection("bets").doc(documentId);

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
                  totalOpenBets: admin.firestore.FieldValue.increment(-1),
                  totalProfit: admin.firestore.FieldValue.increment(amountWin),
                  accountBalance:
                    admin.firestore.FieldValue.increment(totalWinAmount),
                  pendingRiskedAmount: admin.firestore.FieldValue.increment(
                    -amountBet
                  ),
                  totalBetsWon: admin.firestore.FieldValue.increment(1),
                  potentialWinAmount: admin.firestore.FieldValue.increment(
                    -amountWin
                  ),
                });

                batch.set(
                  cumulativeVaultRef,
                  {
                    moneyOut:
                      admin.firestore.FieldValue.increment(totalWinAmount),
                  },
                  { merge: true }
                );

                batch.set(
                  dailyVaultRef,
                  {
                    moneyOut:
                      admin.firestore.FieldValue.increment(totalWinAmount),
                  },
                  { merge: true }
                );
              } else {
                batch.update(walletRef, {
                  totalOpenBets: admin.firestore.FieldValue.increment(-1),
                  totalLoss: admin.firestore.FieldValue.increment(amountBet),
                  totalBetsLost: admin.firestore.FieldValue.increment(1),
                  potentialWinAmount: admin.firestore.FieldValue.increment(
                    -amountWin
                  ),
                  pendingRiskedAmount: admin.firestore.FieldValue.increment(
                    -amountBet
                  ),
                });
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
                  totalOpenBets: admin.firestore.FieldValue.increment(-1),
                  totalProfit: admin.firestore.FieldValue.increment(amountWin),
                  accountBalance:
                    admin.firestore.FieldValue.increment(totalWinAmount),
                  pendingRiskedAmount: admin.firestore.FieldValue.increment(
                    -amountBet
                  ),
                  totalBetsWon: admin.firestore.FieldValue.increment(1),
                  potentialWinAmount: admin.firestore.FieldValue.increment(
                    -amountWin
                  ),
                });

                batch.set(
                  cumulativeVaultRef,
                  {
                    moneyOut:
                      admin.firestore.FieldValue.increment(totalWinAmount),
                  },
                  { merge: true }
                );

                batch.set(
                  dailyVaultRef,
                  {
                    moneyOut:
                      admin.firestore.FieldValue.increment(totalWinAmount),
                  },
                  { merge: true }
                );
              } else {
                batch.update(walletRef, {
                  totalOpenBets: admin.firestore.FieldValue.increment(-1),
                  totalLoss: admin.firestore.FieldValue.increment(amountBet),
                  totalBetsLost: admin.firestore.FieldValue.increment(1),
                  potentialWinAmount: admin.firestore.FieldValue.increment(
                    -amountWin
                  ),
                  pendingRiskedAmount: admin.firestore.FieldValue.increment(
                    -amountBet
                  ),
                });
              }
            }
            await batch.commit();
            // betsResolved++;
          }
        } else {
          // betsRemainOpen++;
        }
      }
    })
    .catch(function (error: any) {
      console.log(error);
    });
}
