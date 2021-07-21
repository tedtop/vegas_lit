part of 'olympics_add_cubit.dart';

enum OlympicsAddStatus { initial, loading, complete, error }

class OlympicsAddState extends Equatable {
  const OlympicsAddState({
    this.status = OlympicsAddStatus.initial,
  });

  final OlympicsAddStatus status;

  @override
  List<Object> get props => [status];
}
