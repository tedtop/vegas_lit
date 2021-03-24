part of 'sportsbook_bloc.dart';

abstract class SportsbookEvent {
  const SportsbookEvent();
}

class SportsbookOpen extends SportsbookEvent {
  SportsbookOpen({@required this.gameName});
  final String gameName;
}
