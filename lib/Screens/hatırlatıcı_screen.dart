import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Widgets/hava_durumu.dart';
import 'package:patient_tracking/Widgets/randevu_widget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../constraints.dart';

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

  void _showMaterialDialog() {}

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
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
      body: Column(
        children: [
          TopContainer(),
          Container(
            height: mq.height -
                (mq.height * 0.1 + appBar.preferredSize.height + 25),
            child: TabBarView(
              controller: _tabController,
              children: [
                RandevuWidget(),
                Weather(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: IconButton(
                onPressed: () => _showMaterialDialog(),
                icon: Icon(Icons.add, color: Colors.white),
              ),
            )
          : Container(),
    );
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
