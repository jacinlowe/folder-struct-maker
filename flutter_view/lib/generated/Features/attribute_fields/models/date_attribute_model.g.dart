// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../Features/attribute_fields/models/date_attribute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateAttribute _$DateAttributeFromJson(Map<String, dynamic> json) =>
    DateAttribute(
      internalValue: DateTime.parse(json['internalValue'] as String),
      internalDefaultValue:
          DateTime.parse(json['internalDefaultValue'] as String),
      id: json['id'] as String,
      name: json['name'] as String,
      properties: AttributeProperties.fromJson(
          json['properties'] as Map<String, dynamic>),
    )
      ..type = $enumDecode(_$AttributeTypeEnumMap, json['type'])
      ..dateFormatType =
          $enumDecode(_$DateFormatsEnumMap, json['dateFormatType']);

Map<String, dynamic> _$DateAttributeToJson(DateAttribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'properties': instance.properties.toJson(),
      'internalValue': instance.internalValue.toIso8601String(),
      'internalDefaultValue': instance.internalDefaultValue.toIso8601String(),
      'type': _$AttributeTypeEnumMap[instance.type]!,
      'dateFormatType': _$DateFormatsEnumMap[instance.dateFormatType]!,
    };

const _$AttributeTypeEnumMap = {
  AttributeType.Custom_Text: 'Custom Text',
  AttributeType.Number: 'Number',
  AttributeType.Dropdown: 'Dropdown',
  AttributeType.Saveable_Field: 'Saveable Field',
  AttributeType.User_Name: 'Username',
  AttributeType.Date: 'Date',
  AttributeType.Loop: 'Loop',
  AttributeType.Custom_Delimiter: 'Custom Delimiter',
};

const _$DateFormatsEnumMap = {
  DateFormats.standard: 'Standard',
  DateFormats.short: 'Short',
  DateFormats.long: 'Long',
  DateFormats.dateTime: 'Date Time (RFC2822)',
  DateFormats.sortable: 'Sortable',
  DateFormats.unix: 'Unix',
  DateFormats.utcTimestamp: 'UTC Timestamp',
  DateFormats.longYearMonthDay: 'Year Month Day Long',
  DateFormats.shortYearMontDay: 'Year Month Day Short',
  DateFormats.monthDayYearLong: 'Month Day Year Long',
  DateFormats.monthDayYearShort: 'Month Day Year Short',
  DateFormats.dayMonthYearShort: 'Day Month Year Short',
  DateFormats.dayMonthYearLong: 'Day Month Year Long',
  DateFormats.yearMonth: 'Year Month',
  DateFormats.dayMonthNameYear: 'Day Month Name Year',
  DateFormats.dayMonthAbbrYear: 'Day Abbreviated Month  Year',
  DateFormats.monthAbbrYear: 'Abbreviated Month  Year',
  DateFormats.custom: 'Custom',
};
