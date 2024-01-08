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
    state = [...state, template];
    print('adding new template');
    ref.notifyListeners();
  }
}


// final templateNotifierHasUpdated = Provider<bool>((ref) {
//   bool result;
//   print('Template has been added: $result');
//   return ref.listen(templateNotifierProvider, (previous, next) {
//     previous != next ? result = true : result = false;
//   });
// });


