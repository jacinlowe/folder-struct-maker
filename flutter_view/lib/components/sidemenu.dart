import 'package:flutter/material.dart';

import 'drawer_list_tile.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Color.fromARGB(255, 3, 38, 86),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DrawerHeader(
                child: Image.asset(
              'assets/images/logo.png',
              color: Colors.amber,
            )),
            Center(
              child: SingleChildScrollView(
                  child: Column(
                children: [],
              )),
            ),
            DrawerListTile(
                title: "Dashboard",
                icon: Icons.dashboard_rounded,
                press: () {}),
            DrawerListTile(
                title: "Transaction",
                icon: Icons.account_balance,
                press: () {}),
            DrawerListTile(
                title: "Tasks", icon: Icons.task_rounded, press: () {}),
            DrawerListTile(
                title: "Documents", icon: Icons.edit_document, press: () {}),
            DrawerListTile(
                title: "Notification", icon: Icons.chat_rounded, press: () {}),
            DrawerListTile(
                title: "Profile", icon: Icons.person_2, press: () {}),
            const Spacer(),
            DrawerListTile(
                title: "Settings", icon: Icons.settings, press: () {})
          ],
        ),
      ),
    );
  }
}
