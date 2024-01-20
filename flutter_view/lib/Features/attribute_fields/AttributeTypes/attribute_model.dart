import 'dart:ffi';
import 'dart:io';

import 'package:Folder_Struct_Maker/utils/get_user_name.dart';
import 'package:dart_casing/dart_casing.dart';
import 'package:flutter/material.dart';
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

///Common Date formats
///
///Depending on the application, custom date formats can be used, like MMM DD, YYYY (e.g., Jan 07, 2022) or YYYY/MM/DD.
///
enum DateFormats {
  standard(
    name: 'Standard',
    format: 'yyyy-MM-dd',
    description: 'ISO 8601 (International Standard)',
  ),

  short(
    name: 'Short',
    format: 'MM/dd/yyyy',
    description: 'Short Date',
  ),
  long(
    name: 'Long',
    format: 'MMM-dd-yyyy',
    description: 'Long Date',
  ),
  dateTime(
    name: 'Date Time (RFC2822)',
    format: 'E-d-MMM-yyyy-H:m:s',
    description: 'RFC 2822',
  ),
  sortable(
    name: 'Sortable',
    format: 'yyyy-MM-ddTHH:mm:ss',
    description: 'Sortable Format',
  ),
  unix(
    name: 'Unix',
    format: '',
  ),
  utcTimestamp(name: 'UTC Timestamp', format: 'yyyy-MM-DDTHH:mm:ss.sssZ'),
  longYearMonthDay(name: 'Year Month Day Long', format: 'yyyy-MM-DD'),
  shortYearMontDay(name: 'Year Month Day Short', format: 'yy-MM-DD'),
  monthDayYearLong(name: 'Month Day Year Long', format: 'MM-DD-yyyy'),
  monthDayYearShort(name: 'Month Day Year Short', format: 'MM-DD-yy'),
  dayMonthYearShort(name: 'Day Month Year Short', format: 'DD-MM-yy'),
  dayMonthYearLong(name: 'Day Month Year Long', format: 'DD-MM-yyyy'),
  yearMonth(name: 'Year Month', format: 'yyyy-MM'),
  dayMonthNameYear(name: 'Day Month Name Year', format: 'DD-EEE-yyyy'),
  dayMonthAbbrYear(name: 'Day Abbreviated Month  Year', format: 'DD-E-yyyy'),
  monthAbbrYear(name: 'Abbreviated Month  Year', format: 'Eyyyy'),
  custom(name: 'Custom', format: '');

  final String name;
  final String? description;
  final String format;
  const DateFormats(
      {required this.name, required this.format, this.description});

  String get value {
    return format;
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

  DateFormats dateFormatType = DateFormats.monthAbbrYear;

  DateFormat get dateFormat => DateFormat(dateFormatType.value, 'en_US');

  @override
  String toString() {
    return dateFormat.format(value).toString();
  }

  @override
  void changeValue(String val) {
    value = dateFormat.parse(val);
  }

  String now() {
    final DateTime now = DateTime.now();
    return dateFormat.format(now);
  }

  void changeDateFormat(DateFormats format) {
    dateFormatType = format;
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

class UserNameAttribute<T extends String> extends Attribute<String> {
  UserNameAttribute({
    required super.id,
    required super.name,
  }) : super(type: AttributeType.User_Name, defaultValue: '', value: '') {
    defaultValue = Platform.isWindows
        ? getUsernameWindows()
        : Platform.isMacOS
            ? getHostName()
            : Platform.localHostname;
    value = defaultValue;
  }

  @override
  String toString() {
    return value;
  }

  @override
  void changeValue(String val) {
    throw Exception('Not implemented yet');
  }
}

void main() {
  print(attributeTypeList[0].name);
}
