import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:patient_tracking/Models/bloodPressure.dart';
import 'package:patient_tracking/Providers/bloodPressure_provider.dart';
import 'package:provider/src/provider.dart';

class BloodPressureGraphDaily extends StatefulWidget {
  @override
  _BloodPressureGraphDailyState createState() =>
      _BloodPressureGraphDailyState();
}

class _BloodPressureGraphDailyState extends State<BloodPressureGraphDaily> {
  List<Color> redColors = [
    Colors.red,
  ];

  List<Color> blueColors = [
    Colors.blue,
  ];
  List<Color> orangeColors = [
    Colors.orange,
  ];

  List<Color> get kLineColors =>
      diastoleList.last.y <= 100 && diastoleList.last.y >= 60
          ? blueColors
          : redColors;
  List<Color> get bLineColors =>
      systoleList.last.y <= 140 && systoleList.last.y >= 100
          ? orangeColors
          : redColors;

  List<FlSpot> createSpots(List<int> tansiyon, List<int> times) {
    List<FlSpot> retVal = [];
    if (tansiyon.length != times.length) {
      return null;
    } else {
      for (int i = 0; i < tansiyon.length; i++) {
        retVal.add(FlSpot(
            times.elementAt(i).toDouble(), tansiyon.elementAt(i).toDouble()));
      }
    }
    return retVal;
  }

  List<Color> kgradientColors = [
    const Color(0xff23b6e6),
  ];
  List<Color> bgradientColors = [Colors.grey];
  List<FlSpot> systoleList = [];
  List<FlSpot> diastoleList = [];

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
      double time = element.time.hour + element.time.minute / 60;
      systoleList.add(FlSpot(time, element.systole));
      diastoleList.add(FlSpot(time, element.diastole));
    });
    return LineChart(
      LineChartData(
          minX: 0,
          minY: 0,
          maxX: 24,
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
                    case 4:
                      return '4:00';
                      break;
                    case 8:
                      return '8:00';
                      break;
                    case 12:
                      return '12:00';
                      break;
                    case 16:
                      return '16:00';
                      break;
                    case 20:
                      return '20:00';
                      break;
                    case 24:
                      return '00:00';
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
                FlSpot(24, 10),
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
                FlSpot(24, 6),
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
                FlSpot(24, 14),
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
