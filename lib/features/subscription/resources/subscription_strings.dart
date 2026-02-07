import 'package:substore_app/shared/extensions/date_time_extensions.dart';

class SubscriptionStrings {
  static const SubscriptionStrings instance = SubscriptionStrings._internal();

  const SubscriptionStrings._internal();

  String get select => 'Selecionar';
  String get available => 'Disponível';
  String get done => 'Concluído';
  String get expired => 'Expirado';
  String get prizeExpired => 'prazo expirado';
  String get checkIn => 'Check-in';
  String get about => 'Sobre';
  String get otherPlans => 'Outros Planos';
  String get knowMore => 'Saber Mais';
  String get cancelSubscription => 'Cancelar Assinatura';
  String get emptyTicketsMessage => 'Não existem tickets por aqui';
  String get cancelPlanUrl => 'https://wa.me/5512997288855?text=Olá%20gostaria%20de%20cancelar%20meu%20plano%20';
  String get knowMoreUrl => 'https://wa.me/5512997288855?text=Olá%20gostaria%20de%20saber%20mais%20sobre%20o%20plano%20';
  String get checkInSuccess => 'Check-In Realizado com sucesso!';
  String get checkInError => 'Ocorreu um erro ao realizar o Check-In';
  String expiresIn(DateTime? expireDate) => expireDate != null ? 'Válido até: ${expireDate.toFormattedDate()}' : '';
  String expiredIn(DateTime? expireDate) => expireDate != null ? 'Expirado em: ${expireDate.toFormattedDate()}' : '';
}
