import moment = require("moment");
import * as admin from "firebase-admin";
import { getCurrentWeek, getCurrentWeekByDate } from "../helper_functions";
import { ParalympicsBet } from "../models/bets/paralympics_bet";
import { ParalympicsGame } from "../models/games/paralympics_game";

export async function ParalympicsResolve(data: ParalympicsBet) {
  const batch = admin.firestore().batch();
  const week = getCurrentWeekByDate(data.dateTime);
  const gameId: string = data.gameId;
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

  await admin
    .firestore()
    .collection("custom_matches")
    .doc("paralympics_2021_tokyo")
    .collection("matches")
    .doc(gameId)
    .get()
    .then(async (match) => {
      const matchData: ParalympicsGame = match.data() as ParalympicsGame;
      if (matchData != undefined) {
        const isClosed = matchData.isClosed;
        const finalWinner = matchData.winner;

        if (isClosed != isClosedFirestore) {
          if (finalWinner == "none") {
            const betRef = admin.firestore().collection("bets").doc(documentId);

            batch.update(betRef, {
              isClosed: null,
              winner: finalWinner,
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
              const walletRef = admin
                .firestore()
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
            const isWin = betTeam == finalWinner;

            const betRef = admin.firestore().collection("bets").doc(documentId);

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
          //   betsRemainOpen++;
        }
      }
    })
    .catch(function (error: any) {
      console.log(error);
    });
}
