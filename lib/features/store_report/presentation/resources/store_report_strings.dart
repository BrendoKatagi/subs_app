import 'package:substore_app/features/store_report/domain/entities/plans_active.dart';

class StoreReportStrings {
  static const StoreReportStrings instance = StoreReportStrings._internal();
  const StoreReportStrings._internal();

  String get tickets => 'Bilhetes:';
  String ticketsTypeCount(ActivePlan activePlan) =>
      'Disponíves: ${activePlan.available}  |  Utilizados: ${activePlan.done}  |  Expirados: ${activePlan.expired} ';
  String get reportLoadErrorTitle => 'Erro ao obter dados';
  String get reportLoadErrorDescription => 'Ocorreu um erro ao obter os dados\nPor favor, tente novamente mais tarde.';
  String get invalidDataErrorTitle => 'Dados inválidos';
  String get invalidDataErrorDescription => 'Por favor, verifique se você tem acesso aos dados solicitados, ou tente novamente mais tarde.';
}
