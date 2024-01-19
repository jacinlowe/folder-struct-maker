import 'dart:ffi';

import 'package:dart_casing/dart_casing.dart';
import 'package:intl/intl.dart';

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

sealed class Attribute<T> {
  String id;
  String name;
  AttributeType type;
  T defaultValue;
  T value;
  bool saveHistory = true;
  bool folderBreak = false;
  bool useInPath = true;
  bool locked = false;
  bool required = false;

  Attribute(
      {required this.id,
      required this.name,
      required this.type,
      required this.defaultValue,
      required this.value});

  @override
  String toString();
  void changeValue(String val);

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

  void changeDefaultValue(T value) {
    //TODO implement some checks here
    defaultValue = value;
  }

  void changeName(String name) {
    // TODO: implement some checks here
    name = name;
  }
}

class DateAttribute<T extends DateTime> extends Attribute<DateTime> {
  DateAttribute({
    required super.id,
    required super.name,
  }) : super(
            type: AttributeType.Date,
            defaultValue: DateTime.now(),
            value: DateTime.now());

  @override
  AttributeType get type => AttributeType.Date;

  final String dateFormat = 'yyyy-MM-dd';
  @override
  String toString() {
    return value.toString();
  }

  @override
  void changeValue(String val) {
    value = DateTime.parse(val);
  }

  String now() {
    final DateTime now = DateTime.now();
    final DateFormat format = DateFormat(dateFormat);
    return format.format(now);
  }

  void changeDateFormat() {
    throw UnimplementedError('Have not created the enums for this yet');
  }
}

class CustomTextAttribute<T extends String> extends Attribute<String> {
  CustomTextAttribute({
    required super.id,
    required super.name,
  }) : super(type: AttributeType.Custom_Text, defaultValue: '', value: '');

  @override
  String toString() {
    return value;
  }

  @override
  void changeValue(String val) {
    value = val;
  }
}

class NumberAttribute<T extends num> extends Attribute<num> {
  NumberAttribute({required super.id, required super.name})
      : super(type: AttributeType.Number, defaultValue: 1, value: 1);

  NumberFormat padding = NumberFormat('0000');

  @override
  AttributeType get type => AttributeType.Number;

  late bool autoIncrement = false;
  @override
  String toString() {
    final paddedResult = padding.format(value);
    return paddedResult.toString();
  }

  void changeAutoIncrement() {
    autoIncrement = !autoIncrement;
  }

  void increment() {
    value++;
  }

  @override
  void changeValue(String val) {
    final convertedValue = int.tryParse(val);
    if (convertedValue != null) {
      value = convertedValue;
    } else {
      throw Exception('Not a number: Please enter a number');
    }
  }
}

class DropdownAttribute<T extends String> extends Attribute<String> {
  List<String>? selectableItems;
  String? selectedItem;
  DropdownAttribute(this.selectableItems,
      {required super.id, required super.name})
      : super(type: AttributeType.Dropdown, defaultValue: '', value: '') {
    this.selectableItems = [];
    this.selectedItem = null;
  }
  @override
  String toString() {
    return value;
  }

  @override
  void changeValue(String val) {
    if (selectableItems!.contains(val)) {
      selectedItem = val;
      value = selectedItem!;
    } else {
      throw Exception('Not a valid selection');
    }
  }

  void addSelectableItem(String val) {
    if (selectableItems!.contains(val)) {
      throw Exception('Item already exists');
    } else {
      selectableItems!.add(val);
    }
  }

  void updateSelectableItem(String previousVal, String val) {
    if (!selectableItems!.contains(previousVal)) {
      throw Exception('Item doesnt exists');
    } else {
      final index = selectableItems!.indexOf(previousVal);
      selectableItems![index] = val;
    }
  }

  void removeSelectableItem(int? index, String? val) {
    if (index == null && val == null) {
      throw Exception('Please provide either an index or a value');
    } else if (index != null) {
      if (index > selectableItems!.length) {
        throw Exception('Index out of bounds');
      } else {
        selectableItems!.removeAt(index);
      }
    } else if (val != null) {
      if (selectableItems!.contains(val)) {
        selectableItems!.remove(val);
      } else {
        throw Exception('Item doesnt exist');
      }
    }
  }
}

void main() {
  print(attributeTypeList[0].name);
}
