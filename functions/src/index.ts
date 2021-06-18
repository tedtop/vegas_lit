import * as admin from "firebase-admin";

import * as slack from "./cloud_functions/slack";
import * as bets from "./cloud_functions/bets";
import * as leaderboard from "./cloud_functions/leaderboard";
import * as contestWeek from "./cloud_functions/contest_week";
import * as bet from "./cloud_functions/temporary_bet_field";

admin.initializeApp();

export const sendBetCreatedToSlack = slack.sendBetCreatedToSlack;
export const resolveBets = bets.resolveBets;
export const rankLeaderboard = leaderboard.rankLeaderboard;
export const resetContestWeek = contestWeek.resetContestWeek;
export const betField = bet.betField;
