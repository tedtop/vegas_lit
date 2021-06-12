import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const rankLeaderboard = functions.pubsub
.schedule("2 * * * *")
.timeZone("America/New_York")
.onRun(async (context) => {
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
          firstData.accountBalance + firstData.pendingRiskedAmount >
          secondData.accountBalance + secondData.pendingRiskedAmount
        )
          return -1;
        if (
          firstData.accountBalance + firstData.pendingRiskedAmount <
          secondData.accountBalance + secondData.pendingRiskedAmount
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

// exports.temporaryLeaderboard = functions.https.onRequest(async (req, res) => {
//   const documentName = getCurrentWeek();

//   // Fetching user's wallet
//   await admin
//     .firestore()
//     .collection("wallets")
//     .get()
//     .then(async (snapshots) => {
//       // Create today's date document in leaderboard
//       await admin
//         .firestore()
//         .collection("leaderboard")
//         .doc("global")
//         .collection("weeks")
//         .doc(documentName)
//         .set({ isArchived: true })
//         .then((_) => {
//           const promises: any = [];
//           // Run loop over all user's wallet document
//           snapshots.docs.map(async (element) => {
//             // For every document, save it to today's date document in leaderboard
//             const promise = await admin
//               .firestore()
//               .collection("leaderboard")
//               .doc("global")
//               .collection("weeks")
//               .doc(documentName)
//               .collection("wallets")
//               .doc(element.id)
//               .set(element.data());
//             promises.push(promise);
//           });
//           return Promise.all(promises);
//         });
//     })
//     .catch(function (error: any) {
//       console.log(error);
//     })
//     .then(() => {
//       functions.logger.info("Leaderboard Resolved!", {
//         structuredData: true,
//       });
//     });

//   res.send("Done");

//   function getCurrentWeek(): string {
//     let today = new Date();
//     const weekNextFormat = moment(today).format("w");
//     const nextWeekFormatInteger = Number.parseInt(weekNextFormat) + 1;
//     const walletsDayFormat = "YYYY-w";
//     const weekFormat = moment(today).format(walletsDayFormat);
//     const fullData = `${weekFormat}-${nextWeekFormatInteger}`;
//     return fullData;
//   }
// });

// exports.WeekChangeCheck = functions.https.onRequest(async (req, res) => {
//   var cool = isPreviousWeek("2021-06-04");
//   console.log(cool);

//   function isPreviousWeek(betPlacedTime: string): string {
//     const betPlacedDateWeekDay = moment(betPlacedTime)
//       .tz("America/New_York")
//       .weekday();

//     const nowWeekDay = moment().tz("America/New_York").weekday();

//     if (betPlacedDateWeekDay <= 3) {
//       if (nowWeekDay >= 4) {
//         return "leaderboard";
//       } else {
//         return "wallets";
//       }
//     } else {
//       if (nowWeekDay >= 4) {
//         return "wallets";
//       } else {
//         return "leaderboard";
//       }
//     }
//   }

//   res.send("Done");
// });
