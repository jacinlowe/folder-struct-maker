import 'dart:math';

import 'package:Folder_Struct_Maker/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/data.dart';
import '../../models/ring_chart_data_model.dart';

class ChartRing extends StatelessWidget {
  const ChartRing({super.key});
  final size = 140.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: size,
          width: size,
          child: SfCircularChart(series: <CircularSeries>[
            DoughnutSeries<RingChartData, String>(
                dataSource: ringChartData,
                innerRadius: '85%',
                startAngle: 350,
                endAngle: 350,
                cornerStyle: CornerStyle.bothCurve,
                pointColorMapper: (RingChartData data, _) => data.color,
                xValueMapper: (RingChartData data, _) => data.x,
                yValueMapper: (RingChartData data, _) => data.y),
          ]),
        ),
        Positioned.fill(
            child: Center(
          child: Text(
            '${ringChartData.map((e) => e.y).reduce(max)}%',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ))
      ],
    );
  }
}
