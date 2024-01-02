import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/chart_spline_data.dart';
import '../constants.dart';
import '../models/data.dart';
import '../utils/format_currency.dart';

class ChartSpline extends StatelessWidget {
  const ChartSpline({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      onDataLabelRender: (DataLabelRenderArgs args) {
        switch (args.pointIndex) {
          case 1:
            args.text = formatCurrency(chartData2[1].amount);
            args.textStyle = const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            );
            args.offset = const Offset(0, 5);
            break;
          // case 4:
          //   args.text = formatCurrency(chartData2[4].amount);
          //   args.textStyle = const TextStyle(
          //     fontSize: 14,
          //     color: Colors.white,
          //     fontWeight: FontWeight.w400,
          //   );
          //   args.offset = const Offset(0, 5);

          //   break;
          default:
            args.text = '';
        }
      },
      onMarkerRender: (MarkerRenderArgs args) {
        switch (args.pointIndex) {
          case 1:
            break;
          // case 4:
          //   break;
          default:
            args.markerHeight = 0;
            args.markerWidth = 0;
            break;
        }
        // if (!(args.pointIndex == 1)) {
        //   args.markerHeight = 0;
        //   args.markerWidth = 0;
        // }
      },
      plotAreaBackgroundColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      margin: const EdgeInsets.all(0),
      borderColor: Colors.transparent,
      borderWidth: 0,
      primaryXAxis: CategoryAxis(
          axisLine: const AxisLine(width: 0),
          labelPlacement: LabelPlacement.onTicks,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(width: 0),
          labelStyle: const TextStyle(
              fontFamily: 'Roboto', fontSize: 14, color: Colors.white)),
      primaryYAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 1, color: bgColor),
          labelStyle: const TextStyle(
              fontFamily: 'Roboto', fontSize: 14, color: Colors.white),
          majorTickLines: const MajorTickLines(width: 0),
          axisLine: const AxisLine(width: 0),
          minimum: chartData.map((e) => e.amount).reduce(min),
          maximum: chartData.map((e) => e.amount).reduce(max) + 1000,
          interval: 500),
      series: <ChartSeries<ChartSplineData, String>>[
        SplineSeries(
            color: secondaryColor2,
            width: 4,
            dataSource: chartData,
            xValueMapper: (ChartSplineData data, _) => data.month,
            yValueMapper: (ChartSplineData data, _) => data.amount),
        SplineAreaSeries(
            dataSource: chartData,
            xValueMapper: (ChartSplineData data, _) => data.month,
            yValueMapper: (ChartSplineData data, _) => data.amount,
            gradient: LinearGradient(colors: [
              secondaryColor2.withAlpha(150),
              secondaryColor2.withAlpha(10),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        SplineSeries(
            markerSettings:
                const MarkerSettings(isVisible: true, height: 10, width: 10),
            dataLabelSettings: const DataLabelSettings(
                color: primaryColor,
                borderColor: secondaryColor,
                borderWidth: 2,
                useSeriesColor: true,
                labelAlignment: ChartDataLabelAlignment.top,
                isVisible: true),
            color: secondaryColor,
            width: 4,
            dataSource: chartData2,
            xValueMapper: (ChartSplineData data, _) => data.month,
            yValueMapper: (ChartSplineData data, _) => data.amount),
        SplineAreaSeries(
            dataSource: chartData2,
            xValueMapper: (ChartSplineData data, _) => data.month,
            yValueMapper: (ChartSplineData data, _) => data.amount,
            gradient: LinearGradient(colors: [
              secondaryColor.withAlpha(150),
              secondaryColor.withAlpha(10),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter))
      ],
    );
  }
}
