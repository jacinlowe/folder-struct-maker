import 'attribute_model.dart';

class TextAttribute extends Attribute<String> {
  String _internalValue;
  String _internalDefaultValue;

  TextAttribute({
    required String internalValue,
    required String internalDefaultValue,
    required super.id,
    required super.name,
    required super.properties,
  })  : _internalValue = internalValue,
        _internalDefaultValue = internalDefaultValue,
        super(type: AttributeType.Custom_Text);

  @override
  String toString() {
    return value;
  }

  @override
  String get defaultValue => _internalDefaultValue;

  @override
  void updateDefaultValue(String newDefaultValue) {
    _internalDefaultValue = newDefaultValue;
  }

  @override
  void updateValue(String newValue) {
    _internalValue = newValue;
  }

  @override
  String get value => _internalValue;
}
