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
    final bgsData = Provider.of<BloodGlucoseProvider>(context);
    final bgs = bgsData.bgs;
    bgs.sort((a, b) => b.date.compareTo(a.date));
    print('sj: ${bgs.length}');
    for (int i = 0; i < bgs.length; i++) {
      spots.add(FlSpot((i + 1).toDouble(), bgs[i].value.toDouble()));
    }

    return LineChart(
      LineChartData(
        minX: 0,
        minY: 0,
        maxX: bgs.length.toDouble() + 1,
        maxY: 200,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: false,
          ),
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
            isCurved: false,
            colors: [Colors.white],
            barWidth: 1.5,
            isStrokeCapRound: false,
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
