class StoreStrings {
  static const StoreStrings instance = StoreStrings._internal();

  const StoreStrings._internal();

  String get checkIn => 'Check-in';
  String get support => 'Solicitar Suporte';
  String get scanCode => 'Escanear código';
  String get insertCode => 'Digitar código';
  String get checkInCode => 'Código do Check-in';
  String get send => 'Enviar';
  String get checkInSuccess => 'Check-in concluído com sucesso';
  String get checkInError => 'Erro ocorrido ou Check-in já efetuado';
  String get unexpectedError => 'Erro ocorrido tente novamente mais tarde';
  String get myCheckIns => 'Meus Check-ins';
  String get noCheckIns => 'Ainda não foram encontrados Check-ins';
  String get logout => 'Sair';
  String get supportUrl =>
      'https://wa.me/5512997288855?text=Olá%20gostaria%20de%20solicitar%20suporte%20para%20minha%20loja%20';
}
