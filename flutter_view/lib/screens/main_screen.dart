import 'package:Folder_Struct_Maker/constants.dart';
import 'package:Folder_Struct_Maker/screens/CenterMenu/draggable_test.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'AttributesMenu/attributes_menu.dart';
import 'CenterMenu/center_menu.dart';
import 'TreeViewMenu/tree_view_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: secondaryColor2,
        actions: <Widget>[...actionItems, Spacer()],
      ),
      body: Row(
        children: [
          AttributesMenu(),
          Expanded(flex: 10, child: CenterMenu()),
          // Expanded(flex: 10, child: DraggableTest()),
          Expanded(flex: 4, child: TreeViewMenu()),
        ],
      ),
    );
  }
}

var appbarMenuItems = ['File', 'Edit', 'Settings', 'Help', 'About'];

var actionItems = List.generate(appbarMenuItems.length, (index) {
  final textName = appbarMenuItems[index];
  return Material(
    type: MaterialType.transparency,
    child: TextButton(
        onPressed: () {},
        child: Text(
          textName,
          style: GoogleFonts.ubuntu(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
        )),
  );
});
