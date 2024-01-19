import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'AttributeTypes/attribute_model.dart';
import 'AttributeTypes/attributeFactory.dart';

import '../../services/create_project/create_project_provider.dart';
import '../../services/file_chooser.dart';

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
    print('item should be added ${newAttribute.id}');
  }

  void removeAttribute(int index) {
    state.removeAt(index);
    ref.notifyListeners();
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

  void changeUseInPath(int index) {
    // final item = state.removeAt(index);
    // item.changeUseInPath();
    // state.insert(index, item);
    state[index].changeUseInPath();
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
}

@riverpod
String attributeCombiner(AttributeCombinerRef ref) {
  final title = ref.watch(attributeListProvider).fold<String>('',
      (previousValue, element) {
    if (!element.useInPath) return previousValue;

    if (previousValue == '') return '$previousValue${element.toString()}';
    return '$previousValue$DELIMITER${element.toString()}';
  });

  return title;
}

@riverpod
String projectTitle(ProjectTitleRef ref) {
  return ref.watch(attributeCombinerProvider);
}
