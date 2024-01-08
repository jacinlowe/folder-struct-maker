import 'package:uuid/uuid.dart';

import 'attribute_model.dart';

String _uuid = Uuid().v4();

Attribute attributeFactory(AttributeType attribute, String name) {
  switch (attribute) {
    case AttributeType.Date:
      return DateAttribute(id: _uuid, name: name);
    case AttributeType.Number:
      return NumberAttribute(id: _uuid, name: name);
    case AttributeType.Loop:
    case AttributeType.Saveable_Field:
    case AttributeType.Dropdown:
    case AttributeType.User_Name:
    case AttributeType.Delimiter:
      // Return appropriate AttributeBase implementation
      //TODO Add all implementations
      return CustomTextAttribute(id: _uuid, name: name);
    case AttributeType.Custom_Text:
      return CustomTextAttribute(id: _uuid, name: name);
  }
}
