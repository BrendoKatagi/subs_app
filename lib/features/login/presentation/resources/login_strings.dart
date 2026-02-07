class LoginStrings {
  static const LoginStrings instance = LoginStrings._internal();

  const LoginStrings._internal();

  String get login => 'Login';
  String get email => 'E-mail';
  String get password => 'Senha';
  String get loginButton => 'Entrar';
  String get signIn => 'Cadastrar';
  String get signInDivider => ' | ';
  String get forgotMyPassword => 'Esqueci minha senha';
  String get loginError => 'Erro ao realizar o seu login';
  String get pleaseEnterYourEmail => 'Por favor, insira seu email';
  String get invalidEmail => 'Email inválido';
  String get pleaseEnterYourPassword => 'Por favor, insira sua senha';
  String get invalidPassword =>
      'Senha inválida, sua senha deve conter:\n- Pelo menos uma letra minúscula.\n- Pelo menos uma letra maiúscula.\n- Pelo menos um número.\n- Pelo menos um caractere especial\n- Pelo menos 8 caracteres no total';
  String get resetPasswordError => 'Erro ao enviar email para recuperação de senha';
  String get updatePasswordError => 'Erro ao atualizar senha';
  String get resetPasswordSuccess => 'Email enviado com sucesso';
  String get changePassword => 'Redefinir senha';
  String get changePasswordTitle => 'Esqueci minha senha:';
  String get changePasswordDescription => 'Insira seu email cadastrado para enviarmos o link de recuperação';
  String get newPassword => 'Nova senha';
  String get confirmPassword => 'Confirme sua senha';
  String get confirmationPasswordDoNotMatch => 'As senhas não coincidem';
  String get updatePassword => 'Atualizar senha';
  String get loginCredentialsError => 'Email ou Senha incorretos. Tente novamente';
  String get loginRequestPath => '/auth/login';
}
