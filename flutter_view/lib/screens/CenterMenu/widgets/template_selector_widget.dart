import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../Features/template_structure/template_name.dart';

class TemplateSelectorWidget extends StatefulHookConsumerWidget {
  const TemplateSelectorWidget({
    super.key,
  });

  @override
  ConsumerState<TemplateSelectorWidget> createState() =>
      _TemplateSelectorWidgetState();
}

class _TemplateSelectorWidgetState
    extends ConsumerState<TemplateSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: 400,
      initialSelection: ref.read(templateNameProvider).first,
      dropdownMenuEntries: [
        ...ref.watch(templateNameProvider).map(
              (e) => DropdownMenuEntry(value: e, label: e),
            ),
      ],
      onSelected: (name) {
        if (name == null) {
          throw Exception('A template name must be selected');
        }
        ref
            .read(selectedTemplateNameProvider.notifier)
            .selectTemplateName(name);
      },
    );
  }
}
