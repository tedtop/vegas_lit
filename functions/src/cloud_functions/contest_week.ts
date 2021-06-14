import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import moment = require("moment-timezone");

export const resetContestWeek = functions.pubsub
  .schedule("58 23 * * 3")
  .timeZone("America/New_York")
  .onRun(async (context) => {
    console.log("This function will be run every saturday at 11:58 PM!");

    const documentName = getCurrentWeek();

    // Fetching user's wallet
    await admin
      .firestore()
      .collection("wallets")
      .where("totalBets", ">", 0)
      .get()
      .then(async (snapshots) => {
        // Create today's date document in leaderboard
        await admin
          .firestore()
          .collection("leaderboard")
          .doc("global")
          .collection("weeks")
          .doc(documentName)
          .set({ isArchived: true })
          .then((_) => {
            const promises: any = [];
            // Run loop over all user's wallet document
            snapshots.docs.map(async (element) => {
              // For every document, save it to today's date document in leaderboard
              const promise = await admin
                .firestore()
                .collection("leaderboard")
                .doc("global")
                .collection("weeks")
                .doc(documentName)
                .collection("wallets")
                .doc(element.id)
                .set(element.data())
                .then(async (_) => {
                  // After saving, reset that specific user wallet
                  await admin
                    .firestore()
                    .collection("wallets")
                    .doc(element.id)
                    .update({
                      totalProfit: 0,
                      accountBalance: 1000,
                      totalBetsWon: 0,
                      totalBetsLost: 0,
                      totalLoss: 0,
                      totalBets: 0,
                      rank: 0,
                      pendingRiskedAmount: 0,
                      totalRewards: 0,
                      totalOpenBets: 0,
                      totalRiskedAmount: 0,
                      potentialWinAmount: 0,
                    });
                });
              promises.push(promise);
            });
            return Promise.all(promises);
          });
      })
      .catch(function (error: any) {
        console.log(error);
      })
      .then(() => {
        functions.logger.info("Leaderboard Resolved!", {
          structuredData: true,
        });
      });

    return null;

    function getCurrentWeek(): string {
      let today = new Date();
      const weekNextFormat = moment(today).format("w");
      const nextWeekFormatInteger = Number.parseInt(weekNextFormat) + 1;
      const walletsDayFormat = "YYYY-w";
      const weekFormat = moment(today).format(walletsDayFormat);
      const fullData = `${weekFormat}-${nextWeekFormatInteger}`;
      return fullData;
    }
  });

// export const resetContestDay = functions.pubsub
//   .schedule("59 23 * * *")
//   .timeZone("America/New_York")
//   .onRun(async (context) => {
//     console.log("This function will be run everyday at 11:59 PM!");

//     const documentName = getTodayDate();

//     // Fetching user's wallet
//     await app
//       .firestore()
//       .collection("wallets")
//       .get()
//       .then(async (snapshots) => {
//         // Create today's date document in leaderboard
//         await app
//           .firestore()
//           .collection("leaderboard")
//           .doc(documentName)
//           .set({ isArchived: true })
//           .then((_) => {
//             const promises: any = [];
//             // Run loop over all user's wallet document
//             snapshots.docs.map(async (element) => {
//               // For every document, save it to today's date document in leaderboard
//               const promise = await app
//                 .firestore()
//                 .collection("leaderboard")
//                 .doc(documentName)
//                 .collection("wallets")
//                 .doc(element.id)
//                 .set(element.data())
//                 .then(async (_) => {
//                   // After saving, reset that specific user wallets
//                   await app
//                     .firestore()
//                     .collection("wallets")
//                     .doc(element.id)
//                     .update({
//                       totalProfit: 0,
//                       accountBalance: 1000,
//                       totalBetsWon: 0,
//                       totalBetsLost: 0,
//                       totalLoss: 0,
//                       totalBets: 0,
//                       totalOpenBets: 0,
//                       totalRiskedAmount: 0,
//                       potentialWinAmount: 0,
//                     });
//                 });
//               promises.push(promise);
//             });
//             return Promise.all(promises);
//           });
//       })
//       .catch(function (error: any) {
//         console.log(error);
//       })
//       .then(() => {
//         functions.logger.info("Leaderboard Resolved!", {
//           structuredData: true,
//         });
//       });

//     return null;

//     function getTodayDate(): string {
//       let today = new Date();
//       const walletsDayFormat = "YYYY-MM-DD";
//       const todayFormat = moment(today).format(walletsDayFormat);
//       return todayFormat;
//     }
//   });
