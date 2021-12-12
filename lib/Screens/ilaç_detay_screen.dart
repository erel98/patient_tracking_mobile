import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Models/food.dart';
import 'package:patient_tracking/Models/medicineVariant.dart';
import 'package:patient_tracking/Widgets/ila%C3%A7_yemek_etkile%C5%9Fimi.dart';
import 'package:patient_tracking/Widgets/topContainer.dart';
import '../Models/medicine.dart';
import '../Widgets/ilaç_ilaç_etkileşimi.dart';
import 'package:patient_tracking/Providers/medicine_provider.dart';
import 'package:provider/provider.dart';
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
  List<Medicine> forbiddenMeds;

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
    final medsData = context.watch<MedicineProvider>();
    final meds = medsData.medVariants;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, int>;
    medId = routeArgs['medId'] as int;
    // print('medId from detay: $medId');
    for (MedicationVariant med in meds) {
      if (med.id == medId) {
        medName = med.name;
        sideEffects = med.medication.sideEffects;
        forbiddenFoods = med.medication.forbiddenFoods;
        forbiddenMeds = med.medication.forbiddenMeds;
      }
    }
    AppBar appBar = AppBar(
      elevation: 0,
      title: Text(
        medName,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
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
