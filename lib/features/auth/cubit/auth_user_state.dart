import 'package:equatable/equatable.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';

class AuthUserState extends Equatable {
  const AuthUserState();

  @override
  List<Object?> get props => [];
}

class AuthUserStateInitial extends AuthUserState {
  const AuthUserStateInitial();
}

class AuthUserStateNotLogged extends AuthUserState {
  const AuthUserStateNotLogged();
}

class AuthUserStateFailure extends AuthUserState {
  const AuthUserStateFailure();
}

class AuthUserStateLogged extends AuthUserState {
  final User user;

  const AuthUserStateLogged(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUserStateLoginLoading extends AuthUserState {
  const AuthUserStateLoginLoading();
}

class AuthUserStateLoginInvalid extends AuthUserState {
  final String? errorMessage;

  const AuthUserStateLoginInvalid(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class AuthUserStateLoginError extends AuthUserState {
  const AuthUserStateLoginError();
}

const loginStates = [
  AuthUserStateLogged,
  AuthUserStateLoginLoading,
  AuthUserStateLoginInvalid,
  AuthUserStateLoginError,
];

const authStates = [
  AuthUserStateNotLogged,
  AuthUserStateFailure,
  AuthUserStateLogged,
];
