import 'package:uuid/uuid.dart';

import 'attribute_model.dart';
import 'date_attribute_model.dart';
import 'dropdown_attribute_model.dart';
import 'number_attribute_model.dart';
import 'text_attribute_model.dart';
import 'username_attribute_model.dart';

Attribute attributeFactory(AttributeType attribute, String name) {
  String uuid = const Uuid().v4();
  switch (attribute) {
    case AttributeType.Date:
      return DateAttribute(
          id: uuid,
          name: name,
          internalValue: DateTime.now(),
          internalDefaultValue: DateTime.now(),
          properties: AttributeProperties());
    case AttributeType.Number:
      return NumberAttribute(
          id: uuid,
          name: name,
          internalValue: 1,
          internalDefaultValue: 1,
          properties: AttributeProperties())
        ..changeAutoIncrement();
    case AttributeType.Loop:
    case AttributeType.Saveable_Field:
    case AttributeType.Dropdown:
      return DropdownAttribute([],
          id: uuid, name: name, properties: AttributeProperties())
        ..addSelectableItem('val')
        ..addSelectableItem('2');
    case AttributeType.User_Name:
      return UserNameAttribute(
          id: uuid, name: name, properties: AttributeProperties());
    case AttributeType.Custom_Delimiter:
      // Return appropriate AttributeBase implementation
      //TODO Add all implementations
      return TextAttribute(
          id: uuid,
          name: name,
          internalValue: '',
          internalDefaultValue: '',
          properties: AttributeProperties());
    case AttributeType.Custom_Text:
      return TextAttribute(
          id: uuid,
          name: name,
          internalValue: '',
          internalDefaultValue: '',
          properties: AttributeProperties());
  }
}
