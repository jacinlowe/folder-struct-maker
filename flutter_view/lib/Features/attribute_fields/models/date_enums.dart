import 'package:intl/intl.dart';

///Common Date formats
///
///Depending on the application, custom date formats can be used, like MMM DD, YYYY (e.g., Jan 07, 2022) or YYYY/MM/DD.
///

enum DateFormats {
  standard(
    name: 'Standard',
    format: 'yyyy-MM-dd',
    description: 'ISO 8601 (International Standard)',
  ),

  short(
    name: 'Short',
    format: 'MM/dd/yyyy',
    description: 'Short Date',
  ),

  long(
    name: 'Long',
    format: 'MMM-dd-yyyy',
    description: 'Long Date',
  ),

  dateTime(
    name: 'Date Time (RFC2822)',
    format: 'E-d-MMM-yyyy-H:m:s',
    description: 'RFC 2822',
  ),

  sortable(
    name: 'Sortable',
    format: 'yyyy-MM-ddTHH:mm:ss',
    description: 'Sortable Format',
  ),

  unix(
    name: 'Unix',
    format: '',
  ),

  utcTimestamp(name: 'UTC Timestamp', format: 'yyyy-MM-DDTHH:mm:ss.sssZ'),

  longYearMonthDay(name: 'Year Month Day Long', format: 'yyyy-MM-DD'),

  shortYearMontDay(name: 'Year Month Day Short', format: 'yy-MM-DD'),

  monthDayYearLong(name: 'Month Day Year Long', format: 'MM-DD-yyyy'),

  monthDayYearShort(name: 'Month Day Year Short', format: 'MM-DD-yy'),

  dayMonthYearShort(name: 'Day Month Year Short', format: 'DD-MM-yy'),

  dayMonthYearLong(name: 'Day Month Year Long', format: 'DD-MM-yyyy'),

  yearMonth(name: 'Year Month', format: 'yyyy-MM'),

  dayMonthNameYear(name: 'Day Month Name Year', format: 'DD-EEE-yyyy'),

  dayMonthAbbrYear(name: 'Day Abbreviated Month  Year', format: 'DD-E-yyyy'),

  monthAbbrYear(name: 'Abbreviated Month  Year', format: 'Eyyyy'),

  custom(name: 'Custom', format: '');

  final String name;
  final String? description;
  final String format;
  const DateFormats(
      {required this.name, required this.format, this.description});

  String get value {
    return format;
  }

  String get example {
    return DateFormat(format, "en_US").format(DateTime.now()).toString();
  }
}
