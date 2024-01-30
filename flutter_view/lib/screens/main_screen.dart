import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:post_composer/services/hive_test/hive_provider.dart';
import 'package:post_composer/services/hive_test/test_hive_class.dart';

import '../Features/appbar_action_items/view/appbar_menu_view.dart';
import '../constants.dart';

import 'AttributesMenu/attributes_menu.dart';
import 'CenterMenu/center_menu.dart';
import 'TreeViewMenu/tree_view_menu.dart';

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
      body: Row(
        children: [
          AttributesMenu(),
          // Flexible(child: HiveTestWidget()),
          Expanded(flex: 10, child: CenterMenu()),
          TreeViewMenu(),
        ],
      ),
    );
  }
}

// class HiveTestWidget extends StatefulHookConsumerWidget {
//   const HiveTestWidget({
//     super.key,
//   });

//   @override
//   ConsumerState<HiveTestWidget> createState() => _HiveTestWidgetState();
// }

// class _HiveTestWidgetState extends ConsumerState<HiveTestWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final accounts = ref.watch(hiveAccountProvider);
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 400,
//             child: ListView.builder(
//                 itemCount: accounts.length,
//                 itemBuilder: (
//                   context,
//                   index,
//                 ) {
//                   return accounts.isEmpty
//                       ? const Text('No accounts')
//                       : Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             accounts[index].toString(),
//                             style: GoogleFonts.poppins(
//                               color: Colors.black,
//                               fontSize: 10,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         );
//                 }),
//           ),
//           ElevatedButton(
//               onPressed: () =>
//                   ref.read(hiveAccountProvider.notifier).saveAccount(),
//               child: Text(
//                 'Save Account',
//                 style: TextStyle(fontSize: 10),
//               )),
//           ElevatedButton(
//               onPressed: () =>
//                   ref.read(hiveAccountProvider.notifier).deleteAccount(),
//               child: Text(
//                 'Clear Account',
//                 style: TextStyle(fontSize: 10),
//               )),
//         ],
//       ),
//     );
//   }
// }
