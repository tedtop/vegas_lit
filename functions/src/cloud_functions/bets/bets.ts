import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { NflResolve } from "./bets_resolve/nfl_resolve";
import { NflBet } from "./models/bets/nfl_bet";
import { NcaafBet } from "./models/bets/cfb_bet";
import { NcaafResolve } from "./bets_resolve/cfb_resolve";
import { MlbBet } from "./models/bets/mlb_bet";
import { MlbResolve } from "./bets_resolve/mlb_resolve";
import { NbaBet } from "./models/bets/nba_bet";
import { NbaResolve } from "./bets_resolve/nba_resolve";
import { NhlResolve } from "./bets_resolve/nhl_resolve";
import { NhlBet } from "./models/bets/nhl_bet";
import { NcaabResolve } from "./bets_resolve/cbb_resolve";
import { NcaabBet } from "./models/bets/cbb_bet";
import { rankLeaderboard } from "./rank_leaderboard";
import { Bet } from "./models/bets/bet";
import { ParalympicsBet } from "./models/bets/paralympics_bet";
import { ParalympicsResolve } from "./bets_resolve/paralympics_resolve";
import { ParlayBet } from "./models/bets/parlay_bet";
import { ParlayResolve } from "./bets_resolve/parlay_resolve";

export const resolveBets = functions.pubsub
  .schedule("*/30 * * * *")
  .timeZone("America/New_York")
  .onRun(async (context) => {
    await admin
      .firestore()
      .collection("bets")
      .where("isClosed", "==", false)
      .get()
      .then(async function (snapshots) {
        await Promise.all(
          snapshots.docs.map(async (bet) => {
            const data: Bet = bet.data() as Bet;
            const league = data.league.toLowerCase();

            // if (league == "olympics") {
            //   const olympicsBet: OlympicsBet = data as OlympicsBet;
            //   await OlympicsResolve(olympicsBet);
            // } else
            if (league == "nfl") {
              const nflBet: NflBet = data as NflBet;
              await NflResolve(nflBet);
            } else if (league == "cfb") {
              const ncaafBet: NcaafBet = data as NcaafBet;
              await NcaafResolve(ncaafBet);
            } else if (league == "mlb") {
              const mlbBet: MlbBet = data as MlbBet;
              await MlbResolve(mlbBet);
            } else if (league == "nba") {
              const nbaBet: NbaBet = data as NbaBet;
              await NbaResolve(nbaBet);
            } else if (league == "nhl") {
              const nhlBet: NhlBet = data as NhlBet;
              await NhlResolve(nhlBet);
            } else if (league == "cbb") {
              const ncaabBet: NcaabBet = data as NcaabBet;
              await NcaabResolve(ncaabBet);
            } else if (league == "paralympics" || league == "olympics") {
              const paralympicsBet: ParalympicsBet = data as ParalympicsBet;
              await ParalympicsResolve(paralympicsBet);
            } else if (league == "parlay") {
              const parlayBet: ParlayBet = data as ParlayBet;
              await ParlayResolve(parlayBet);
            } else {
              console.log("Undefined Bet Type");
            }
          })
        );
      })
      .catch(function (error: any) {
        console.log(error);
      })
      .then(async function () {
        await rankLeaderboard();
      });

    return true;
  });
