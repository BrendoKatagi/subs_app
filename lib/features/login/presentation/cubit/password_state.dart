import 'package:equatable/equatable.dart';

sealed class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object> get props => [];
}

final class PasswordResetInitial extends PasswordState {
  const PasswordResetInitial();
}

final class PasswordResetSuccess extends PasswordState {
  const PasswordResetSuccess();
}

final class PasswordResetError extends PasswordState {
  const PasswordResetError();
}

final class PasswordUpdateError extends PasswordState {
  const PasswordUpdateError();
}

final class PasswordUpdateInvalidParams extends PasswordState {
  const PasswordUpdateInvalidParams();
}

final class PasswordResetLoading extends PasswordState {
  const PasswordResetLoading();
}
