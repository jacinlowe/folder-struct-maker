import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_composer/Features/attribute_fields/models/attributeFactory.dart';

import '../models/attribute_model.dart';

class AttributeRepo {
  // final Box<List<Map<String, dynamic>>> _hive = Hive.box('attributes');
  final Box _box = Hive.box('attributeBox');
  List<Attribute> repo = [];

  AttributeRepo();

  List<Attribute> getAttributes() {
    (() async => await _loadRepo());

    return repo;
  }

  void addAttribute(Attribute attribute) async {
    repo.add(attribute);
    await _saveRepo();
  }

  void removeAttribute(int index) {
    repo.removeAt(index);
    _saveRepo();
  }

  void deleteAll() {
    _box.clear();
  }

  Future<void> _saveRepo() async {
    await _box.put('_attributes', repo.map((e) => e.toJson()).toList());
  }

  _loadRepo() async {
    final data = await _box.get('_attributes');
    if (data != null) {
      repo = data.map((e) => AttributeJsonFactory(e)).toList();
    }
  }
}

class HiveAttributeNotFoundException implements Exception {
  HiveAttributeNotFoundException();
  final String message = 'Cannot Find Attribute in box';
}

class HiveCouldNotLoadError implements Error {
  @override
  // TODO: implement stackTrace
  StackTrace? get stackTrace => throw UnimplementedError();
}
