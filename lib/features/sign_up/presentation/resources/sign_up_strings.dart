class SignUpStrings {
  static const SignUpStrings instance = SignUpStrings._internal();

  const SignUpStrings._internal();

  String get signUpAction => 'Faça seu cadastro';
  String get nameAndSurname => 'Nome Sobrenome';
  String get cellphoneLabel => 'DDD + número do celular (somente números)';
  String get confirmYouPassword => 'Confirme sua Senha';
  String get defineYourPassword => 'Escolha sua senha';
  String get passwordRules =>
      'Deve conter pelo menos 1 caracter especial (exemplo: +@-_#*)\nDeve conter pelo menos 1 letra maiúscula\nDeve conter letras e números\nDeve conter ao menos 7 dígitos';
  String get invalidName => 'Nome inválido';
  String get invalidCpf => 'CPF inválido';
  String get invalidCellphone => 'Celular inválido';
  String get signUpError => 'Ocorreu um erro ao efetuar o seu cadastro';
  String get confirmationPasswordError => 'As senhas digitadas não coincidem';
  String formatCpf(String cpf) => '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}';
  String get registrationConcluded => 'Cadastro concluído!';
  String get nowYouCanAccess => 'Agora você já pode acessar o seu gerenciador de assinaturas.';
  String get loginAction => 'Fazer login';
  String get signUp => 'Cadastrar';
  String get alreadyRegistered => 'Já possuo login';
  String get almostThere => 'Estamos quase lá!';
  String get registerOrLogin => 'Agora é só finalizar o seu cadastro ou fazer o login para começar a usar.';
}
