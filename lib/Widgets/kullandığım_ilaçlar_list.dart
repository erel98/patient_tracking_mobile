import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient_tracking/Models/medicationVariantUser.dart';
import 'package:patient_tracking/Providers/medicine_provider.dart';
import 'package:patient_tracking/Services/medication_service.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:provider/provider.dart';
import '../Screens/ilaç_detay_screen.dart';

import '../global.dart';

class UsedMeds extends StatefulWidget {
  @override
  State<UsedMeds> createState() => _UsedMedsState();
}

class _UsedMedsState extends State<UsedMeds> {
  Future<bool> updateIsNotify(MedicationUser mu) async {
    bool isSuccess =
        await MedicationService.updateMyMedication(mu, mu.isNotify);
    return isSuccess;
  }

  String parseStomach(bool stomach) {
    return stomach ? 'aç karna' : 'tok karna';
  }

  @override
  void initState() {
    super.initState();
    final medProvider = Provider.of<MedicineProvider>(context, listen: false);
    medProvider.getMedicationUsers(context);
  }

  @override
  Widget build(BuildContext context) {
    final medsData = Provider.of<MedicineProvider>(context);
    final meds = medsData.medUsers;
    return meds.isNotEmpty
        ? Container(
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
                              meds[index].isNotify ? Colors.green : Colors.grey,
                          child: IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () async {
                              Global.isLoading = true;
                              meds[index].isNotify = !meds[index].isNotify;
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
                        trailing: Image.network(
                          meds[index].medication.imageUrl,
                          width: 75,
                          height: 70,
                        ),
                      ),
                    ),
                  );
                }),
          )
        : !medsData.isLoading
            ? NoDataFound('kullandığınız ilaç')
            : Container();
  }
}
