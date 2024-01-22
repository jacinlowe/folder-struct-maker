import 'package:hive_flutter/hive_flutter.dart';

import '../models/attribute_model.dart';

class AttributeRepo {
  late Box<Attribute> _hive;
  late List<Attribute> _box;

  AttributeRepo();
  List<Attribute>? getAttributes() {
    _hive = Hive.box<Attribute>('attributes');
    if (_hive.isOpen) {
      _box = _hive.values.toList();
      return _box;
    }
    return null;
  }

  List<Attribute> addAttribute(Attribute attribute) {
    _hive.add(attribute);
    _box = _hive.values.toList();
    return _box;
  }

  void removeAttribute(int index) {
    _hive.deleteAt(index);
  }

  void deleteAll() {
    _box.clear();
  }

  void updateAttribute(int index,
      {String? value, String? defaultValue, String? name}) {
    final attr = _hive.getAt(index);
    if (attr == null) throw HiveAttributeNotFoundException();
    final tempState = _box.toList();

    if (value != null) {
      attr.updateValue(value);
    }
    if (defaultValue != null) {
      attr.updateDefaultValue(defaultValue);
    }
    if (name != null) {
      attr.updateName(name);
    }

    tempState.insert(index, attr);
  }

  void updateAttributes(List<Attribute> attributes) {
    _hive.clear();
    _hive.addAll(attributes);
    _box = _hive.values.toList();
  }
}

class HiveAttributeNotFoundException implements Exception {
  HiveAttributeNotFoundException();
  final String message = 'Cannot Find Attribute in box';
}
