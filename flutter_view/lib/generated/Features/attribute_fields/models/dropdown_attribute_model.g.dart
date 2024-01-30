// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../Features/attribute_fields/models/dropdown_attribute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DropdownAttribute _$DropdownAttributeFromJson(Map<String, dynamic> json) =>
    DropdownAttribute(
      (json['selectableItems'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      id: json['id'] as String,
      name: json['name'] as String,
      properties: AttributeProperties.fromJson(
          json['properties'] as Map<String, dynamic>),
    )
      ..type = $enumDecode(_$AttributeTypeEnumMap, json['type'])
      ..selectedItem = json['selectedItem'] as String?;

Map<String, dynamic> _$DropdownAttributeToJson(DropdownAttribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$AttributeTypeEnumMap[instance.type]!,
      'properties': instance.properties.toJson(),
      'selectableItems': instance.selectableItems,
      'selectedItem': instance.selectedItem,
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
