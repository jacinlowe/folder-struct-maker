import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import 'attribute_model.dart';
import 'date_enums.dart';

class DateAttribute extends Attribute<DateTime> {
  DateTime _internalValue;
  DateTime _internalDefaultValue;

  DateAttribute({
    required DateTime internalValue,
    required DateTime internalDefaultValue,
    required String super.id,
    required String super.name,
    required AttributeProperties super.properties,
  })  : _internalValue = internalValue,
        _internalDefaultValue = internalDefaultValue,
        super(type: AttributeType.Date);

  @override
  String get defaultValue =>
      dateFormat.format(_internalDefaultValue).toString();

  @override
  String get value => dateFormat.format(_internalValue).toString();

  @override
  AttributeType get type => AttributeType.Date;

  DateFormats dateFormatType = DateFormats.monthAbbrYear;

  DateFormat get dateFormat => DateFormat(dateFormatType.value, 'en_US');

  @override
  String toString() {
    final Set res = {
      name,
      id,
      value,
      defaultValue,
      type,
      dateFormatType,
      properties.toMap()
    };
    return res.toString();
  }

  String now() {
    final DateTime now = DateTime.now();
    return dateFormat.format(now);
  }

  void changeDateFormat(DateFormats format) {
    dateFormatType = format;
  }

  @override
  void updateDefaultValue(DateTime newDefaultValue) {
    _internalDefaultValue = newDefaultValue;
  }

  @override
  void updateValue(DateTime newValue) {
    _internalValue = newValue;
  }
}
