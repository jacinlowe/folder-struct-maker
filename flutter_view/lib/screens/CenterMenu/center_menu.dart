import 'package:Folder_Struct_Maker/constants.dart';
import 'package:Folder_Struct_Maker/services/template_generator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'parameter_field/parameter_field.dart';

class CenterMenu extends HookConsumerWidget {
  const CenterMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool hasUpdated = false;
    ref.listen(templateNotifierProvider, (previous, next) {
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
        SizedBox(
          height: defaultPadding,
        ),
        Row(
          children: [
            Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(
                'Template:',
                style: GoogleFonts.ubuntu(fontSize: 18),
              ),
            ),
            DropdownMenu(
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
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding),
        Row(
          children: [
            Spacer(),
            Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    ref
                        .watch(templateNotifierProvider.notifier)
                        .addTemplate('template');
                    print(hasUpdated);
                  },
                  child: Text(
                    'Create Template',
                    style: TextStyle(fontSize: 12, color: secondaryColor),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                      side: MaterialStateProperty.all(
                          BorderSide(color: secondaryColor, width: 2)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                ),
                SizedBox(
                  height: defaultPadding / 4,
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    'Modify Template',
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      )),
                ),
              ],
            ),
            SizedBox(width: defaultPadding),
            Container(
              width: 450,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      style: BorderStyle.solid,
                      color: secondaryColor)),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 4),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            child: Icon(
                              Icons.folder,
                              size: 24,
                            ),
                          ),
                          Text(
                            'My Project_Hugo Boss_21_Commercial_11-23-32',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      )
                    ]),
              ),
            ),
            SizedBox(
              width: defaultPadding,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Create Project',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  elevation: 3,
                  fixedSize: Size(140, 60),
                  // minimumSize: Size(30, 20),
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            Spacer()
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding * 2, vertical: defaultPadding / 2),
          child: ParameterField(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
          child: Row(
            children: [
              ToggleOptionsSwitch(),
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
