import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  final kTansiyon = [80, 70, 63, 76, 82, 90];
  final kTimes = [7, 13.6, 15.8, 17, 20, 22];
  final bTansiyon = [121, 136, 117, 120, 110, 112];
  final bTimes = [10, 11, 12, 20, 21, 22];

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
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
          minX: 0,
          minY: 0,
          maxX: 24,
          maxY: 150,
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
                if (value % 10 == 0) {
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
              spots: [
                FlSpot(9, 80),
                FlSpot(12, 77),
                FlSpot(15, 80),
                FlSpot(18, 90),
                FlSpot(21, 62),
              ],
              isCurved: true,
              colors: kgradientColors,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                colors: kgradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
            LineChartBarData(
              spots: [
                FlSpot(7, 120),
                FlSpot(9, 130),
                FlSpot(11, 116),
                FlSpot(22, 128),
                FlSpot(23, 123),
              ],
              isCurved: true,
              colors: bgradientColors,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                colors: bgradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
            LineChartBarData(
              spots: [],
              isCurved: true,
              colors: bgradientColors,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                colors: bgradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            )
          ]),
    );
  }
}
