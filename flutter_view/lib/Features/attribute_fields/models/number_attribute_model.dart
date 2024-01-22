import 'package:intl/intl.dart';

import 'attribute_model.dart';

const MAX_PADDING = 10;

class NumberAttribute extends Attribute<num> {
  num _internalValue;
  num _internalDefaultValue;
  bool autoIncrement = false;

  NumberAttribute(
      {required num internalValue,
      required num internalDefaultValue,
      required super.id,
      required super.name,
      required super.properties})
      : _internalDefaultValue = internalDefaultValue,
        _internalValue = internalValue,
        super(type: AttributeType.Number);

  NumberFormat padding = NumberFormat('0000');

  @override
  String get value => padding.format(_internalValue).toString();

  @override
  String get defaultValue => padding.format(_internalDefaultValue).toString();

  @override
  String toString() {
    return value;
  }

  void changeAutoIncrement() {
    autoIncrement = !autoIncrement;
  }

  void updatePaddingFormat(String pad) {
    RegExp regex = RegExp('^0{1,$MAX_PADDING}\$');
    if (!regex.hasMatch(pad)) {
      throw Exception('Invalid padding format');
    }
    padding = NumberFormat(pad);
  }

  void increment() {
    _internalValue++;
  }

  @override
  void updateDefaultValue(num newDefaultValue) {
    _internalDefaultValue = newDefaultValue;
  }

  @override
  void updateValue(num newValue) {
    _internalValue = newValue;
  }
}
