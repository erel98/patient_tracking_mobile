import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/bloodGlucose_provider.dart';
import 'package:provider/provider.dart';

class BloodGlucoseDailyGraph extends StatefulWidget {
  @override
  _BloodGlucoseDailyGraphState createState() => _BloodGlucoseDailyGraphState();
}

class _BloodGlucoseDailyGraphState extends State<BloodGlucoseDailyGraph> {
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
        maxX: 24,
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
