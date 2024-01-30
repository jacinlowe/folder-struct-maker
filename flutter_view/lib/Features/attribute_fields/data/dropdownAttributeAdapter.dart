import 'package:hive_flutter/hive_flutter.dart';

import '../models/dropdown_attribute_model.dart';

class DropdownAttributeAdapter extends TypeAdapter<DropdownAttribute> {
  @override
  final typeId = 3;

  @override
  DropdownAttribute read(BinaryReader reader) {
    return DropdownAttribute.fromJson(reader.read());
  }

  @override
  void write(BinaryWriter writer, DropdownAttribute obj) {
    writer.write(obj.toJson());
  }
}
