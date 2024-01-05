import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplateGenerator extends Notifier<List<String>> {
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

final templateNotifierProvider =
    NotifierProvider<TemplateGenerator, List<String>>(TemplateGenerator.new);

// final templateNotifierHasUpdated = Provider<bool>((ref) {
//   bool result;
//   print('Template has been added: $result');
//   return ref.listen(templateNotifierProvider, (previous, next) {
//     previous != next ? result = true : result = false;
//   });
// });


