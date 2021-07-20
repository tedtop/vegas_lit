part of 'olympics_add_cubit.dart';

abstract class OlympicsAddState extends Equatable {
  const OlympicsAddState();

  @override
  List<Object> get props => [];
}

class OlympicsAddInitial extends OlympicsAddState {}

class OlympicsAddLoading extends OlympicsAddState {}

class OlympicsAddComplete extends OlympicsAddState {}
