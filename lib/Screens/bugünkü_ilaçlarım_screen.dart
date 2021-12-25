import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Models/calendarDay.dart';
import 'package:patient_tracking/Models/calendarEvent.dart';
import 'package:patient_tracking/Models/dailyMedication.dart';
import 'package:patient_tracking/Models/medication.dart';
import 'package:patient_tracking/Providers/dailyMeds_provider.dart';
import 'package:patient_tracking/Providers/medicine_provider.dart';
import 'package:patient_tracking/Services/medication_service.dart';
import 'package:patient_tracking/Widgets/g%C3%BCnl%C3%BCk_ila%C3%A7lar.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:provider/provider.dart';
import '../BildirimAPI.dart';

class DailyMedsScreen extends StatefulWidget {
  static final routeName = '/daily-meds';

  @override
  _DailyMedsScreenState createState() => _DailyMedsScreenState();
}

class _DailyMedsScreenState extends State<DailyMedsScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _tabController;

  void _handleTabSelection() async {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  Future<void> getDailyMeds() async {
    var dailymedsprovider =
        Provider.of<DailyMedsProvider>(context, listen: false);
    dailymedsprovider.getDailyMeds();
  }

  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(_handleTabSelection);
    var dailymedsprovider =
        Provider.of<DailyMedsProvider>(context, listen: false);
    dailymedsprovider.getDailyMeds();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dailyMedsData = context.watch<DailyMedsProvider>();

    final appBar = AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: TabBar(
          indicatorColor: Colors.black,
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          TopContainer(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                DailyMeds(dailyMedsData.monday),
                DailyMeds(dailyMedsData.tuesday),
                DailyMeds(dailyMedsData.wednesday),
                DailyMeds(dailyMedsData.thursday),
                DailyMeds(dailyMedsData.friday),
                DailyMeds(dailyMedsData.saturday),
                DailyMeds(dailyMedsData.sunday),
              ],
            ),
          ),
        ],
      ),
      /* floatingActionButton: FloatingActionButton(
        child: CircleAvatar(backgroundColor: kPrimaryColor),
        onPressed: () async {
          await BildirimAPI.showScheduledNotification(
              title: 'denemece', body: 'denemece2');
        },
      ), */
    );
  }

  List<Widget> get _tabs {
    return [
      Tab(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Pzt',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Tab(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Salı',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Tab(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Çrş',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Tab(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Prş',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Tab(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Cum',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Tab(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Cts',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Tab(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Pzr',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ];
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
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
