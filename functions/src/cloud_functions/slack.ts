import * as functions from "firebase-functions";

const IncomingWebhook = require("@slack/client").IncomingWebhook;
const url =
  "https://hooks.slack.com/services/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";
const webhook = new IncomingWebhook(url);

export const sendBetCreatedToSlack = functions.firestore
  .document("bets/{docId}")
  .onCreate(async (snapshot, context) => {
    const data = snapshot.data();

    const teamCity =
      data.betTeam == "away" ? data.awayTeamCity : data.homeTeamCity;
    const teamName =
      data.betTeam == "away" ? data.awayTeamName : data.homeTeamName;
    const msg = `:slot_machine: *${data.username}* placed a $${data.betAmount} ${data.betType} bet on the ${teamCity} ${teamName}`;

    await sendMessageToSlack(msg);
    return true;
  });

export async function sendMessageToSlack(message: any) {
  console.log("Slack: ", message);

  await webhook.send(
    message,
    function (err: any, header: any, statusCode: any, body: any) {
      if (err) {
        console.log("Error: ", err);
      } else {
        console.log("Received ", statusCode, " from Slack");
      }
    }
  );
}
