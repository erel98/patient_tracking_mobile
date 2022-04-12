import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Providers/dailyMeds_provider.dart';
import 'package:patient_tracking/Widgets/g%C3%BCnl%C3%BCk_ila%C3%A7lar.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DailyMedsScreen extends StatefulWidget {
  static final routeName = '/daily-meds';

  @override
  _DailyMedsScreenState createState() => _DailyMedsScreenState();
}

class _DailyMedsScreenState extends State<DailyMedsScreen>
    with TickerProviderStateMixin {
  int _currentIndex = DateTime.now().weekday - 1;
  List<Widget> widgets = [];
  List<Tab> tabs = [];
  TabController _tabController;

  void _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  Future<void> getDailyMeds() async {
    var dailymedsprovider =
        Provider.of<DailyMedsProvider>(context, listen: false);
    await dailymedsprovider.getDailyMeds();
  }

  void initState() {
    super.initState();
    getDailyMeds();
    //getDailyMeds();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dailyMedsData = Provider.of<DailyMedsProvider>(context);
    var calendarDays = dailyMedsData.calendarDays;

    tabs.clear();
    widgets.clear();
    calendarDays.forEach((element) {
      String dayName = '';
      if (element.dayValue == 1) {
        dayName = 'Pzt';
      } else if (element.dayValue == 2) {
        dayName = 'Sal';
      } else if (element.dayValue == 3) {
        dayName = 'Çrş';
      } else if (element.dayValue == 4) {
        dayName = 'Prş';
      } else if (element.dayValue == 5) {
        dayName = 'Cum';
      } else if (element.dayValue == 6) {
        dayName = 'Cts';
      } else if (element.dayValue == 7) {
        dayName = 'Pzr';
      }
      var widget = DailyMeds(element);
      var tab = Tab(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            dayName,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
      widgets.add(widget);
      tabs.add(tab);
    });
    _tabController = getTabController();
    _updatePage();

    final appBar = AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: calendarDays.length < 1
            ? Container()
            : TabBar(
                indicatorColor: Colors.black,
                controller: _tabController,
                tabs: tabs,
              ),
      ),
      actions: [
        FittedBox(
          fit: BoxFit.fitHeight,
          child: IconButton(
            icon: Icon(
              FontAwesome5.question_circle,
              color: Colors.white,
            ),
            onPressed: () => Alert(
                context: context,
                content: Column(
                  children: [Text(dailyMedsInfo)],
                ),
                buttons: [
                  DialogButton(
                      color: kPrimaryColor,
                      child: Text(
                        'Anladım',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.of(context).pop())
                ]).show(),
          ),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: calendarDays.length < 1
          ? Container()
          : Column(
              children: [
                TopContainer(),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: widgets,
                  ),
                ),
              ],
            ),
    );
  }

  TabController getTabController() {
    return TabController(
        length: tabs.length, initialIndex: _currentIndex, vsync: this)
      ..addListener(_handleTabSelection);
  }

  void _updatePage() {
    setState(() {});
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.05,
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
