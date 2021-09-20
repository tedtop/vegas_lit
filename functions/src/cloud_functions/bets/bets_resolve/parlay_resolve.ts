import {
  formatTime,
  getCurrentWeek,
  getCurrentWeekByDate,
  pointSpreadAssign,
  whichKey,
  whichTeamWin,
} from "../helper_functions";
import { ParlayBet } from "../models/bets/parlay_bet";
import * as admin from "firebase-admin";
import moment = require("moment");
const axios = require("axios").default;
import { NcaafBet } from "../models/bets/cfb_bet";
import { NcaabBet } from "../models/bets/cbb_bet";
import { NhlBet } from "../models/bets/nhl_bet";
import { NbaBet } from "../models/bets/nba_bet";
import { MlbBet } from "../models/bets/mlb_bet";
import { NflBet } from "../models/bets/nfl_bet";
import { MlbGame } from "../models/games/mlb_game";
import { NflGame } from "../models/games/nfl_game";
import { NcaafGame } from "../models/games/cfb_game";
import { NbaGame } from "../models/games/nba_game";
import { NhlGame } from "../models/games/nhl_game";
import { NcaabGame } from "../models/games/cbb_game";

export async function ParlayResolve(data: ParlayBet) {
  const dateTime = formatTime(data.gameStartDateTime);
  const week = getCurrentWeekByDate(data.dateTime);
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

  const betListUpdateBatch = admin.firestore().batch();

  const betList = await Promise.all(
    data.bets.map(async (bet: any, index: number) => {
      const league = bet.league.toLowerCase();
      const betRef = admin.firestore().collection("bets").doc(documentId);
      if (league == "nfl") {
        const nflBet: NflBet = bet as NflBet;

        const apikey = whichKey(league);
        const gameId = nflBet.gameId;

        const apiData = await axios
          .get(
            `https://fly.sportsdata.io/v3/${league}/scores/json/ScoresByDate/${dateTime}`,
            {
              params: {
                key: apikey,
              },
            }
          )
          .catch(function (error: any) {
            console.log(error);
          });

        const jsonData: NflGame[] = apiData["data"];
        const specificGame = jsonData.filter(
          (game) => game.GlobalGameID == gameId
        )[0];

        const status = specificGame.Status;
        const homeTeamScore = specificGame.HomeScore;
        const awayTeamScore = specificGame.AwayScore;

        const pointSpread = pointSpreadAssign(
          specificGame.PointSpread,
          nflBet.betTeam
        );
        if (status == "Postponed" || status == "Canceled") {
          // Update Bet
          nflBet.isClosed = null;
          data.bets[index] = nflBet;
          betListUpdateBatch.update(betRef, data);

          return "cancelled" as string;
        } else {
          if (homeTeamScore != null && awayTeamScore != null) {
            const gameNumber =
              nflBet.betType == "pointspread"
                ? pointSpread
                : specificGame.OverUnder;

            const totalGameScore = homeTeamScore + awayTeamScore;

            const finalWinTeam = whichTeamWin(
              homeTeamScore,
              awayTeamScore,
              nflBet.betType,
              gameNumber,
              nflBet.betTeam
            );
            const finalWinTeamName =
              finalWinTeam == "away"
                ? specificGame.AwayTeam
                : specificGame.HomeTeam;

            const isWin = nflBet.betTeam == finalWinTeam;

            // Update Bet
            nflBet.isClosed = true;
            nflBet.homeTeamScore = homeTeamScore;
            nflBet.awayTeamScore = awayTeamScore;
            finalWinTeamName != null
              ? (nflBet.winningTeamName = finalWinTeamName)
              : finalWinTeamName;
            nflBet.totalGameScore = totalGameScore;
            nflBet.winningTeam = finalWinTeam;
            data.bets[index] = nflBet;
            betListUpdateBatch.update(betRef, data);

            return isWin ? ("won" as string) : ("lose" as string);
          } else {
            return "null" as string;
          }
        }
      } else if (league == "cfb") {
        const ncaafBet: NcaafBet = bet as NcaafBet;

        const apikey = whichKey(league);
        const gameId = ncaafBet.gameId;

        const apiData = await axios
          .get(
            `https://fly.sportsdata.io/v3/${league}/scores/json/GamesByDate/${dateTime}`,
            {
              params: {
                key: apikey,
              },
            }
          )
          .catch(function (error: any) {
            console.log(error);
          });

        const jsonData: NcaafGame[] = apiData["data"];
        const specificGame = jsonData.filter(
          (game) => game.GameID == gameId
        )[0];

        const status = specificGame.Status;
        const homeTeamScore = specificGame.HomeTeamScore;
        const awayTeamScore = specificGame.AwayTeamScore;

        const pointSpread = pointSpreadAssign(
          specificGame.PointSpread,
          ncaafBet.betTeam
        );
        if (status == "Postponed" || status == "Canceled") {
          // Update Bet
          ncaafBet.isClosed = null;
          data.bets[index] = ncaafBet;
          betListUpdateBatch.update(betRef, data);

          return "cancelled" as string;
        } else {
          if (homeTeamScore != null && awayTeamScore != null) {
            const gameNumber =
              ncaafBet.betType == "pointspread"
                ? pointSpread
                : specificGame.OverUnder;

            const totalGameScore = homeTeamScore + awayTeamScore;

            const finalWinTeam = whichTeamWin(
              homeTeamScore,
              awayTeamScore,
              ncaafBet.betType,
              gameNumber,
              ncaafBet.betTeam
            );
            const finalWinTeamName =
              finalWinTeam == "away"
                ? specificGame.AwayTeam
                : specificGame.HomeTeam;
            const isWin = ncaafBet.betTeam == finalWinTeam;

            // Update Bet
            ncaafBet.isClosed = true;
            ncaafBet.homeTeamScore = homeTeamScore;
            ncaafBet.awayTeamScore = awayTeamScore;
            finalWinTeamName != null
              ? (ncaafBet.winningTeamName = finalWinTeamName)
              : finalWinTeamName;
            ncaafBet.totalGameScore = totalGameScore;
            ncaafBet.winningTeam = finalWinTeam;
            data.bets[index] = ncaafBet;
            betListUpdateBatch.update(betRef, data);

            return isWin ? ("won" as string) : ("lose" as string);
          } else {
            return "null" as string;
          }
        }
      } else if (league == "mlb") {
        const mlbBet: MlbBet = bet as MlbBet;

        const apikey = whichKey(league);
        const gameId = mlbBet.gameId;

        const apiData = await axios
          .get(
            `https://fly.sportsdata.io/v3/${league}/scores/json/GamesByDate/${dateTime}`,
            {
              params: {
                key: apikey,
              },
            }
          )
          .catch(function (error: any) {
            console.log(error);
          });

        const jsonData: MlbGame[] = apiData["data"];
        const specificGame = jsonData.filter(
          (game) => game.GameID == gameId
        )[0];

        const status = specificGame.Status;
        const homeTeamScore = specificGame.HomeTeamRuns;
        const awayTeamScore = specificGame.AwayTeamRuns;

        const pointSpread = pointSpreadAssign(
          specificGame.PointSpread,
          mlbBet.betTeam
        );
        if (status == "Postponed" || status == "Canceled") {
          // Update Bet
          mlbBet.isClosed = null;
          data.bets[index] = mlbBet;
          betListUpdateBatch.update(betRef, data);

          return "cancelled" as string;
        } else {
          if (homeTeamScore != null && awayTeamScore != null) {
            const gameNumber =
              mlbBet.betType == "pointspread"
                ? pointSpread
                : specificGame.OverUnder;

            const totalGameScore = homeTeamScore + awayTeamScore;

            const finalWinTeam = whichTeamWin(
              homeTeamScore,
              awayTeamScore,
              mlbBet.betType,
              gameNumber,
              mlbBet.betTeam
            );
            const finalWinTeamName =
              finalWinTeam == "away"
                ? specificGame.AwayTeam
                : specificGame.HomeTeam;
            const isWin = mlbBet.betTeam == finalWinTeam;

            // Update Bet
            mlbBet.isClosed = true;
            mlbBet.homeTeamScore = homeTeamScore;
            mlbBet.awayTeamScore = awayTeamScore;
            finalWinTeamName != null
              ? (mlbBet.winningTeamName = finalWinTeamName)
              : finalWinTeamName;
            mlbBet.totalGameScore = totalGameScore;
            mlbBet.winningTeam = finalWinTeam;
            data.bets[index] = mlbBet;
            betListUpdateBatch.update(betRef, data);

            return isWin ? ("won" as string) : ("lose" as string);
          } else {
            return "null" as string;
          }
        }
      } else if (league == "nba") {
        const nbaBet: NbaBet = bet as NbaBet;

        const apikey = whichKey(league);
        const gameId = nbaBet.gameId;

        const apiData = await axios
          .get(
            `https://fly.sportsdata.io/v3/${league}/scores/json/GamesByDate/${dateTime}`,
            {
              params: {
                key: apikey,
              },
            }
          )
          .catch(function (error: any) {
            console.log(error);
          });

        const jsonData: NbaGame[] = apiData["data"];
        const specificGame = jsonData.filter(
          (game) => game.GameID == gameId
        )[0];

        const status = specificGame.Status;
        const homeTeamScore = specificGame.HomeTeamScore;
        const awayTeamScore = specificGame.AwayTeamScore;

        const pointSpread = pointSpreadAssign(
          specificGame.PointSpread,
          nbaBet.betTeam
        );
        if (status == "Postponed" || status == "Canceled") {
          // Update Bet
          nbaBet.isClosed = null;
          data.bets[index] = nbaBet;
          betListUpdateBatch.update(betRef, data);

          return "cancelled" as string;
        } else {
          if (homeTeamScore != null && awayTeamScore != null) {
            const gameNumber =
              nbaBet.betType == "pointspread"
                ? pointSpread
                : specificGame.OverUnder;

            const totalGameScore = homeTeamScore + awayTeamScore;

            const finalWinTeam = whichTeamWin(
              homeTeamScore,
              awayTeamScore,
              nbaBet.betType,
              gameNumber,
              nbaBet.betTeam
            );
            const finalWinTeamName =
              finalWinTeam == "away"
                ? specificGame.AwayTeam
                : specificGame.HomeTeam;
            const isWin = nbaBet.betTeam == finalWinTeam;

            // Update Bet
            nbaBet.isClosed = true;
            nbaBet.homeTeamScore = homeTeamScore;
            nbaBet.awayTeamScore = awayTeamScore;
            finalWinTeamName != null
              ? (nbaBet.winningTeamName = finalWinTeamName)
              : finalWinTeamName;
            nbaBet.totalGameScore = totalGameScore;
            nbaBet.winningTeam = finalWinTeam;
            data.bets[index] = nbaBet;
            betListUpdateBatch.update(betRef, data);

            return isWin ? ("won" as string) : ("lose" as string);
          } else {
            return "null" as string;
          }
        }
      } else if (league == "nhl") {
        const nhlBet: NhlBet = bet as NhlBet;

        const apikey = whichKey(league);
        const gameId = nhlBet.gameId;

        const apiData = await axios
          .get(
            `https://fly.sportsdata.io/v3/${league}/scores/json/ScoresByDate/${dateTime}`,
            {
              params: {
                key: apikey,
              },
            }
          )
          .catch(function (error: any) {
            console.log(error);
          });

        const jsonData: NhlGame[] = apiData["data"];
        const specificGame = jsonData.filter(
          (game) => game.GameID == gameId
        )[0];

        const status = specificGame.Status;
        const homeTeamScore = specificGame.HomeTeamScore;
        const awayTeamScore = specificGame.AwayTeamScore;

        const pointSpread = pointSpreadAssign(
          specificGame.PointSpread,
          nhlBet.betTeam
        );
        if (status == "Postponed" || status == "Canceled") {
          // Update Bet
          nhlBet.isClosed = null;
          data.bets[index] = nhlBet;
          betListUpdateBatch.update(betRef, data);

          return "cancelled" as string;
        } else {
          if (homeTeamScore != null && awayTeamScore != null) {
            const gameNumber =
              nhlBet.betType == "pointspread"
                ? pointSpread
                : specificGame.OverUnder;

            const totalGameScore = homeTeamScore + awayTeamScore;

            const finalWinTeam = whichTeamWin(
              homeTeamScore,
              awayTeamScore,
              nhlBet.betType,
              gameNumber,
              nhlBet.betTeam
            );
            const finalWinTeamName =
              finalWinTeam == "away"
                ? specificGame.AwayTeam
                : specificGame.HomeTeam;
            const isWin = nhlBet.betTeam == finalWinTeam;

            // Update Bet
            nhlBet.isClosed = true;
            nhlBet.homeTeamScore = homeTeamScore;
            nhlBet.awayTeamScore = awayTeamScore;
            finalWinTeamName != null
              ? (nhlBet.winningTeamName = finalWinTeamName)
              : finalWinTeamName;
            nhlBet.totalGameScore = totalGameScore;
            nhlBet.winningTeam = finalWinTeam;
            data.bets[index] = nhlBet;
            betListUpdateBatch.update(betRef, data);

            return isWin ? ("won" as string) : ("lose" as string);
          } else {
            return "null" as string;
          }
        }
      } else if (league == "cbb") {
        const ncaabBet: NcaabBet = bet as NcaabBet;

        const apikey = whichKey(league);
        const gameId = ncaabBet.gameId;

        const apiData = await axios
          .get(
            `https://fly.sportsdata.io/v3/${league}/scores/json/GamesByDate/${dateTime}`,
            {
              params: {
                key: apikey,
              },
            }
          )
          .catch(function (error: any) {
            console.log(error);
          });

        const jsonData: NcaabGame[] = apiData["data"];
        const specificGame = jsonData.filter(
          (game) => game.GameID == gameId
        )[0];

        const status = specificGame.Status;
        const homeTeamScore = specificGame.HomeTeamScore;
        const awayTeamScore = specificGame.AwayTeamScore;

        const pointSpread = pointSpreadAssign(
          specificGame.PointSpread,
          ncaabBet.betTeam
        );
        if (status == "Postponed" || status == "Canceled") {
          // Update Bet
          ncaabBet.isClosed = null;
          data.bets[index] = ncaabBet;
          betListUpdateBatch.update(betRef, data);

          return "cancelled" as string;
        } else {
          if (homeTeamScore != null && awayTeamScore != null) {
            const gameNumber =
              ncaabBet.betType == "pointspread"
                ? pointSpread
                : specificGame.OverUnder;

            const totalGameScore = homeTeamScore + awayTeamScore;

            const finalWinTeam = whichTeamWin(
              homeTeamScore,
              awayTeamScore,
              ncaabBet.betType,
              gameNumber,
              ncaabBet.betTeam
            );
            const finalWinTeamName =
              finalWinTeam == "away"
                ? specificGame.AwayTeam
                : specificGame.HomeTeam;
            const isWin = ncaabBet.betTeam == finalWinTeam;

            // Update Bet
            ncaabBet.isClosed = true;
            ncaabBet.homeTeamScore = homeTeamScore;
            ncaabBet.awayTeamScore = awayTeamScore;
            finalWinTeamName != null
              ? (ncaabBet.winningTeamName = finalWinTeamName)
              : finalWinTeamName;
            ncaabBet.totalGameScore = totalGameScore;
            ncaabBet.winningTeam = finalWinTeam;
            data.bets[index] = ncaabBet;
            betListUpdateBatch.update(betRef, data);

            return isWin ? ("won" as string) : ("lose" as string);
          } else {
            return "null" as string;
          }
        }
      } else {
        console.log("Undefined Bet Type");
        return "cancelled" as string;
      }
    })
  );

  console.log(betList);

  if (betList.includes("null")) {
    console.log("Not updated yet!");
  } else {
    const betRef = admin.firestore().collection("bets").doc(documentId);
    const walletRef =
      week == getCurrentWeek()
        ? admin.firestore().collection("wallets").doc(uid)
        : admin
            .firestore()
            .collection("leaderboard")
            .doc("global")
            .collection("weeks")
            .doc(week)
            .collection("wallets")
            .doc(uid);
    if (betList.includes("cancelled")) {
      betListUpdateBatch.update(betRef, {
        isClosed: null,
      });

      betListUpdateBatch.set(
        cumulativeVaultRef,
        {
          moneyIn: admin.firestore.FieldValue.increment(-amountBet),
          totalBets: admin.firestore.FieldValue.increment(-1),
        },
        { merge: true }
      );

      betListUpdateBatch.set(
        dailyVaultRef,
        {
          moneyIn: admin.firestore.FieldValue.increment(-amountBet),
          totalBets: admin.firestore.FieldValue.increment(-1),
        },
        { merge: true }
      );

      betListUpdateBatch.update(walletRef, {
        totalOpenBets: admin.firestore.FieldValue.increment(-1),

        accountBalance: admin.firestore.FieldValue.increment(amountBet),
        pendingRiskedAmount: admin.firestore.FieldValue.increment(-amountBet),
        potentialWinAmount: admin.firestore.FieldValue.increment(-amountWin),
      });

      await betListUpdateBatch.commit();
    } else {
      if (betList.includes("lose")) {
        // Loss
        betListUpdateBatch.update(betRef, {
          isClosed: true,
        });

        betListUpdateBatch.update(walletRef, {
          totalOpenBets: admin.firestore.FieldValue.increment(-1),
          totalLoss: admin.firestore.FieldValue.increment(amountBet),
          totalBetsLost: admin.firestore.FieldValue.increment(1),
          potentialWinAmount: admin.firestore.FieldValue.increment(-amountWin),
          pendingRiskedAmount: admin.firestore.FieldValue.increment(-amountBet),
        });

        await betListUpdateBatch.commit();
      } else {
        // Win
        betListUpdateBatch.update(betRef, {
          isClosed: true,
        });

        betListUpdateBatch.update(walletRef, {
          totalOpenBets: admin.firestore.FieldValue.increment(-1),
          totalProfit: admin.firestore.FieldValue.increment(amountWin),
          accountBalance: admin.firestore.FieldValue.increment(totalWinAmount),
          pendingRiskedAmount: admin.firestore.FieldValue.increment(-amountBet),
          totalBetsWon: admin.firestore.FieldValue.increment(1),
          potentialWinAmount: admin.firestore.FieldValue.increment(-amountWin),
        });

        betListUpdateBatch.set(
          cumulativeVaultRef,
          {
            moneyOut: admin.firestore.FieldValue.increment(totalWinAmount),
          },
          { merge: true }
        );

        betListUpdateBatch.set(
          dailyVaultRef,
          {
            moneyOut: admin.firestore.FieldValue.increment(totalWinAmount),
          },
          { merge: true }
        );

        await betListUpdateBatch.commit();
      }
    }
  }
}
