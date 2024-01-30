// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../Features/attribute_fields/models/username_attribute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNameAttribute _$UserNameAttributeFromJson(Map<String, dynamic> json) =>
    UserNameAttribute(
      id: json['id'] as String,
      name: json['name'] as String,
      properties: AttributeProperties.fromJson(
          json['properties'] as Map<String, dynamic>),
    )..type = $enumDecode(_$AttributeTypeEnumMap, json['type']);

Map<String, dynamic> _$UserNameAttributeToJson(UserNameAttribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$AttributeTypeEnumMap[instance.type]!,
      'properties': instance.properties.toJson(),
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
