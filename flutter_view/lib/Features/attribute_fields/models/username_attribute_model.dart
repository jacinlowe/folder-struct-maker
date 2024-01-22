import 'dart:io';

import '../../../utils/get_user_name.dart';
import 'attribute_model.dart';

class UserNameAttribute extends Attribute<String> {
  final String _internalValue;
  final String _internalDefaultValue;

  UserNameAttribute({
    required super.id,
    required super.name,
    required AttributeProperties super.properties,
  })  : _internalDefaultValue = getUserName(),
        _internalValue = getUserName(),
        super(type: AttributeType.User_Name);

  @override
  String toString() {
    return value;
  }

  @override
  String get defaultValue => _internalDefaultValue;

  @override
  void updateDefaultValue(String newDefaultValue) {
    throw UnimplementedError();
  }

  @override
  void updateValue(String newValue) {
    throw UnimplementedError();
  }

  @override
  String get value => _internalValue;
}

String getUserName() {
  return Platform.isWindows
      ? getUsernameWindows()
      : Platform.isMacOS
          ? getHostName()
          : Platform.localHostname;
}
