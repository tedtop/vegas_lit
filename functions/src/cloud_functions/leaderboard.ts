import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const rankPreviousWeekLeaderboard = functions.pubsub
  .schedule("0 */3 * * THU")
  .timeZone("America/New_York")
  .onRun(async (context) => {
    const list = await admin
      .firestore()
      .collection("leaderboard")
      .doc("global")
      .collection("weeks")
      .get()
      .then(async (snapshots) => {
        return await Promise.all(
          snapshots.docs.map((element) => {
            return element.id;
          })
        );
      });

    await Promise.all(
      list.map(async (week) => {
        await admin
          .firestore()
          .collection("leaderboard")
          .doc("global")
          .collection("weeks")
          .doc(week)
          .collection("wallets")
          .where("totalBets", ">=", 5)
          .get()
          .then(async function (snapshots) {
            let rankNumber = 1;
            const documents = snapshots.docs.sort((a, b) => {
              const firstData = a.data();
              const secondData = b.data();
              if (
                firstData.accountBalance +
                  firstData.pendingRiskedAmount -
                  firstData.totalRewards >
                secondData.accountBalance +
                  secondData.pendingRiskedAmount -
                  secondData.totalRewards
              )
                return -1;
              if (
                firstData.accountBalance +
                  firstData.pendingRiskedAmount -
                  firstData.totalRewards <
                secondData.accountBalance +
                  secondData.pendingRiskedAmount -
                  secondData.totalRewards
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
      })
    );
    return true;
  });
