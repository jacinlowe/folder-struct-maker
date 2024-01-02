import 'package:Folder_Struct_Maker/constants.dart';
import 'package:flutter/material.dart';

class VisitData {
  final String title;
  final int value;
  final double percentage;
  final Color color;
  VisitData(
      {required this.title,
      required this.value,
      required this.percentage,
      required this.color});
}

List<VisitData> visitData = [
  VisitData(
      title: "All Reservations",
      value: 500,
      percentage: 0.7,
      color: secondaryColor),
  VisitData(
      title: "Successfully Completed",
      value: 478,
      percentage: 0.6,
      color: secondaryColor2),
  VisitData(
      title: "Entries Cancelled",
      value: 52,
      percentage: 0.3,
      color: Color(0xFF01DFFF)),
  VisitData(
      title: "New Clients",
      value: 25,
      percentage: 0.3,
      color: Color(0xFFF9A266)),
];

List<VisitData> visitData2 = [
  VisitData(
      title: "All Reservations",
      value: 340,
      percentage: 0.9,
      color: secondaryColor),
  VisitData(
      title: "Successfully Completed",
      value: 678,
      percentage: 0.3,
      color: secondaryColor2),
  VisitData(
      title: "Entries Cancelled",
      value: 34,
      percentage: 0.4,
      color: Color(0xFF01DFFF)),
  VisitData(
      title: "New Clients",
      value: 12,
      percentage: 0.1,
      color: Color(0xFFF9A266)),
];
