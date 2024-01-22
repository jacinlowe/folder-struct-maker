import 'package:Folder_Struct_Maker/constants.dart';
import 'package:Folder_Struct_Maker/services/template_generator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TemplateOperationButtonsWidget extends HookConsumerWidget {
  const TemplateOperationButtonsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () {
            ref
                .read(templateGeneratorProvider.notifier)
                .addTemplate('template');
          },
          style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
              side: MaterialStateProperty.all(
                  const BorderSide(color: secondaryColor, width: 2)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
          child: const Text(
            'Create Template',
            style: TextStyle(fontSize: 12, color: secondaryColor),
          ),
        ),
        const SizedBox(
          height: defaultPadding / 4,
        ),
        OutlinedButton(
          onPressed: () {},
          style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              )),
          child: const Text(
            'Modify Template',
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
