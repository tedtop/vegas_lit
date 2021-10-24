// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
//  
// import 'package:vegas_lit/config/enum.dart';
// import 'package:flutter/material.dart';
// import 'package:vegas_lit/features/sportsbook/models/team.dart';



// part 'cricket_bet_button_state.dart';

// class BetButtonCubit extends Cubit<BetButtonState> {
//   BetButtonCubit()
//       : super(
//           const BetButtonState.loading(),
//         );

//   // void openBetButton(
//   //     {@required String text,
//   //     @required Bet betType,
//   //     @required String mainOdds,
//   //     @required int gameId,
//   //     @required bool isClosed,
//   //     @required awayTeamData,
//   //     @required String league,
//   //     @required homeTeamData,
//   //     @required CricketDatum game}) {
//   //   final uniqueId = const Uuid().v1();
//   //   emit(
//   //     BetButtonState.unclicked(
//   //       text: text,
//   //       gameId: gameId,
//   //       isClosed: isClosed,
//   //       awayTeamData: awayTeamData,
//   //       homeTeamData: homeTeamData,
//   //       uniqueId: uniqueId,
//   //       league: league,
//   //       betType: betType,
//   //       mainOdds: mainOdds,
//   //     ),
//   //   );
//   // }

//   void clickBetButton() {
//     emit(
//       BetButtonState.clicked(
//           text: state.text,
//           isClosed: state.isClosed,
//           gameId: state.gameId,
//           game: state.game,
//           uniqueId: state.uniqueId,
//           awayTeamData: state.awayTeamData,
//           league: state.league,
//           homeTeamData: state.homeTeamData,
//           mainOdds: state.mainOdds,
//           betType: state.betType),
//     );
//   }

//   void unclickBetButton() {
//     emit(
//       BetButtonState.unclicked(
//           text: state.text,
//           mainOdds: state.mainOdds,
//           game: state.game,
//           league: state.league,
//           isClosed: state.isClosed,
//           gameId: state.gameId,
//           awayTeamData: state.awayTeamData,
//           homeTeamData: state.homeTeamData,
//           uniqueId: state.uniqueId,
//           betType: state.betType),
//     );
//   }

//   void confirmBetButton() {
//     emit(
//       BetButtonState.done(
//           text: state.text,
//           game: state.game,
//           mainOdds: state.mainOdds,
//           isClosed: state.isClosed,
//           gameId: state.gameId,
//           league: state.league,
//           awayTeamData: state.awayTeamData,
//           homeTeamData: state.homeTeamData,
//           uniqueId: state.uniqueId,
//           betType: state.betType),
//     );
//   }
// }
