import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
const axios = require("axios").default;
import moment = require("moment-timezone");

var app = admin.initializeApp();

export const resolveBets = functions.pubsub
  .schedule("every 4 hours")
  .onRun(async (context) => {
    console.log("This will be run every 6 hours!");
    await app
      .firestore()
      .collection("open_bets")
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
              const homeTeamScore = specificGame.HomeTeamScore;
              const awayTeamScore = specificGame.AwayTeamScore;
              let finalWinTeam: string;
              if (isClosed != isClosedFirestore) {
                if (homeTeamScore != null && awayTeamScore != null) {
                  finalWinTeam =
                    homeTeamScore > awayTeamScore ? "home" : "away";

                  functions.logger.log(isClosed);
                  const betsRef = await app
                    .firestore()
                    .collection("open_bets")
                    .doc(documentId)
                    .update({
                      isClosed: isClosed,
                      homeTeamScore: homeTeamScore,
                      awayTeamScore: awayTeamScore,
                      finalWinTeam: finalWinTeam,
                    });
                  return betsRef;
                }
              }

              functions.logger.log("Value Already Updated");
              return null;
            })
            .catch(function (error: any) {
              console.log(error);
              return null;
            })
            .then(function () {
              functions.logger.info(`${league} API Call Completed!`, {
                structuredData: true,
              });
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
        functions.logger.info("Function Completed!", { structuredData: true });
        return null;
      });

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
