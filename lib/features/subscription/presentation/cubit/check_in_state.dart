part of 'check_in_cubit.dart';

sealed class CheckInState extends Equatable {
  const CheckInState();

  @override
  List<Object> get props => [];
}

final class CheckInInitial extends CheckInState {}

final class CheckInSuccess extends CheckInState {}

final class CheckInError extends CheckInState {}
