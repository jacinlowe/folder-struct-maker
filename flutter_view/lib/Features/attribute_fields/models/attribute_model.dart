import 'package:dart_casing/dart_casing.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/Features/attribute_fields/models/attribute_model.g.dart';

@JsonEnum(valueField: 'name')
enum AttributeType {
  Custom_Text(name: 'Custom Text'),
  Number(name: 'Number'),
  Dropdown(name: 'Dropdown'),
  Saveable_Field(name: 'Saveable Field'),
  User_Name(name: 'Username'),
  Date(name: 'Date'),
  Loop(name: 'Loop'),
  Custom_Delimiter(name: 'Custom Delimiter');

  final String name;
  const AttributeType({required this.name});

  String get readableName {
    return name;
  }
}

List<({String name, AttributeType type})> attributeTypeList = AttributeType
    .values
    .map((e) => (type: e, name: Casing.titleCase(e.name)))
    .toList();

@JsonSerializable()
class AttributeProperties {
  bool saveHistory;
  bool folderBreak;
  bool useInPath;
  bool locked;
  bool required;

  AttributeProperties(
      {this.saveHistory = true,
      this.folderBreak = false,
      this.useInPath = true,
      this.locked = false,
      this.required = false});

  factory AttributeProperties.fromJson(Map<String, dynamic> json) =>
      _$AttributePropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributePropertiesToJson(this);

  void changeSaveHistory() {
    saveHistory = !saveHistory;
  }

  void changeFolderBreak() {
    folderBreak = !folderBreak;
  }

  void changeUseInPath() {
    useInPath = !useInPath;
  }

  void changeLocked() {
    locked = !locked;
  }

  void changeRequired() {
    required = !required;
  }

  toMap() {
    return {
      'saveHistory': saveHistory,
      'folderBreak': folderBreak,
      'useInPath': useInPath,
      'locked': locked,
      'required': required
    };
  }

  toList() {
    return [saveHistory, folderBreak, useInPath, locked, required];
  }
}

abstract class Attribute<T> {
  late String id;
  late String name;
  late AttributeType type;
  late AttributeProperties properties;
  String get defaultValue;
  String get value;

  Attribute(
      {required this.id,
      required this.name,
      required this.type,
      required this.properties});

  void updateValue(T newValue);
  void updateDefaultValue(T newDefaultValue);
  void updateName(String newName) {
    name = newName;
  }

  Map<String, dynamic> toJson();

  @override
  String toString();

  // Adapt value to the appropriate type based on AttributeType
  dynamic adaptValue(dynamic value) {
    return switch (type) {
      AttributeType.Date => DateTime.parse(value.toString()),
      AttributeType.Number => double.parse(value),
      _ => value.toString(),
    };
  }
}
