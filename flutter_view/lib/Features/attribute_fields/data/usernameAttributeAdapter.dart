import 'package:hive_flutter/hive_flutter.dart';

import '../models/username_attribute_model.dart';

class UserNameAttributeAdapter extends TypeAdapter<UserNameAttribute> {
  @override
  final typeId = 5;

  @override
  UserNameAttribute read(BinaryReader reader) {
    return UserNameAttribute.fromJson(reader.read());
  }

  @override
  void write(BinaryWriter writer, UserNameAttribute obj) {
    writer.write(obj.toJson());
  }
}
