import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import 'attribute_model.dart';

part '../../../generated/Features/attribute_fields/models/number_attribute_model.g.dart';

const MAX_PADDING = 10;

@JsonSerializable(explicitToJson: true)
class NumberAttribute extends Attribute<num> {
  num internalValue;
  num internalDefaultValue;
  bool autoIncrement = false;

  NumberAttribute(
      {required this.internalValue,
      required this.internalDefaultValue,
      required super.id,
      required super.name,
      required super.properties})
      : super(type: AttributeType.Number);

  factory NumberAttribute.fromJson(Map<String, dynamic> json) =>
      _$NumberAttributeFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$NumberAttributeToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  NumberFormat padding = NumberFormat('0000');

  @override
  String get value => padding.format(internalValue).toString();

  @override
  String get defaultValue => padding.format(internalDefaultValue).toString();

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
    internalValue++;
  }

  @override
  void updateDefaultValue(num newDefaultValue) {
    internalDefaultValue = newDefaultValue;
  }

  @override
  void updateValue(num newValue) {
    internalValue = newValue;
  }
}
