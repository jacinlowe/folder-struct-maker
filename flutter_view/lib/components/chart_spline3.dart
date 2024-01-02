import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/chart_spline_data.dart';
import '../constants.dart';

class ChartSpline3 extends StatelessWidget {
  final List<ChartSplineData> chartData = chartDataSimple;
  ChartSpline3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      onDataLabelRender: (DataLabelRenderArgs args) {
        // switch (args.pointIndex) {
        //   case 1:
        //     args.text = formatCurrency(chartData[1].amount);
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
      primaryXAxis: CategoryAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
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
              secondaryColor2.withAlpha(23),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      ],
    );
  }
}

final List<ChartSplineData> chartDataSimple = <ChartSplineData>[
  ChartSplineData('Mo', 2),
  ChartSplineData('Tu', 8),
  ChartSplineData('Wo', 5),
  ChartSplineData('Th', 7),
  ChartSplineData('Fr', 5),
];
