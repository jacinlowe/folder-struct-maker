import 'package:intl/intl.dart';

String formatCurrency(double amount) {
  final fmt = NumberFormat("\$ #,##0.00", 'en_US');
  final result = fmt.format(amount);
  return result;
}
