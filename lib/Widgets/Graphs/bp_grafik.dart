import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:patient_tracking/Providers/bloodPressure_provider.dart';
import 'package:provider/src/provider.dart';

class BloodPressureGraph extends StatefulWidget {
  @override
  _BloodPressureGraphState createState() => _BloodPressureGraphState();
}

class _BloodPressureGraphState extends State<BloodPressureGraph> {
  List<Color> redColors = [
    Colors.red,
  ];

  List<Color> blueColors = [
    Colors.blue,
  ];
  List<Color> orangeColors = [
    Colors.orange,
  ];

  List<Color> get kLineColors => blueColors;

  List<Color> get bLineColors => orangeColors;

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
    systoleList.clear();
    diastoleList.clear();
    for (int i = 0; i < bps.length; i++) {
      systoleList.add(FlSpot((i + 1).toDouble(), bps[i].systole));
      diastoleList.add(FlSpot((i + 1).toDouble(), bps[i].diastole));
    }
    return LineChart(
      LineChartData(
          minX: 0,
          minY: 0,
          maxX: bps.length.toDouble(),
          maxY: 15,
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: false,
            ),
            leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (BuildContext context, value) => const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 10),
              getTitles: (value) {
                if (value % 2 == 0 && value != 0) {
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
              isCurved: false,
              colors: bLineColors,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
            ),
            LineChartBarData(
              spots: diastoleList,
              isCurved: false,
              colors: kLineColors,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
            ),
            LineChartBarData(
              spots: [
                FlSpot(0, 10),
                FlSpot(bps.length.toDouble(), 10),
              ],
              dashArray: [2],
              isCurved: false,
              colors: [Colors.blue],
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
            ),
            LineChartBarData(
              spots: [
                FlSpot(0, 6),
                FlSpot(bps.length.toDouble(), 6),
              ],
              dashArray: [2],
              isCurved: false,
              colors: [Colors.blue],
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
            ),
            LineChartBarData(
              spots: [
                FlSpot(0, 14),
                FlSpot(bps.length.toDouble(), 14),
              ],
              dashArray: [2],
              isCurved: false,
              colors: [Colors.red],
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
            )
          ]),
    );
  }
}
