import 'dart:math';

import 'package:Folder_Struct_Maker/controllers/reservation_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../constants.dart';
import '../../utils/format_currency.dart';

class ChartColumn extends HookConsumerWidget {
  ChartColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ChartColumnData> chartData = ref.watch(chartDataProvider);
    final chartDataMin = chartData.map((e) => e.y1.floorToDouble()).reduce(min);
    final chartDataMax = chartData.map((e) => e.y2.ceilToDouble()).reduce(max);
    print(chartDataMax);
    return SfCartesianChart(
        onDataLabelRender: (DataLabelRenderArgs args) {
          // switch (args.pointIndex) {
          //   case 1:
          //     args.text = formatCurrency(chartData2[1].amount);
          //     args.textStyle = const TextStyle(
          //       fontSize: 14,
          //       color: Colors.white,
          //       fontWeight: FontWeight.w400,
          //     );
          //     args.offset = const Offset(0, 5);
          //     break;
          //   // case 4:
          //   //   args.text = formatCurrency(chartData2[4].amount);
          //   //   args.textStyle = const TextStyle(
          //   //     fontSize: 14,
          //   //     color: Colors.white,
          //   //     fontWeight: FontWeight.w400,
          //   //   );
          //   //   args.offset = const Offset(0, 5);

          //   //   break;
          //   default:
          //     args.text = '';
          // }
        },
        onMarkerRender: (MarkerRenderArgs args) {
          // switch (args.pointIndex) {
          //   case 1:
          //     break;
          //   // case 4:
          //   //   break;
          //   default:
          //     args.markerHeight = 0;
          //     args.markerWidth = 0;
          //     break;
          // }
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
            labelPlacement: LabelPlacement.betweenTicks,
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(width: 0),
            labelStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
        primaryYAxis: NumericAxis(
            isVisible: true,
            majorGridLines: const MajorGridLines(width: 1, color: bgColor),
            labelStyle: const TextStyle(
                fontFamily: 'Roboto', fontSize: 14, color: Colors.white),
            majorTickLines: const MajorTickLines(width: 0),
            axisLine: const AxisLine(width: 0),
            minimum: chartDataMin < 10 ? chartDataMin : 10,
            maximum: chartDataMax,
            interval: 10),
        series: <CartesianSeries>[
          ColumnSeries<ChartColumnData, String>(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              dataSource: chartData,
              width: 0.4,
              color: secondaryColor2,
              borderColor: primaryColor,
              borderWidth: 2,
              xValueMapper: (ChartColumnData data, _) => data.x,
              yValueMapper: (ChartColumnData data, _) => data.y1),
          ColumnSeries<ChartColumnData, String>(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              dataSource: chartData,
              width: 0.4,
              color: secondaryColor,
              borderColor: primaryColor,
              borderWidth: 2,
              xValueMapper: (ChartColumnData data, _) => data.x,
              yValueMapper: (ChartColumnData data, _) => data.y2),
        ]);
  }
}

final chartDataProvider = Provider<List<ChartColumnData>>((ref) {
  final selection = ref.watch(reservationProvider);
  if (selection == ReservationType.month) return chartWeekData;
  return chartMonthData;
});

final List<ChartColumnData> chartWeekData = <ChartColumnData>[
  ChartColumnData('Mo', 20, 35),
  ChartColumnData('Tu', 40, 32),
  ChartColumnData('We', 30, 34),
  ChartColumnData('Th', 42, 50),
  ChartColumnData('Fr', 32, 40),
  ChartColumnData('Sa', 42, 45),
  ChartColumnData('Su', 35, 50),
];
final List<ChartColumnData> chartMonthData = <ChartColumnData>[
  ChartColumnData('Jan', 10, 33),
  ChartColumnData('Feb', 25, 37),
  ChartColumnData('Mar', 33, 12),
  ChartColumnData('Apr', 23, 34),
  ChartColumnData('May', 45, 12),
  ChartColumnData('Jun', 23, 54),
  ChartColumnData('Jul', 43, 23),
  ChartColumnData('Aug', 12, 54),
  ChartColumnData('Sep', 13, 26),
  ChartColumnData('Oct', 15, 34),
  ChartColumnData('Nov', 19, 78),
  ChartColumnData('Dec', 32, 67),
];

class ChartColumnData {
  String x;
  int y1;
  int y2;
  ChartColumnData(this.x, this.y1, this.y2);
}
