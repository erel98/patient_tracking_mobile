import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient_tracking/Models/otherMedication.dart';
import 'package:patient_tracking/Providers/otherMedication_provider.dart';
import 'package:patient_tracking/Screens/othermeds_detail_screen.dart';
import 'package:patient_tracking/Services/otherMedication_service.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
import 'package:provider/provider.dart';

import '../constraints.dart';

class OtherUsedMeds extends StatefulWidget {
  @override
  State<OtherUsedMeds> createState() => _OtherUsedMedsState();
}

class _OtherUsedMedsState extends State<OtherUsedMeds> {
  Future<bool> updateIsNotify(OtherMedication om) async {
    bool isSuccess =
        await OtherMedicationService.updateMyMedication(om, om.isNotify);
    return isSuccess;
  }

  @override
  void initState() {
    super.initState();
    final otherMedProvider =
        Provider.of<OtherMedicineProvider>(context, listen: false);
    otherMedProvider.getOtherMedications();
  }

  @override
  Widget build(BuildContext context) {
    final otherMedsData = Provider.of<OtherMedicineProvider>(context);
    final otherMeds = otherMedsData.otherMeds;
    return otherMeds.isNotEmpty
        ? Container(
            margin: EdgeInsets.only(top: 10),
            child: ListView.separated(
                itemCount: otherMeds.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 20,
                  );
                },
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: kPrimaryColor.withOpacity(0.23),
                          ),
                        ]),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        OtherMedsDetails.routeName,
                        arguments: {'medId': otherMeds[index].id},
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: otherMeds[index].isNotify
                              ? Colors.green
                              : Colors.grey,
                          child: IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () async {
                              otherMeds[index].isNotify =
                                  !otherMeds[index].isNotify;
                              var isSuccess =
                                  await updateIsNotify(otherMeds[index]);

                              if (isSuccess) {
                                otherMedsData.update(otherMeds[index]);
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Hay aksi! Bir şeyler ters gitti');
                              }
                            },
                          ),
                        ),
                        title: Text(
                          otherMeds[index].name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        /*trailing: Image.network(
                          otherMeds[index].medication.imageUrl,
                          width: 75,
                          height: 70,
                        ),*/
                      ),
                    ),
                  );
                }),
          )
        : NoDataFound('kullandığınız diğer ilaç');
  }
}
