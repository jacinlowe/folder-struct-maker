import 'package:json_annotation/json_annotation.dart';

import 'attribute_model.dart';

part '../../../generated/Features/attribute_fields/models/text_attribute_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TextAttribute extends Attribute<String> {
  String internalValue;
  String internalDefaultValue;

  TextAttribute({
    required String this.internalValue,
    required String this.internalDefaultValue,
    required super.id,
    required super.name,
    required super.properties,
  }) : super(type: AttributeType.Custom_Text);

  factory TextAttribute.fromJson(Map<String, dynamic> json) =>
      _$TextAttributeFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TextAttributeToJson(this);

  @override
  String toString() {
    return value;
  }

  @override
  String get defaultValue => internalDefaultValue;

  @override
  void updateDefaultValue(String newDefaultValue) {
    internalDefaultValue = newDefaultValue;
  }

  @override
  void updateValue(String newValue) {
    internalValue = newValue;
  }

  @override
  String get value => internalValue;
}
