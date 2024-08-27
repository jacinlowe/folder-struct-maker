import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:post_composer/Features/template_structure/templateProvider.dart';
import 'package:post_composer/Features/template_structure/template_name.dart';

import '../../constants.dart';
import '../../screens/TreeViewMenu/tree_view_widget.dart';

class TreeViewMenu extends ConsumerStatefulWidget {
  const TreeViewMenu({
    super.key,
  });

  @override
  ConsumerState<TreeViewMenu> createState() => _TreeViewMenuState();
}

class _TreeViewMenuState extends ConsumerState<TreeViewMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: MediaQuery.sizeOf(context).width / 4,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: secondaryColor,
                border: Border.all(color: secondaryColor2, width: 2),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: const TemplateNameWidget()),
        Expanded(
          flex: 4,
          child: Container(
            decoration: const BoxDecoration(
                color: secondaryColor2,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      RotatedBox(
                        quarterTurns: 2,
                        child: IconButton(
                          icon: Icon(
                            Icons.menu_open_outlined,
                            color: Colors.white54,
                          ),
                          iconSize: 28,
                          onPressed: () {},
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        'Preview',
                        style: GoogleFonts.ubuntu(
                            fontSize: 48,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      Spacer()
                    ],
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: TreeViewWidget()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TemplateNameWidget extends ConsumerStatefulWidget {
  const TemplateNameWidget({
    super.key,
  });

  @override
  ConsumerState<TemplateNameWidget> createState() => _TemplateNameWidgetState();
}

class _TemplateNameWidgetState extends ConsumerState<TemplateNameWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final templateNames = ref.watch(templateNameProvider);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: templateNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  hoverColor: Colors.amber,
                  selectedColor: Colors.amberAccent,
                  contentPadding: EdgeInsets.all(8.0),
                  title: Text(
                    templateNames[index],
                    style: TextStyle(color: secondaryBgColor),
                  ),
                  selected: index == _selectedIndex,
                  onTap: () {
                    final newName = templateNames[index];
                    print('Template selected: $newName');
                    ref
                        .read(selectedTemplateNameProvider.notifier)
                        .selectTemplateName(newName);
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                );
              },
            ),
          )
        ]);
  }
}
