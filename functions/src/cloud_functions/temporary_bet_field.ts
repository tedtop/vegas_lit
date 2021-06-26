// import * as functions from "firebase-functions";
// import * as admin from "firebase-admin";
// import moment = require("moment-timezone");

// export const betField = functions.https.onRequest(async (req, res) => {
//   await admin
//     .firestore()
//     .collection("bets")
//     .get()
//     .then((snapshots) => {
//       const promises: any = [];
//       snapshots.docs.map(async (element) => {
//         const week = getCurrentWeekByDate(element.data().gameStartDateTime);
//         const promise = await element.ref.set({ week: week }, { merge: true });
//         promises.push(promise);
//       });
//       return Promise.all(promises);
//     });

//   res.send("Done");

//   // Get current week in format
//   function getCurrentWeekByDate(date: Date): string {
//     const currentDate = moment(date);
//     if (currentDate.day() <= 3) {
//       const todayWeekNumber = currentDate.format("w");
//       const todayWeekFormat = currentDate.format("YYYY");
//       const weekFormatFirst = Number.parseInt(todayWeekNumber) - 1;
//       const weekFormatSecond = Number.parseInt(todayWeekNumber);
//       const leaderboardWeekName = `${todayWeekFormat}-${weekFormatFirst}-${weekFormatSecond}`;
//       return leaderboardWeekName;
//     } else {
//       const todayWeekNumber = currentDate.format("w");
//       const todayWeekFormat = currentDate.format("YYYY");
//       const weekFormatFirst = Number.parseInt(todayWeekNumber);
//       const weekFormatSecond = Number.parseInt(todayWeekNumber) + 1;
//       const leaderboardWeekName = `${todayWeekFormat}-${weekFormatFirst}-${weekFormatSecond}`;
//       return leaderboardWeekName;
//     }
//   }
// });
