// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../Features/attribute_fields/models/attribute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeProperties _$AttributePropertiesFromJson(Map<String, dynamic> json) =>
    AttributeProperties(
      saveHistory: json['saveHistory'] as bool? ?? true,
      folderBreak: json['folderBreak'] as bool? ?? false,
      useInPath: json['useInPath'] as bool? ?? true,
      locked: json['locked'] as bool? ?? false,
      required: json['required'] as bool? ?? false,
    );

Map<String, dynamic> _$AttributePropertiesToJson(
        AttributeProperties instance) =>
    <String, dynamic>{
      'saveHistory': instance.saveHistory,
      'folderBreak': instance.folderBreak,
      'useInPath': instance.useInPath,
      'locked': instance.locked,
      'required': instance.required,
    };
