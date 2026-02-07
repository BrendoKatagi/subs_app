import 'package:intl/intl.dart';

extension DoubleExtensions on double {
  String toFormattedNumber() =>
      NumberFormat.decimalPattern('pt_BR').format(this);
}
