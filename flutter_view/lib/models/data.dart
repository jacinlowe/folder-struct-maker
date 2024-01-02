import 'dart:math';

import 'package:Folder_Struct_Maker/models/chart_spline_data.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'reservation_date_model.dart';
import 'ring_chart_data_model.dart';

final List<ChartSplineData> chartData = <ChartSplineData>[
  ChartSplineData('Mo', 1000),
  ChartSplineData('Tu', 2000),
  ChartSplineData('Wo', 1500),
  ChartSplineData('Th', 2800),
  ChartSplineData('fr', 1500),
  ChartSplineData('Sa', 2500),
  ChartSplineData('Su', 1500),
];

final List<ChartSplineData> chartData2 = <ChartSplineData>[
  ChartSplineData('Mo', 1500),
  ChartSplineData('Tu', 2500),
  ChartSplineData('Wo', 2000),
  ChartSplineData('Th', 1500),
  ChartSplineData('fr', 2800),
  ChartSplineData('Sa', 2500),
  ChartSplineData('Su', 2000),
];

final List<RingChartData> ringChartData = [
  RingChartData('Haircut', 40, secondaryColor),
  RingChartData('Makeup', 35, secondaryColor),
  RingChartData('Hair Color', 20, Color(0xFF01DFFF)),
  RingChartData('Massage', 15, Color(0xFF4FF0B4)),
  RingChartData('Nails', 25, Color(0xFFF9A266)),
  RingChartData('Skincare', 15, Color(0xFFF9CE62)),
];

List<Icon> iconChoice(Color color) {
  return [
    Icon(Icons.clear, size: 18, color: Colors.white54),
    ...List.generate(colorList.length,
        (index) => Icon(Icons.check_circle_sharp, size: 18, color: color)),
  ];
}

final List<ReservationDateModel> demoDataModel =
    List.generate(ringChartData.length, (index) {
  final title = ringChartData[index].x;
  final color = ringChartData[index].color;
  final iconChoices = iconChoice(color);
  final icons = List.generate(
      12, (index) => iconChoices[Random().nextInt(iconChoices.length)]);
  return ReservationDateModel(title: title, icons: icons);
});
