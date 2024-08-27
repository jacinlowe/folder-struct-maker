import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'template_structure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../generated/Features/template_structure/template_name.g.dart';

@riverpod
class TemplateName extends _$TemplateName {
  String? selectedTemplateName;

  @override
  List<String> build() {
    return []..addAll(templates.map((e) => e.name));
  }

  void addTemplate(String template) {
    print('adding new template');
    // check for duplicate name
    if (state.contains(template)) {
      final temporaryName = '$template ' + (state.length + 1).toString();
      state = [...state, temporaryName];
    } else {
      state = [...state, template];
    }

    ref.notifyListeners();
  }

  void removeTemplate(int id) {
    final tempState = state;
    tempState.removeAt(id);
    state = tempState;
    ref.notifyListeners();
  }
}

@riverpod
class SelectedTemplateName extends _$SelectedTemplateName {
  @override
  String build() {
    return ref.read(templateNameProvider).first;
  }

  void selectTemplateName(String name) {
    final nameList = ref.read(templateNameProvider);
    if (!nameList.contains(name)) {
      throw Exception('Name not in Template List');
    }
    state = name;
    print('Selected Template Name:$state');
    ref.notifyListeners();
  }
}

@riverpod
bool templateNotifierHasUpdated(TemplateNotifierHasUpdatedRef ref) {
  bool result = false;
  ref.listen(
    templateNameProvider,
    (previous, next) {
      result = previous != next ? true : false;
      print('Template has been added: $result');
    },
    onError: (error, stackTrace) => Exception(error),
  );
  return result;
}

const List<String> templateNames = [
  'Default Project',
  'Default Project with really long name to test extended names view in the dropdown menu',
  'Default Project with long text to make sure we see it all'
];
