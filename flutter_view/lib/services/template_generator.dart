import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/services/template_generator.g.dart';

@riverpod
class TemplateGenerator extends _$TemplateGenerator {
  @override
  List<String> build() {
    return [];
  }

  void addTemplate(String template) {
    final temporaryName = '$template ' + (state.length + 1).toString();

    state = [...state, temporaryName];
    print('adding new template');
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
bool templateNotifierHasUpdated(TemplateNotifierHasUpdatedRef ref) {
  bool result = false;
  ref.listen(
    templateGeneratorProvider,
    (previous, next) {
      result = previous != next ? true : false;
      print('Template has been added: $result');
    },
    onError: (error, stackTrace) => Exception(error),
  );
  return result;
}
