import 'package:uuid/uuid.dart';

import 'attribute_model.dart';

Attribute attributeFactory(AttributeType attribute, String name) {
  String uuid = const Uuid().v4();
  switch (attribute) {
    case AttributeType.Date:
      return DateAttribute(id: uuid, name: name);
    case AttributeType.Number:
      return NumberAttribute(id: uuid, name: name)..changeAutoIncrement();
    case AttributeType.Loop:
    case AttributeType.Saveable_Field:
    case AttributeType.Dropdown:
      return DropdownAttribute([], id: uuid, name: name)
        ..addSelectableItem('val')
        ..addSelectableItem('2');
    case AttributeType.User_Name:
      return UserNameAttribute(id: uuid, name: name);
    case AttributeType.Custom_Delimiter:
      // Return appropriate AttributeBase implementation
      //TODO Add all implementations
      return CustomTextAttribute(id: uuid, name: name);
    case AttributeType.Custom_Text:
      return CustomTextAttribute(id: uuid, name: name);
  }
}
