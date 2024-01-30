import 'package:hive_flutter/hive_flutter.dart';

import '../models/date_attribute_model.dart';

// part '../../../generated/Features/attribute_fields/data/dateAttributeAdapter.g.dart';

class DateAttributeAdapter extends TypeAdapter<DateAttribute> {
  @override
  final typeId = 0;

  DateAttributeAdapter();

  @override
  DateAttribute read(BinaryReader reader) {
    return DateAttribute.fromJson(reader.read());
  }

  @override
  void write(BinaryWriter writer, DateAttribute obj) {
    writer.write(obj.toJson());
  }
}
