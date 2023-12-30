import 'package:flutter/material.dart';

import '../../components/sidemenu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          Expanded(child: SideMenu()),
          Expanded(
              flex: 4,
              child: Container(
                color: Colors.blue,
              )),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.red,
            ),
          )
        ],
      )),
    );
  }
}
