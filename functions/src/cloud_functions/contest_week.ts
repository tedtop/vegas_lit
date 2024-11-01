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
              const batch = admin.firestore().batch();

              // For every document, save it to today's date document in leaderboard
              const leaderboardWeekRef = admin
                .firestore()
                .collection("leaderboard")
                .doc("global")
                .collection("weeks")
                .doc(documentName)
                .collection("wallets")
                .doc(element.id);
              batch.set(leaderboardWeekRef, element.data());
              // After saving, reset that specific user wallet
              const userWalletRef = admin
                .firestore()
                .collection("wallets")
                .doc(element.id);
              batch.update(userWalletRef, {
                totalProfit: 0,
                accountBalance: 1000,
                totalBetsWon: 0,
                totalBetsLost: 0,
                totalLoss: 0,
                totalBets: 0,
                todayRewards: 0,
                rank: 0,
                pendingRiskedAmount: 0,
                totalRewards: 0,
                totalOpenBets: 0,
                totalRiskedAmount: 0,
                potentialWinAmount: 0,
              });
              const promise = await batch.commit();

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
      const currentDate = moment().tz("America/New_York");
      if (currentDate.day() <= 3) {
        const todayWeekNumber = currentDate.format("w");
        const todayWeekFormat = currentDate.format("YYYY");
        const weekFormatFirst = Number.parseInt(todayWeekNumber) - 1;
        const weekFormatSecond = Number.parseInt(todayWeekNumber);
        const leaderboardWeekName = `${todayWeekFormat}-${weekFormatFirst}-${weekFormatSecond}`;
        return leaderboardWeekName;
      } else {
        const todayWeekNumber = currentDate.format("w");
        const todayWeekFormat = currentDate.format("YYYY");
        const weekFormatFirst = Number.parseInt(todayWeekNumber);
        const weekFormatSecond = Number.parseInt(todayWeekNumber) + 1;
        const leaderboardWeekName = `${todayWeekFormat}-${weekFormatFirst}-${weekFormatSecond}`;
        return leaderboardWeekName;
      }
    }
  });
