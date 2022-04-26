import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/bloodMedicine.dart';
import 'package:patient_tracking/Services/bm_service.dart';

class BloodMedicineGraph extends StatefulWidget {
  final List<BloodMedicine> bms;
  final int currentId;
  final int currentIndex;
  BloodMedicineGraph(this.bms, this.currentId, this.currentIndex);

  @override
  _BloodMedicineGraphState createState() => _BloodMedicineGraphState();
}

class _BloodMedicineGraphState extends State<BloodMedicineGraph> {
  @override
  void initState() {
    super.initState();
    /* final bmProvider =
        Provider.of<BloodMedicineProvider>(context, listen: false);
    bmProvider.getBloodMedicines(); */
    bmsFuture = fetchBms();
  }

  Future<List<BloodMedicine>> fetchBms() async {
    var bm = await BloodMedicineService.getBloodMedicines();
    return bm;
  }

  List<Map<int, List<int>>> spotsMap = [];
  List<int> distinctMedIds = [];
  int tempId = -1;
  List<FlSpot> mapListToFlSpots(List<int> values) {
    List<FlSpot> spots = [];
    for (int i = 0; i < values.length; i++) {
      spots.add(FlSpot((i + 1).toDouble(), values[i].toDouble()));
    }
    return spots;
  }

  Future<List<BloodMedicine>> bmsFuture;
  @override
  Widget build(BuildContext context) {
    widget.bms.sort((a, b) => a.createdatetime.compareTo(b.createdatetime));

    for (int i = 0; i < widget.bms.length; i++) {
      if (widget.bms[i].medId != tempId) {
        if (!distinctMedIds.contains(widget.bms[i].medId)) {
          distinctMedIds.add(widget.bms[i].medId);
        }
        tempId = widget.bms[i].medId;
      }
    }

    for (int i = 0; i < distinctMedIds.length; i++) {
      List<int> tempList = [];
      widget.bms.forEach((tempbm) {
        if (tempbm.medId == distinctMedIds[i]) {
          tempList.add(tempbm.value);
        }
      });
      spotsMap.add({distinctMedIds[i]: tempList});
    }

    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: LineChart(
        LineChartData(
          minX: 0,
          minY: 0,
          maxX: (widget.bms.length).toDouble(),
          maxY: 1000,
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
              spots: mapListToFlSpots(
                  spotsMap[widget.currentIndex][widget.currentId]),
              isCurved: false,
              colors: [Colors.white],
              barWidth: 1.5,
              isStrokeCapRound: false,
              dotData: FlDotData(
                show: true,
              ),
              /* belowBarData: BarAreaData(
              show: true,
              colors:
                  kLineColors.map((color) => color.withOpacity(0.3)).toList(),
            ) */
            ),
          ],
        ),
      ),
    );
  }
}
