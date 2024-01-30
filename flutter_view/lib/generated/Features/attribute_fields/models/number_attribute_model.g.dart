// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../Features/attribute_fields/models/number_attribute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumberAttribute _$NumberAttributeFromJson(Map<String, dynamic> json) =>
    NumberAttribute(
      internalValue: json['internalValue'] as num,
      internalDefaultValue: json['internalDefaultValue'] as num,
      id: json['id'] as String,
      name: json['name'] as String,
      properties: AttributeProperties.fromJson(
          json['properties'] as Map<String, dynamic>),
    )
      ..type = $enumDecode(_$AttributeTypeEnumMap, json['type'])
      ..autoIncrement = json['autoIncrement'] as bool;

Map<String, dynamic> _$NumberAttributeToJson(NumberAttribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$AttributeTypeEnumMap[instance.type]!,
      'properties': instance.properties.toJson(),
      'internalValue': instance.internalValue,
      'internalDefaultValue': instance.internalDefaultValue,
      'autoIncrement': instance.autoIncrement,
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
