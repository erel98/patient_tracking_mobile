import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/food.dart';
import 'package:patient_tracking/Widgets/topContainer.dart';
import '../Models/medicine.dart';
import '../Widgets/ilaç_ilaç_etkileşimi.dart';
import 'package:patient_tracking/Providers/medicines.dart';
import 'package:provider/provider.dart';
import '../Widgets/yan_etkiler.dart';

class IlacDetay extends StatefulWidget {
  static const routeName = '/ilac-detay';
  @override
  _IlacDetayState createState() => _IlacDetayState();
}

class _IlacDetayState extends State<IlacDetay>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int medId;
  String medName;
  List<String> sideEffects;
  List<Food> forbiddenFoods;
  List<Medicine> forbiddenMeds;

  TabController _tabController;
  void _handleTabSelection() async {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medsData = Provider.of<Medicines>(context);
    final meds = medsData.meds;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, int>;
    medId = routeArgs['medId'] as int;
    print('medId from detay: $medId');
    for (Medicine med in meds) {
      if (med.id == medId) {
        medName = med.name;
        sideEffects = med.sideEffects;
        forbiddenFoods = med.forbiddenFoods;
        forbiddenMeds = med.forbiddenMeds;
      }
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [TopContainer()],
      ),
    );
  }
}
