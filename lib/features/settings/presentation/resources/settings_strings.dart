class SettingsStrings {
  static const SettingsStrings instance = SettingsStrings._internal();

  const SettingsStrings._internal();

  String get areYouSure => 'Você tem certeza?';
  String get excludeAccountDescription =>
      'Tem certeza de que deseja excluir sua conta? Essa ação é permanente e resultará na exclusão de seus dados, incluindo históricos de serviços.';
  String get delete => 'Deletar';
  String get settings => 'Configuração';
  String get account => 'Conta';
  String get excludeAccount => 'Excluir conta';
  String get youHaveAvailablePlans =>
      'Parece que você tem assinaturas disponíveis!\nPor favor, cancele os planos disponíveis antes de deletar sua conta e evite cobranças indevidas';
}
