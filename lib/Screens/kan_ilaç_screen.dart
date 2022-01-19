import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/bloodMedicine_provider.dart';
import 'package:patient_tracking/Widgets/Graphs/bm_grafik.dart';
import 'package:provider/provider.dart';

import '../constraints.dart';

class BloodMedicineScreen extends StatefulWidget {
  static final routeName = '/blood-medicine';

  @override
  _BloodMedicineScreenState createState() => _BloodMedicineScreenState();
}

class _BloodMedicineScreenState extends State<BloodMedicineScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _tabController;
  List<Widget> widgets = [];
  List<Tab> tabs = [];

  void _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  TabController getTabController() {
    return TabController(
        length: tabs.length, initialIndex: _currentIndex, vsync: this)
      ..addListener(_handleTabSelection);
  }

  void _updatePage() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    final bmProvider =
        Provider.of<BloodMedicineProvider>(context, listen: false);
    bmProvider.getBloodMedicines();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int tempId = -1;
  List<int> distinctMedIds = [];
  @override
  Widget build(BuildContext context) {
    final bmProvider = Provider.of<BloodMedicineProvider>(context);
    var bms = bmProvider.bms;
    bms.sort((a, b) => a.createdatetime.compareTo(b.createdatetime));

    for (int i = 0; i < bms.length; i++) {
      if (bms[i].medId != tempId) {
        if (!distinctMedIds.contains(bms[i].medId)) {
          distinctMedIds.add(bms[i].medId);
        }
        tempId = bms[i].medId;
      }
    }
    tabs.clear();
    widgets.clear();
    for (int i = 0; i < distinctMedIds.length; i++) {
      var tab = Tab(
          child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          bms
              .where((element) => element.medId == distinctMedIds[i])
              .first
              .medName,
        ),
      ));
      var widget = Container(
          margin: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: 1,
          padding: EdgeInsets.only(top: 30, bottom: 10, right: 10),
          decoration: const BoxDecoration(
            color: Color(0xff232d37),
          ),
          child: BloodMedicineGraph(bms, distinctMedIds[i], i));
      widgets.add(widget);
      tabs.add(tab);
    }
    _tabController = getTabController();
    _updatePage();
    final appBar = AppBar(
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: bms.length < 1
            ? Container()
            : TabBar(
                indicatorColor: Colors.black,
                controller: _tabController,
                tabs: tabs,
              ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: bms.length < 1
          ? Container()
          : Column(
              children: [
                TopContainer(),
                Expanded(
                  child:
                      TabBarView(controller: _tabController, children: widgets),
                ),
              ],
            ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: kPrimaryColor),
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
