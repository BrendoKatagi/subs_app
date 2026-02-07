class ProfileStrings {
  static const ProfileStrings instance = ProfileStrings._internal();

  const ProfileStrings._internal();

  String get aboutYou => 'Sobre você';
  String get settings => 'Configurações';
  String get personalData => 'Dados cadastrais';
  String get changePassword => 'Trocar senha';
  String get logout => 'Sair';
}
