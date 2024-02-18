import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: secondaryColor2,
        actions: <Widget>[...actionItems, const Spacer()],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('tab bar'),
          Text('Template Selector'),
          Text('buttons'),
          Text('folder name'),
          Container(
              width: MediaQuery.sizeOf(context).width * 0.9,
              decoration: BoxDecoration(color: Colors.grey[350]))
        ],
      ),
    );
  }
}

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      children: [
        const Center(
          child: Text('Page 1'),
        ),
        const Center(
          child: Text('Page 2'),
        ),
        const Center(
          child: Text('Page 3'),
        ),
      ],
    );
  }
}
