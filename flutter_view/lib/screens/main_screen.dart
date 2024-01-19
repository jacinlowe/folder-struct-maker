import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Features/appbar_action_items/view/appbar_menu_view.dart';
import '../constants.dart';

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
        actions: <Widget>[...actionItems, const Spacer()],
      ),
      body: Row(
        children: [
          AttributesMenu(),
          const Expanded(flex: 10, child: CenterMenu()),
          TreeViewMenu(),
        ],
      ),
    );
  }
}
