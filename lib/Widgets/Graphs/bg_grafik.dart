import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/bloodGlucose_provider.dart';
import 'package:provider/provider.dart';

class BloodGlucoseGraph extends StatefulWidget {
  @override
  _BloodGlucoseGraphState createState() => _BloodGlucoseGraphState();
}

class _BloodGlucoseGraphState extends State<BloodGlucoseGraph> {
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
    var bgsData = Provider.of<BloodGlucoseProvider>(context);
    var bgs = bgsData.bgs;
    spots.clear();
    bgs.sort((a, b) => a.date.compareTo(b.date));
    for (int i = 0; i < bgs.length; i++) {
      spots.add(FlSpot((i + 1).toDouble(), bgs[i].value.toDouble()));
    }

    return LineChart(
      LineChartData(
        minX: 0,
        minY: 0,
        maxX: bgs.length.toDouble() + 1,
        maxY: 800,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: false,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (BuildContext context, value) => const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 8),
            getTitles: (value) {
              if (value % 100 == 0 && value != 0) {
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
            isCurved: false,
            colors: [Colors.white],
            barWidth: 1.5,
            isStrokeCapRound: false,
            dotData: FlDotData(
              show: true,
            ),
          ),
          LineChartBarData(
            spots: [
              FlSpot(0, 180),
              FlSpot((bgs.length + 1).toDouble(), 180),
            ],
            dashArray: [2],
            isCurved: false,
            colors: [Colors.red],
            barWidth: 1,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
          ),
          LineChartBarData(
            spots: [
              FlSpot(0, 100),
              FlSpot((bgs.length + 1).toDouble(), 100),
            ],
            dashArray: [2],
            isCurved: false,
            colors: [Colors.blue.shade200],
            barWidth: 1,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
          )
        ],
      ),
    );
  }
}
