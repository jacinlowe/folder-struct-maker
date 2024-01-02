import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../dashboard/header.dart';
import '/constants.dart';
import '../dashboard/dashboard.dart';
import '../../components/sidemenu.dart';

class MainScreen extends StatefulHookConsumerWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: SideMenu()),
        Expanded(
            flex: 4,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 2,
                        vertical: defaultPadding),
                    child: Header()),
                Expanded(
                  child: SingleChildScrollView(
                    child: Dashboard(),
                  ),
                ),
              ],
            ))
      ]),
    );
  }
}
