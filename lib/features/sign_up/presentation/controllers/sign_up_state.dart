part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {
  const SignUpState();
}

final class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

final class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

final class SignUpSuccess extends SignUpState {
  const SignUpSuccess();
}

final class SignUpFailure extends SignUpState {
  final String? emailErrorMessage;
  final String? passwordErrorMessage;
  final String? nameErrorMessage;
  final String? cpfErrorMessage;
  final String? cellphoneErrorMessage;

  const SignUpFailure({
    required this.emailErrorMessage,
    required this.passwordErrorMessage,
    required this.nameErrorMessage,
    required this.cpfErrorMessage,
    required this.cellphoneErrorMessage,
  });

  SignUpFailure copyWith({
    String? emailErrorMessage,
    String? passwordErrorMessage,
    String? nameErrorMessage,
    String? cpfErrorMessage,
    String? cellphoneErrorMessage,
  }) =>
      SignUpFailure(
        emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
        passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
        nameErrorMessage: nameErrorMessage ?? this.nameErrorMessage,
        cpfErrorMessage: cpfErrorMessage ?? this.cpfErrorMessage,
        cellphoneErrorMessage: cellphoneErrorMessage ?? this.cellphoneErrorMessage,
      );
}

final class SignUpError extends SignUpState {
  const SignUpError();
}
