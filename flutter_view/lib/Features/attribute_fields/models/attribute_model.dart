import 'package:dart_casing/dart_casing.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum AttributeType {
  Custom_Text,
  Number,
  Dropdown,
  Saveable_Field,
  User_Name,
  Date,
  Loop,
  Custom_Delimiter;

  String get readableName {
    switch (this) {
      case AttributeType.Custom_Text:
        return 'Custom Text';
      case AttributeType.Number:
        return 'Number';
      case AttributeType.Dropdown:
        return 'Dropdown';
      case AttributeType.Saveable_Field:
        return 'Saveable Field';
      case AttributeType.User_Name:
        return 'Username';
      case AttributeType.Date:
        return 'Date';
      case AttributeType.Loop:
        return 'Loop';
      case AttributeType.Custom_Delimiter:
        return 'Custom Delimiter';
    }
  }
}

List<({String name, AttributeType type})> attributeTypeList = AttributeType
    .values
    .map((e) => (type: e, name: Casing.titleCase(e.name)))
    .toList();

class AttributeProperties {
  bool saveHistory = true;
  bool folderBreak = false;
  bool useInPath = true;
  bool locked = false;
  bool required = false;

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
