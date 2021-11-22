import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/calendarDay.dart';
import 'package:patient_tracking/Models/calendarEvent.dart';
import 'package:patient_tracking/Models/medicine.dart';
import 'package:patient_tracking/Providers/medicines.dart';
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

  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
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

    List<CalendarEvent> mondayEvents = [
      CalendarEvent(1, 7, [meds[1]]),
      CalendarEvent(2, 9, [meds[0]]),
      CalendarEvent(3, 19, [meds[1]]),
      CalendarEvent(4, 21, [meds[0]]),
    ];
    CalendarDay monday = CalendarDay(1, 1, mondayEvents);

    List<CalendarEvent> tuesdayEvents = [
      CalendarEvent(5, 8, [meds[2], meds[3]]),
      CalendarEvent(7, 16, [meds[2]]),
      CalendarEvent(8, 0, [meds[2]]),
      CalendarEvent(9, 20, [meds[3]]),
    ];
    CalendarDay tuesday = CalendarDay(2, 2, tuesdayEvents);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: TabBar(
              indicatorColor: Colors.black,
              controller: _tabController,
              tabs: _tabs,
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            DailyMeds(monday),
            DailyMeds(tuesday),
            DailyMeds(tuesday),
            DailyMeds(tuesday),
            DailyMeds(tuesday),
            DailyMeds(tuesday),
            DailyMeds(tuesday),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: CircleAvatar(backgroundColor: kPrimaryColor),
          onPressed: () async {
            await BildirimAPI.showScheduledNotification(
                title: 'denemece', body: 'denemece2');
          },
        ));
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
