import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

exports.deleteUserData = functions.auth.user().onDelete(async (user) => {
  const newBatch = admin.firestore().batch();
  await admin
    .firestore()
    .collection("users")
    .doc(`${user.uid}`)
    .get()
    .then(async (snapshot) => {
      newBatch.delete(snapshot.ref);
    })
    .then(async (_) => {
      await admin
        .firestore()
        .collection("wallets")
        .doc(`${user.uid}`)
        .get()
        .then(async (snapshot) => {
          newBatch.delete(snapshot.ref);
        });

      await newBatch.commit();
    });

  await deleteBets(500);

  async function deleteBets(batchSize: number) {
    const query = admin
      .firestore()
      .collection("bets")
      .where("uid", "==", `${user.uid}`)
      .limit(batchSize);

    return new Promise((resolve, reject) => {
      deleteQueryBatch(admin.firestore(), query, resolve).catch(reject);
    });
  }

  async function deleteQueryBatch(
    db: FirebaseFirestore.Firestore,
    query: FirebaseFirestore.Query<FirebaseFirestore.DocumentData>,
    resolve: any
  ) {
    const snapshot = await query.get();

    const batchSize = snapshot.size;
    if (batchSize === 0) {
      // When there are no documents left, we are done
      resolve();
      return;
    }

    // Delete documents in a batch
    const batch = db.batch();
    snapshot.docs.forEach((doc) => {
      batch.delete(doc.ref);
    });
    await batch.commit();

    // Recurse on the next process tick, to avoid
    // exploding the stack.
    process.nextTick(() => {
      deleteQueryBatch(db, query, resolve);
    });
  }
});
