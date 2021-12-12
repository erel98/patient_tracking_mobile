import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient_tracking/Models/medicineVariant.dart';
import 'package:patient_tracking/Providers/medicine_provider.dart';
import 'package:patient_tracking/Services/medication_service.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:provider/provider.dart';
import 'package:patient_tracking/Screens/ila%C3%A7_detay_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../global.dart';

class UsedMeds extends StatefulWidget {
  @override
  State<UsedMeds> createState() => _UsedMedsState();
}

class _UsedMedsState extends State<UsedMeds> {
  Future<bool> updateIsNotify(MedicationVariant mv) async {
    bool isSuccess = await MedicationService.updateMedication(mv);
    return isSuccess;
  }

  String parseStomach(bool stomach) {
    return stomach ? 'aç karna' : 'tok karna';
  }

  @override
  Widget build(BuildContext context) {
    //Main.dart'ta oluşturduğumuz provider'a listener ekliyoruz.
    final medsData = context.watch<MedicineProvider>();
    final meds = medsData.medVariants;
    // print('kil 190 ${meds.first.name}');
    return LoadingOverlay(
      isLoading: Global.isLoading,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.separated(
            itemCount: meds.length,
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
                    IlacDetay.routeName,
                    arguments: {'medId': meds[index].id},
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          meds[index].medicationVariantUser.isNotify
                              ? Colors.green
                              : Colors.grey,
                      child: IconButton(
                        icon: Icon(Icons.notifications),
                        onPressed: () async {
                          Global.isLoading = true;
                          meds[index].medicationVariantUser.isNotify =
                              !meds[index].medicationVariantUser.isNotify;
                          var isSuccess = await updateIsNotify(meds[index]);

                          if (isSuccess) {
                            Global.isLoading = false;
                            medsData.update(meds[index]);
                          } else {
                            Global.isLoading = false;
                            Fluttertoast.showToast(
                                msg: 'Hay aksi! Bir şeyler ters gitti');
                          }
                        },
                      ),
                    ),
                    title: Text(
                      meds[index].medication.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      '${parseStomach(meds[index].medication.stomach)}',
                      style: TextStyle(color: Colors.grey, fontSize: 17),
                    ),
                    trailing: Image.asset(
                      'assets/icons/test-ilac.jpg',
                      width: 75,
                      height: 70,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
