import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/bloodGlucose_provider.dart';
import 'package:provider/provider.dart';

class BloodGlucoseWeeklyGraph extends StatefulWidget {
  @override
  _BloodGlucoseWeeklyGraphState createState() =>
      _BloodGlucoseWeeklyGraphState();
}

class _BloodGlucoseWeeklyGraphState extends State<BloodGlucoseWeeklyGraph> {
  List<Color> redColors = [
    Colors.red,
  ];

  List<Color> blueColors = [
    Colors.blue,
  ];
  @override
  void initState() {
    super.initState();
    var bgProvider = Provider.of<BloodGlucoseProvider>(context, listen: false);
    bgProvider.getBloodGlucoses();
  }

  List<FlSpot> spots = [];
  @override
  Widget build(BuildContext context) {
    final bgsData = Provider.of<BloodGlucoseProvider>(context);
    final bgs = bgsData.bgs;
    bgs.forEach((element) {
      double time = element.date.hour + element.date.minute / 60;
      spots.add(FlSpot(time, element.value.toDouble()));
    });
    return LineChart(
      LineChartData(
        minX: 0,
        minY: 0,
        maxX: 7,
        maxY: 200,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTextStyles: (BuildContext context, value) => const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 10),
              getTitles: (value) {
                switch (value.toInt()) {
                  case 1:
                    return 'pzt';
                    break;
                  case 2:
                    return 'sal';
                    break;
                  case 3:
                    return 'çrş';
                    break;
                  case 4:
                    return 'prş';
                    break;
                  case 5:
                    return 'cum';
                    break;
                  case 6:
                    return 'cts';
                    break;
                  case 7:
                    return 'pzr';
                    break;
                }
                return '';
              }),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (BuildContext context, value) => const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10),
            getTitles: (value) {
              if (value % 20 == 0) {
                return '${value.toInt()}';
              }
              return '';
            },
          ),
        ),
        gridData: FlGridData(
          show: false,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            colors: [Colors.white],
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            /* belowBarData: BarAreaData(
                show: true,
                colors:
                    kLineColors.map((color) => color.withOpacity(0.3)).toList(),
              ) */
          ),
        ],
      ),
    );
  }
}
