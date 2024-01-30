import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

import 'attribute_model.dart';
import 'date_enums.dart';

part '../../../generated/Features/attribute_fields/models/date_attribute_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DateAttribute extends Attribute<DateTime> {
  DateTime internalValue;

  DateTime internalDefaultValue;

  DateAttribute({
    required this.internalValue,
    required this.internalDefaultValue,
    required String id,
    required String name,
    required AttributeProperties properties,
  }) :
        // internalValue = DateTime.now(),
        //       internalDefaultValue = DateTime.now(),
        super(
            id: id,
            name: name,
            properties: properties,
            type: AttributeType.Date);
  @override
  factory DateAttribute.fromJson(Map<String, dynamic> json) =>
      _$DateAttributeFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DateAttributeToJson(this);

  @override
  String get defaultValue => dateFormat.format(internalDefaultValue).toString();

  @override
  String get value => dateFormat.format(internalValue).toString();

  @override
  AttributeType get type => AttributeType.Date;

  DateFormats dateFormatType = DateFormats.monthAbbrYear;

  DateFormat get dateFormat => DateFormat(dateFormatType.value, 'en_US');

  @override
  String toString() {
    return value;
  }

  Set toMap() {
    final Set res = {
      name,
      id,
      value,
      defaultValue,
      type,
      dateFormatType,
      properties.toMap()
    };
    return res;
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
    internalDefaultValue = newDefaultValue;
  }

  @override
  void updateValue(DateTime newValue) {
    internalValue = newValue;
  }
}

void main() {
  final dateish = DateAttribute(
      internalValue: DateTime.now(),
      internalDefaultValue: DateTime.now(),
      id: 'id',
      name: 'name',
      properties: AttributeProperties());
  print(dateish.toJson());
}
