part of 'bet_button_cubit.dart';

enum BetButtonStatus {
  loading,
  clicked,
  unclicked,
  placing,
  placed,
  alreadyPlaced
}

enum BetButtonWin { away, home }

class MlbBetButtonState extends Equatable {
  const MlbBetButtonState._({
    this.text,
    this.game,
    this.uniqueId,
    this.mainOdds,
    this.status = BetButtonStatus.loading,
    this.betType,
    this.betAmount = 100,
    this.toWinAmount,
    this.awayTeamData,
    this.spread,
    this.uid,
    this.league,
    this.homeTeamData,
    this.winTeam,
  });

  const MlbBetButtonState.loading() : this._();

  const MlbBetButtonState.placing({
    @required String text,
    @required MlbGame game,
    @required String uniqueId,
    @required String league,
    @required double spread,
    @required MlbTeam awayTeamData,
    @required MlbTeam homeTeamData,
    @required int betAmount,
    @required int toWinAmount,
    @required String uid,
    @required BetButtonWin winTeam,
    @required String mainOdds,
    @required Bet betType,
  }) : this._(
          status: BetButtonStatus.placing,
          text: text,
          game: game,
          uniqueId: uniqueId,
          winTeam: winTeam,
          homeTeamData: homeTeamData,
          uid: uid,
          betAmount: betAmount,
          toWinAmount: toWinAmount,
          spread: spread,
          awayTeamData: awayTeamData,
          mainOdds: mainOdds,
          league: league,
          betType: betType,
        );

  const MlbBetButtonState.clicked({
    @required String text,
    @required MlbGame game,
    @required String uniqueId,
    @required String league,
    @required double spread,
    @required MlbTeam awayTeamData,
    @required MlbTeam homeTeamData,
    @required int betAmount,
    @required int toWinAmount,
    @required String uid,
    @required BetButtonWin winTeam,
    @required String mainOdds,
    @required Bet betType,
  }) : this._(
          status: BetButtonStatus.clicked,
          text: text,
          game: game,
          uniqueId: uniqueId,
          winTeam: winTeam,
          homeTeamData: homeTeamData,
          uid: uid,
          betAmount: betAmount,
          toWinAmount: toWinAmount,
          spread: spread,
          awayTeamData: awayTeamData,
          mainOdds: mainOdds,
          league: league,
          betType: betType,
        );

  const MlbBetButtonState.unclicked(
      {@required String text,
      @required MlbGame game,
      @required String uniqueId,
      @required String mainOdds,
      @required double spread,
      @required BetButtonWin winTeam,
      @required int betAmount,
      @required int toWinAmount,
      @required String uid,
      @required MlbTeam awayTeamData,
      @required String league,
      @required MlbTeam homeTeamData,
      @required Bet betType})
      : this._(
            status: BetButtonStatus.unclicked,
            text: text,
            game: game,
            uniqueId: uniqueId,
            mainOdds: mainOdds,
            homeTeamData: homeTeamData,
            uid: uid,
            spread: spread,
            betAmount: betAmount,
            toWinAmount: toWinAmount,
            league: league,
            winTeam: winTeam,
            awayTeamData: awayTeamData,
            betType: betType);

  const MlbBetButtonState.placed({
    @required String text,
    @required MlbGame game,
    @required String mainOdds,
    @required MlbTeam awayTeamData,
    @required MlbTeam homeTeamData,
    @required double spread,
    @required String league,
    @required String uid,
    @required BetButtonWin winTeam,
    @required int betAmount,
    @required int toWinAmount,
    @required String uniqueId,
    @required Bet betType,
  }) : this._(
          status: BetButtonStatus.placed,
          text: text,
          game: game,
          league: league,
          uniqueId: uniqueId,
          winTeam: winTeam,
          betAmount: betAmount,
          toWinAmount: toWinAmount,
          spread: spread,
          uid: uid,
          homeTeamData: homeTeamData,
          awayTeamData: awayTeamData,
          mainOdds: mainOdds,
          betType: betType,
        );

  const MlbBetButtonState.alreadyPlaced({
    @required String text,
    @required MlbGame game,
    @required String mainOdds,
    @required MlbTeam awayTeamData,
    @required MlbTeam homeTeamData,
    @required String uid,
    @required int betAmount,
    @required int toWinAmount,
    @required double spread,
    @required String league,
    @required BetButtonWin winTeam,
    @required String uniqueId,
    @required Bet betType,
  }) : this._(
          status: BetButtonStatus.alreadyPlaced,
          text: text,
          game: game,
          league: league,
          uniqueId: uniqueId,
          winTeam: winTeam,
          spread: spread,
          betAmount: betAmount,
          toWinAmount: toWinAmount,
          uid: uid,
          homeTeamData: homeTeamData,
          awayTeamData: awayTeamData,
          mainOdds: mainOdds,
          betType: betType,
        );

  final BetButtonStatus status;
  final String text;
  final MlbGame game;
  final String uniqueId;
  final Bet betType;
  final String mainOdds;
  final double spread;
  final MlbTeam awayTeamData;
  final String league;
  final String uid;
  final int betAmount;
  final int toWinAmount;
  final MlbTeam homeTeamData;
  final BetButtonWin winTeam;

  @override
  List<Object> get props => [
        status,
        text,
        league,
        winTeam,
        betAmount,
        toWinAmount,
        spread,
        game,
        uniqueId,
        betType,
        uid,
        mainOdds,
        awayTeamData,
        homeTeamData
      ];

  MlbBetButtonState copyWith({
    BetButtonStatus status,
    String text,
    MlbGame game,
    String uniqueId,
    Bet betType,
    String mainOdds,
    double spread,
    MlbTeam awayTeamData,
    String league,
    String uid,
    int betAmount,
    int toWinAmount,
    MlbTeam homeTeamData,
    BetButtonWin winTeam,
  }) {
    return MlbBetButtonState._(
      status: status ?? this.status,
      text: text ?? this.text,
      game: game ?? this.game,
      uniqueId: uniqueId ?? this.uniqueId,
      betType: betType ?? this.betType,
      mainOdds: mainOdds ?? this.mainOdds,
      spread: spread ?? this.spread,
      awayTeamData: awayTeamData ?? this.awayTeamData,
      league: league ?? this.league,
      uid: uid ?? this.uid,
      betAmount: betAmount ?? this.betAmount,
      toWinAmount: toWinAmount ?? this.toWinAmount,
      homeTeamData: homeTeamData ?? this.homeTeamData,
      winTeam: winTeam ?? this.winTeam,
    );
  }
}
