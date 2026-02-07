import 'package:intl/intl.dart';

extension IntExtensions on int {
  String toFormattedReais() {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: r'R$');
    return currencyFormat.format(this / 100);
  }
}
