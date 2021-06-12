import * as admin from "firebase-admin";

import * as slack from "./cloud_functions/slack";
import * as bets from "./cloud_functions/bets";
import * as leaderboard from "./cloud_functions/leaderboard";
import * as contestWeek from "./cloud_functions/contest_week";

admin.initializeApp();

export const sendBetCreatedToSlack= slack.sendBetCreatedToSlack;
export const resolveBets= bets.resolveBets;
export const rankLeaderboard = leaderboard.rankLeaderboard;
export const resetContestWeek = contestWeek.resetContestWeek;