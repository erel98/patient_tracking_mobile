import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Models/food.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Widgets/ilaç_yemek_etkileşimi.dart';
import '../Models/medication.dart';
import '../Widgets/ilaç_ilaç_etkileşimi.dart';
import '../Widgets/yan_etkiler.dart';
import '../constraints.dart';
import '../global.dart';

class IlacDetay extends StatefulWidget {
  static const routeName = '/ilac-detay';
  @override
  _IlacDetayState createState() => _IlacDetayState();
}

class _IlacDetayState extends State<IlacDetay>
    with SingleTickerProviderStateMixin {
  int medId;
  String medName;
  List<String> sideEffects;
  List<Food> forbiddenFoods;
  List<Medication> forbiddenMeds;

  TabController _tabController;
  void _handleTabSelection() async {
    setState(() {
      Global.detailsState = _tabController.index;
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
    AppBar appBar = AppBar(
      elevation: 0,
      centerTitle: true,
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
                  children: [
                    Text(
                      medDetailsInfo,
                      style: TextStyle(height: 1.3),
                    ),
                  ],
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
      body: Column(
        children: [
          DetailsScreenTopContainer(),
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                (appBar.preferredSize.height +
                    MediaQuery.of(context).size.height * 0.1 +
                    105),
            child: TabBarView(
              controller: _tabController,
              children: [
                SideEffects(medId),
                MedToMedInteraction(medId),
                MedToFoodInteraction(medId)
              ],
            ),
          ),
          Stack(
            children: [
              Global.detailsState != 0
                  ? Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5, left: 5),
                        child: FloatingActionButton(
                          backgroundColor: kPrimaryColor,
                          child: Icon(
                            FontAwesome.arrow_left,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              _tabController
                                  .animateTo(_tabController.index - 1);
                            });
                          },
                        ),
                      ),
                    )
                  : Container(),
              _tabController.index != 2
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5, right: 5),
                        child: FloatingActionButton(
                          backgroundColor: kPrimaryColor,
                          child: Icon(
                            FontAwesome.arrow_right,
                            size: 30,
                          ),
                          onPressed: () {
                            _tabController.animateTo(_tabController.index + 1);
                          },
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailsScreenTopContainer extends StatelessWidget {
  const DetailsScreenTopContainer({
    Key key,
  }) : super(key: key);

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
      child: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05, left: 7),
        child: Row(
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                Global.detailsState == 0
                    ? 'Bilinen yan etkiler'
                    : Global.detailsState == 1
                        ? 'Beraberinde alınmaması gereken ilaçlar'
                        : 'Beraberinde tüketilmemesi gereken besinler',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
