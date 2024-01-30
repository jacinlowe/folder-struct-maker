import 'package:hive_flutter/hive_flutter.dart';

import '../models/number_attribute_model.dart';

class NumberAttributeAdapter extends TypeAdapter<NumberAttribute> {
  @override
  final typeId = 2;

  @override
  NumberAttribute read(BinaryReader reader) {
    return NumberAttribute.fromJson(reader.read());
  }

  @override
  void write(BinaryWriter writer, NumberAttribute obj) {
    writer.write(obj.toJson());
  }
}
