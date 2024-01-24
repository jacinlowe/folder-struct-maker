import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'parameter_field/parameter_field.dart';

import '../../constants.dart';
import '../../Features/attribute_fields/providers/attributeProvider.dart';
import '../../../services/template_generator.dart';
import '../../Features/attribute_fields/widgets/folder_name_preview_widget.dart';
import '../../services/file_chooser.dart';
import '../../screens/CenterMenu/providers/option_toggle_provider.dart';

import 'widgets/template_operation_buttons_widget.dart';
import 'widgets/template_selector_widget.dart';

class CenterMenu extends HookConsumerWidget {
  CenterMenu({
    super.key,
  });

  Widget toggleOption(bool toggleVal) {
    return toggleVal
        ? const ParameterField()
        : Container(
            color: Colors.blue,
          );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool hasUpdated = false;
    ref.listen(templateGeneratorProvider, (previous, next) {
      if (previous != next) {
        hasUpdated = !hasUpdated;
        print('templates have changed: $hasUpdated');
      }
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Editable Fields',
          style: GoogleFonts.ubuntu(
              fontSize: 48, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Row(
          children: [
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(
                'Template:',
                style: GoogleFonts.ubuntu(fontSize: 18),
              ),
            ),
            TemplateSelectorWidget(),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            TemplateOperationButtonsWidget(),
            const SizedBox(width: defaultPadding),
            Container(
              width: 450,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      style: BorderStyle.solid,
                      color: secondaryColor)),
              child: const Padding(
                padding: EdgeInsets.all(defaultPadding / 4),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Folder Name Preview',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            child: Icon(
                              Icons.folder,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 350, child: FolderNamePreview()),
                        ],
                      )
                    ]),
              ),
            ),
            const SizedBox(
              width: defaultPadding,
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(attributeListProvider.notifier).createProject();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  elevation: 3,
                  fixedSize: const Size(140, 60),
                  // minimumSize: Size(30, 20),
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: const Text(
                'Create Project',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Spacer()
          ],
        ),
        Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 2, vertical: defaultPadding / 2),
            child: Container(
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CenterMenuWidget())),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
          child: Row(
            children: [
              const ToggleOptionsSwitch(),
              Text(
                'Toggle Options',
                style: GoogleFonts.ubuntu(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ToggleOptionsSwitch extends StatefulHookConsumerWidget {
  const ToggleOptionsSwitch({
    super.key,
  });

  @override
  ConsumerState<ToggleOptionsSwitch> createState() =>
      _ToggleOptionsSwitchState();
}

class _ToggleOptionsSwitchState extends ConsumerState<ToggleOptionsSwitch> {
  bool toggle = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: toggle,
        onChanged: (bool value) => setState(() {
              toggle = value;
              ref.read(optionToggleProvider.notifier).toggleOption();
            }));
  }

  bool getToggleValue() => toggle;
}
