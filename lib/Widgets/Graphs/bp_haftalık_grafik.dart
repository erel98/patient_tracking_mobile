import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/bloodPressure_provider.dart';
import 'package:provider/src/provider.dart';

class BloodPressureWeeklyGraph extends StatefulWidget {
  @override
  _BloodPressureWeeklyGraphState createState() =>
      _BloodPressureWeeklyGraphState();
}

class _BloodPressureWeeklyGraphState extends State<BloodPressureWeeklyGraph> {
  List<Color> redColors = [
    Colors.red,
  ];

  List<Color> blueColors = [
    Colors.blue,
  ];
  List<Color> orangeColors = [
    Colors.orange,
  ];
  List<Color> kgradientColors = [
    const Color(0xff23b6e6),
  ];
  List<Color> bgradientColors = [Colors.grey];
  List<FlSpot> systoleList = [];
  List<FlSpot> diastoleList = [];
  List<Color> get kLineColors =>
      diastoleList.last.y <= 100 && diastoleList.last.y >= 60
          ? blueColors
          : redColors;
  List<Color> get bLineColors =>
      systoleList.last.y <= 140 && systoleList.last.y >= 100
          ? orangeColors
          : redColors;
  @override
  void initState() {
    super.initState();
    final bpProvider =
        Provider.of<BloodPressureProvider>(context, listen: false);
    bpProvider.getBloodPressures(context);
  }

  @override
  Widget build(BuildContext context) {
    final bpsData = Provider.of<BloodPressureProvider>(context);
    final bps = bpsData.bps;
    bps.forEach((element) {
      double time = element.time.day +
          element.time.hour / 24 +
          element.time.minute / 1440;
      systoleList.add(FlSpot(time, element.systole));
      diastoleList.add(FlSpot(time, element.diastole));
    });
    return LineChart(
      LineChartData(
          minX: 0,
          minY: 0,
          maxX: 7,
          maxY: 15,
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
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 10),
              getTitles: (value) {
                if (value % 1 == 0) {
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
              spots: systoleList,
              isCurved: true,
              colors: kgradientColors,
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
            LineChartBarData(
              spots: diastoleList,
              isCurved: true,
              colors: bLineColors,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              /* belowBarData: BarAreaData(
                show: true,
                colors:
                    bLineColors.map((color) => color.withOpacity(0.3)).toList(),
              ), */
            ),
            LineChartBarData(
              spots: [
                FlSpot(0, 10),
                FlSpot(7, 10),
              ],
              dashArray: [2],
              isCurved: true,
              colors: [Colors.blue],
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              /* belowBarData: BarAreaData(
                show: true,
                colors: bgradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ), */
            ),
            LineChartBarData(
              spots: [
                FlSpot(0, 6),
                FlSpot(7, 6),
              ],
              dashArray: [2],
              isCurved: true,
              colors: [Colors.blue],
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              /* belowBarData: BarAreaData(
                show: true,
                colors: bgradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ), */
            ),
            LineChartBarData(
              spots: [
                FlSpot(0, 14),
                FlSpot(7, 14),
              ],
              dashArray: [2],
              isCurved: true,
              colors: [Colors.red],
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              /* belowBarData: BarAreaData(
                show: true,
                colors: bgradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ), */
            )
          ]),
    );
  }
}
