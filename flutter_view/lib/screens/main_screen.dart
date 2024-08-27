import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_composer/screens/AttributesMenu/attributes_menu.dart';
import 'package:post_composer/screens/CenterMenu/center_menu.dart';
import 'package:post_composer/screens/TreeViewMenu/tree_view_menu.dart';
import '../Features/appbar_action_items/view/appbar_menu_view.dart';
import '../constants.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: secondaryColor2,
          actions: <Widget>[...actionItems, const Spacer()],
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TabBar(tabs: [
                  Tab(
                    text: 'Variables',
                  ),
                  Tab(
                    text: 'Structure',
                  ),
                  Tab(
                    text: 'Actions',
                  ),
                ]),
              ),
            ),
            Expanded(child: TabViewWidget())
          ],
        ),
      ),
    );
  }
}

class TabViewWidget extends StatefulWidget {
  const TabViewWidget({
    super.key,
  });

  @override
  State<TabViewWidget> createState() => _TabViewWidgetState();
}

class _TabViewWidgetState extends State<TabViewWidget> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      CenterMenu(),
      TreeViewMenu(),
      ActionsMenu(),
    ]);
  }
}

class ActionsMenu extends StatelessWidget {
  const ActionsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Actions Page'),
    );
  }
}
