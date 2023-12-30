import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.press,
  });

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: ListTile(
          onTap: press,
          hoverColor: Color.fromARGB(49, 160, 160, 160),
          selectedTileColor: Colors.red,
          horizontalTitleGap: 15.0,
          leading: Icon(
            icon,
            color: Colors.white70,
            size: 22,
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white70),
          ),
        ));
  }
}
