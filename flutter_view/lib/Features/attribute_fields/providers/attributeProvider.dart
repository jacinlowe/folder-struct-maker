import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_composer/Features/attribute_fields/services/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/attribute_model.dart';
import '../models/attributeFactory.dart';

import '../../../services/create_project/create_project_provider.dart';
import '../../../services/file_chooser.dart';
import '../models/number_attribute_model.dart';
import '../services/attributes_hive_data.dart';

part '../../../generated/Features/attribute_fields/providers/attributeProvider.g.dart';

const DELIMITER = '_';

@riverpod
class AttributeList extends _$AttributeList {
  // final _hiveBox = HiveRepository(Hive.box('attributeBox'));
  // final Box<List<Attribute>> box = Hive.box('attributeBox');

  @override
  List<Attribute> build() {
    var result = [];
    // _hiveBox
    //     .getAll()
    //     .then((value) => result = value as List<Attribute<dynamic>>)
    //     .catchError(() => null);

    return [];
  }

  void addAttribute(AttributeType attribute) async {
    final name = attribute.name;
    final newAttribute = attributeFactory(attribute, name);

    // _hiveBox.add(Entity<Attribute>(id: newAttribute.id, entity: newAttribute));

    state = [...state, newAttribute];

    print('item should be added ${newAttribute.id}');
    // _hiveBox.getById(newAttribute.id);
  }

  void removeAttribute(int index) async {
    // _hiveAttributeBox.removeAttribute(index);
    // state = _hiveAttributeBox.getAttributes();
    // state.removeAt(index);
    ref.notifyListeners();
  }

  void updateAttribute(int index,
      {String? value, String? defaultValue, String? name}) {
    final attr = state.removeAt(index);
    final tempState = state.toList();

    if (value != null) {
      final typedValue = attr.adaptValue(value);
      attr.updateValue(typedValue);
    }
    if (defaultValue != null) {
      final typedValue = attr.adaptValue(defaultValue);
      attr.updateDefaultValue(typedValue);
    }
    if (name != null) {
      attr.updateName(name);
    }

    tempState.insert(index, attr);
    state = tempState;
  }

  void reorder(int oldIndex, int newIndex) {
    final tempState = state;
    if (newIndex > oldIndex) newIndex--;
    final item = tempState.removeAt(oldIndex);
    tempState.insert(newIndex, item);
    print(tempState);
    state = tempState;
    ref.notifyListeners();
  }

  void changeUseInPath(int index) {
    // final item = state.removeAt(index);
    // item.changeUseInPath();
    // state.insert(index, item);
    state[index].properties.changeUseInPath();
    ref.notifyListeners();
  }

  void createProject() async {
    final rootFolder = await FileChooser()
        .getFolder()
        .catchError((err) => print('Error creating project'));
    ref
        .read(createProjectProvider.notifier)
        .createProject(parentFolder: rootFolder);
    for (final item in state) {
      if (item.runtimeType == NumberAttribute) {
        item as NumberAttribute;
        if (item.autoIncrement == true) {
          item.increment();
          ref.notifyListeners();
          print(item.toString());
        }
      }
    }
    print('creating project from attributes');
  }

  Attribute getItem({int? index, Attribute? item}) {
    if (index == null && item == null) {
      throw Exception('Must include either an index or an item');
    }
    if (index != null) {
      return state[index];
    } else {
      return state.firstWhere((element) => element.id == item!.id);
    }
  }

  // Future<void> _saveState() async {
  //   // await box.put('_attributes', state);
  // }

  // List<Attribute> _loadState() {
  //   // return box.get('_attributes') ?? [] as List<Attribute>;
  // }
}

@riverpod
String attributeCombiner(AttributeCombinerRef ref) {
  final title = ref.watch(attributeListProvider).fold<String>('',
      (previousValue, element) {
    if (!element.properties.useInPath) return previousValue;

    if (previousValue == '') return '$previousValue${element.toString()}';
    return '$previousValue$DELIMITER${element.toString()}';
  });

  return title.isEmpty ? 'My Project_Hugo Boss_21_Commercial_11-23-32' : title;
}

@riverpod
String projectTitle(ProjectTitleRef ref) {
  return ref.watch(attributeCombinerProvider);
}
