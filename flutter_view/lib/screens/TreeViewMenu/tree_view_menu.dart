import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    return Expanded(
      flex: 4,
      child: Container(
        decoration: const BoxDecoration(
            color: secondaryColor2,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
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
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
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
    );
  }
}
