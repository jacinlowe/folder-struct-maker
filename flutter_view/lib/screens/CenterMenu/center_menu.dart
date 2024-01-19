import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'parameter_field/parameter_field.dart';

import '../../Features/attribute_fields/attributeProvider.dart';
import '../../constants.dart';
import '../../../services/template_generator.dart';
import '../../Features/attribute_fields/attribute_combiner_consumer.dart';
import '../../services/file_chooser.dart';

class CenterMenu extends HookConsumerWidget {
  const CenterMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool hasUpdated = false;
    ref.listen(templateGeneratorProvider, (previous, next) {
      if (previous != next) {
        print('templates have changed: true');
        hasUpdated = !hasUpdated;
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
            const DropdownMenu(
                width: 400,
                initialSelection: 'Default Project',
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                      value: 'Default Project', label: 'Default Project'),
                  DropdownMenuEntry(
                      value: 'Default Project2',
                      label:
                          'Default Project with long text to make sure we see it all'),
                ]),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    ref
                        .watch(templateGeneratorProvider.notifier)
                        .addTemplate('template');
                    print(hasUpdated);
                  },
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(16)),
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
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(16)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      )),
                  child: const Text(
                    'Modify Template',
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
              ],
            ),
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
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 2, vertical: defaultPadding / 2),
          child: ParameterField(),
        ),
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

class ToggleOptionsSwitch extends StatefulWidget {
  const ToggleOptionsSwitch({
    super.key,
  });

  @override
  State<ToggleOptionsSwitch> createState() => _ToggleOptionsSwitchState();
}

class _ToggleOptionsSwitchState extends State<ToggleOptionsSwitch> {
  bool toggle = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: toggle,
        onChanged: (bool value) => setState(() {
              toggle = value;
            }));
  }
}
