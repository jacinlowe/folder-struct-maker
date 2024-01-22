import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../services/template_generator.dart';

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
        initialSelection: 'Default Project2',
        dropdownMenuEntries: [
          ...ref.watch(templateGeneratorProvider).map(
                (e) => DropdownMenuEntry(value: e, label: e),
              ),
          DropdownMenuEntry(value: 'Default Project', label: 'Default Project'),
          DropdownMenuEntry(
              value: 'Default Project2',
              label:
                  'Default Project with long text to make sure we see it all'),
        ]);
  }
}
