// import * as functions from "firebase-functions";
// import * as admin from "firebase-admin";

// export const rankLeaderboard = functions.pubsub
//   .schedule("1 * * * *")
//   .timeZone("America/New_York")
//   .onRun(async (context) => {
//     await admin
//       .firestore()
//       .collection("wallets")
//       .where("totalBets", ">=", 5)
//       .get()
//       .then(async function (snapshots) {
//         let rankNumber = 1;
//         const documents = snapshots.docs.sort((a, b) => {
//           const firstData = a.data();
//           const secondData = b.data();
//           if (
//             firstData.accountBalance + firstData.pendingRiskedAmount >
//             secondData.accountBalance + secondData.pendingRiskedAmount
//           )
//             return -1;
//           if (
//             firstData.accountBalance + firstData.pendingRiskedAmount <
//             secondData.accountBalance + secondData.pendingRiskedAmount
//           )
//             return 1;
//           if (firstData.totalBets > secondData.totalBets) return -1;
//           if (firstData.totalBets < secondData.totalBets) return 1;
//           return 0;
//         });
//         for (const document of documents) {
//           await document.ref.update({ rank: rankNumber });
//           rankNumber++;
//         }
//       })
//       .catch(function (error: any) {
//         console.log(error);
//       });
//   });
