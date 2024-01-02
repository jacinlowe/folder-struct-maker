import 'package:flutter/material.dart';

class MainSideList {
  final String title;
  final IconData icon;
  final int index;

  MainSideList({required this.title, required this.icon, required this.index});
}

List mainSideList1 = [
  MainSideList(title: 'Home', icon: Icons.home_outlined, index: 0),
  MainSideList(title: 'Dashboard', icon: Icons.dashboard_outlined, index: 1),
  MainSideList(title: 'Masters', icon: Icons.group_outlined, index: 2),
  MainSideList(title: 'Schedule', icon: Icons.event_outlined, index: 3),
  MainSideList(title: 'Clients', icon: Icons.groups_outlined, index: 4),
  MainSideList(title: 'Chat', icon: Icons.chat_outlined, index: 5),
  MainSideList(
      title: 'Notifications', icon: Icons.notifications_outlined, index: 6),
];

List mainSideList2 = [
  MainSideList(title: 'Settings', icon: Icons.settings, index: 7),
  MainSideList(title: 'Log Out', icon: Icons.logout_outlined, index: 8)
];
