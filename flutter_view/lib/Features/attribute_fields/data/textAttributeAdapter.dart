import 'package:hive_flutter/hive_flutter.dart';

import '../models/text_attribute_model.dart';

class TextAttributeAdapter extends TypeAdapter<TextAttribute> {
  @override
  final typeId = 4;

  @override
  TextAttribute read(BinaryReader reader) {
    return TextAttribute.fromJson(reader.read());
  }

  @override
  void write(BinaryWriter writer, TextAttribute obj) {
    writer.write(obj.toJson());
  }
}
