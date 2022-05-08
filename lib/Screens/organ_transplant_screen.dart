import 'package:flutter/material.dart';
import 'package:patient_tracking/Widgets/karaci%C4%9Fer_info.dart';

import '../constraints.dart';

class OrganTransplantScreen extends StatefulWidget {
  static final routeName = '/organ-transplant';

  @override
  State<OrganTransplantScreen> createState() => _OrganTransplantScreenState();
}

class _OrganTransplantScreenState extends State<OrganTransplantScreen> {
  TabController _tabController;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      bottom: const TabBar(
        tabs: [
          FittedBox(
              fit: BoxFit.fitWidth, child: Tab(text: 'Karaciğer Nakli Nedir')),
          FittedBox(fit: BoxFit.fitWidth, child: Tab(text: 'Nakilden Sonra')),
        ],
      ),
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar,
        body: Column(
          children: [
            TopContainer(),
            Expanded(
              child: TabBarView(
                children: [
                  LiverInfoWidget(1),
                  LiverInfoWidget(2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.05,
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
