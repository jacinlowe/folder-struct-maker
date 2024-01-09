import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'AttributeTypes/attribute_model.dart';
import 'AttributeTypes/attributeFactory.dart';

part '../../generated/Features/attribute_fields/attributeProvider.g.dart';

const DELIMITER = '_';

@riverpod
class AttributeList extends _$AttributeList {
  @override
  List<Attribute> build() {
    return [];
  }

  void addAttribute(AttributeType attribute) {
    final name = attribute.name;
    final newAttribute = attributeFactory(attribute, name);
    state = [...state, newAttribute];
    print('item should be added');
  }

  void removeAttribute(Attribute target) {
    state = state.where((element) => element.id != target.id).toList();
  }

  void updateAttribute(int index,
      {String? value, String? defaultValue, String? name}) {
    final attr = state.removeAt(index);
    final tempState = state.toList();
    if (value != null) {
      attr.changeValue(value);
    }
    if (defaultValue != null) {
      attr.changeDefaultValue(defaultValue);
    }
    if (name != null) {
      attr.changeName(name);
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

  void createProject() {
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
}

@riverpod
String attributeCombiner(AttributeCombinerRef ref) {
  final title = ref.watch(attributeListProvider).fold<String>('',
      (previousValue, element) {
    if (previousValue == '') return '${previousValue}${element.toString()}';
    return '${previousValue}$DELIMITER${element.toString()}';
  });

  return title;
}
