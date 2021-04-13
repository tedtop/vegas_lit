import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
const axios = require('axios').default;
import moment = require('moment-timezone');

var app = admin.initializeApp();

export const resolveBets = functions.pubsub.schedule('every 12 hours').onRun(async (context) => {
    console.log('This will be run every 12 hours!');
    await app.firestore().collection("open_bets").where('isClosed', '==', false).get().then(function (snapshots) {
        const promises: any = [];

        snapshots.docs.forEach(async document => {
            const data = document.data();

            const dateTime = formatTime(data.dateTime);
            const league = data.league;
            const isClosedFirestore = data.isClosed;
            const apikey = whichKey(league);
            const gameId = data.gameId;
            const documentId = data.id;

            const promise = axios.get(`https://fly.sportsdata.io/v3/${league}/scores/json/GamesByDate/${dateTime}`, {
                params: {
                    'key': apikey
                }
            })
                .then(async function (data: any) {
                    const jsonData = data['data'];
                    const isClosed = whichGame(gameId, jsonData);
                    console.log(isClosed);

                    if (isClosed == isClosedFirestore) {
                        console.log('Value Already Updated');
                        return null;
                    } else {
                        const betsRef = await app.firestore().collection("open_bets").doc(documentId).update({ isClosed: isClosed });
                        return betsRef;
                    }


                })
                .catch(function (error: any) {
                    console.log(error);
                })
                .then(function () {
                    functions.logger.info("NBA API Call Completed!", { structuredData: true });
                });

            promises.push(promise);
        });

        return Promise.all(promises);
    }).catch(function (error: any) {
        console.log(error);
    }).then(function () {
        return null;
    });


    function formatTime(dateTime: string): string {
        const d = new Date(dateTime);
        const myDatetimeFormat = "yyyy-MMM-DD";
        return moment(d).format(myDatetimeFormat);
    }

    function whichKey(league: string): string {
        switch (league) {
            case 'nba':
                return 'edf27d79dc564a1d9b5eccff1e64dc56';
                break;
            case 'mlb':
                return 'edd8f1c800b846b3af060bf0e5606fb5';
                break;
            case 'nhl':
                return 'c624a2d014d6487aa12ec67df73632cd';
                break;
            case 'ccb':
                return 'ddae36a8fd5842b7be6f8b9309f5c91f';
                break;
            default:
                return '';
                break;
        }
    }

    function whichGame(gameId: string, jsonData: any): boolean {
        for (var i = 0, l = jsonData.length; i < l; i++) {
            if (jsonData[i]['GameID'] === gameId) {
                return jsonData[i]['IsClosed'];
            }
        }
        return false;
    }

});