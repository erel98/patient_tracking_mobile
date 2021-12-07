import 'package:flutter/material.dart';
import 'package:patient_tracking/Widgets/hava_durumu.dart';
import 'package:patient_tracking/Widgets/randevu.dart';

class Hatirlatici extends StatefulWidget {
  static var routeName = '/hatirlatici';
  @override
  _HatirlaticiState createState() => _HatirlaticiState();
}

class _HatirlaticiState extends State<Hatirlatici>
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
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
    );
    var mq = MediaQuery.of(context).size;
    return Scaffold(
        //resizeToAvoidBottomInset: false
        appBar: appBar,
        body: TabBarView(
          controller: _tabController,
          children: [
            Randevu(),
            Weather(),
          ],
        ));
  }
}

List<Widget> get _tabs {
  return [
    Tab(
      icon: Icon(
        Icons.local_hospital,
      ),
      child: Text('Randevularım'),
    ),
    Tab(
      icon: Icon(Icons.cloud),
      child: Text('Hava durumu bildirimleri'),
    ),
  ];
}
