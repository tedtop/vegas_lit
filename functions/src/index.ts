import * as admin from "firebase-admin";
import * as bets from "./cloud_functions/bets/bets";
import * as leaderboard from "./cloud_functions/leaderboard";
import * as contestWeek from "./cloud_functions/contest_week";
import * as todayRewards from "./cloud_functions/ads_reward";

admin.initializeApp();

export const resolveBets = bets.resolveBets;
export const rankLeaderboard = leaderboard.rankPreviousWeekLeaderboard;
export const resetContestWeek = contestWeek.resetContestWeek;
export const resetTodayRewards = todayRewards.resetTodayRewards;
