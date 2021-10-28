

part of 'paralympics_add_cubit.dart';

enum ParalympicsAddStatus { initial, loading, complete, error }

class ParalympicsAddState extends Equatable {
  const ParalympicsAddState({
    this.status = ParalympicsAddStatus.initial,
  });

  final ParalympicsAddStatus status;

  @override
  List<Object> get props => [status];
}
