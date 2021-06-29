import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const resetTodayRewards = functions.pubsub
  .schedule("0 0 * * *")
  .timeZone("America/New_York")
  .onRun(async (context) => {
    await admin
      .firestore()
      .collection("wallets")
      .where("todayRewards", ">", 0)
      .get()
      .then(async (snapshots) => {
        const promises: any = [];
        snapshots.docs.map(async (element) => {
          const batch = admin.firestore().batch();
          batch.update(element.ref, {
            todayRewards: 0,
          });
          const promise = await batch.commit();
          promises.push(promise);
        });
        return Promise.all(promises);
      })
      .catch(function (error: any) {
        console.log(error);
      })
      .then(() => {
        functions.logger.info("Today Ads Amount resetted to 0", {
          structuredData: true,
        });
      });

    return true;
  });
