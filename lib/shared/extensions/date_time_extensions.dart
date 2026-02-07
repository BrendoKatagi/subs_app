import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toFormattedString(String timeSeparator) => DateFormat('dd/MM/yyyy HH:mm').format(this).split(' ').join(' $timeSeparator ');
  String toFormattedDate() => DateFormat('dd/MM/yyyy').format(this);
}
