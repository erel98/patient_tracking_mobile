import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/food.dart';
import '../dummy_data.dart';
import '../Models/medicine.dart';
import '../Widgets/ilaçilaçetkileşimi.dart';

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
  String sideEffect;
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
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, int>;
    medId = routeArgs['medId'] as int;
    for (Medicine med in DUMMY_MEDS) {
      if (med.id == medId) {
        medName = med.name;
        sideEffect = med.sideEffect;
        forbiddenFoods = med.forbiddenFoods;
        forbiddenMeds = med.forbiddenMeds;
      }
    }
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(medName),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.orange,
                tabs: [
                  Tab(text: 'Yan etkiler'),
                  Tab(text: 'Tüketilmemesi gereken ilaçlar'),
                  Tab(text: 'Tüketilmemesi gereken besinler')
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [Container(), MedToMedInteraction(), Container()],
          ),
        ));
  }
}
