import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HavaDurumu extends StatefulWidget {
  static const routeName = '/hava-durumu';

  @override
  _HavaDurumuState createState() => _HavaDurumuState();
}

class _HavaDurumuState extends State<HavaDurumu> {
  TimeOfDay _time;
  void _selectTime() async {
    _time = TimeOfDay(hour: 7, minute: 0);
    final TimeOfDay newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      helpText: 'Saat seçiniz',
      cancelText: 'İptal',
      confirmText: 'Onayla',
      hourLabelText: '',
      minuteLabelText: '',
      errorInvalidText:
          'Lütfen 12 saatlik dilime göre giriniz. Öğleden önce için AM, öğleden sonra için PM seçiniz',
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  DateTime bildirimSaati;
  bool bildirimlerAktif = false;
  bool pztAktif = false;
  bool saliAktif = false;
  bool crsAktif = false;
  bool prsAktif = false;
  bool cumaAktif = false;
  bool ctsAktif = false;
  bool pzrAktif = false;
  bool saatGirildi = false;
  bool hataText = false;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 45),
            child: Text(
              'Bildirimler: ${bildirimlerAktif ? 'Aktif' : 'Kapalı'}',
              style: TextStyle(
                color: bildirimlerAktif
                    ? Theme.of(context).colorScheme.background
                    : Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Switch(
            value: bildirimlerAktif,
            activeColor: Theme.of(context).colorScheme.background,
            onChanged: (state) {
              setState(() {
                bildirimlerAktif = state;
              });
            },
          ),
          SizedBox(
            height: mq.height * 0.05,
          ),
          bildirimlerAktif
              ? Column(
                  children: [
                    Container(
                      height: mq.height * 0.2,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                pztAktif = !pztAktif;
                              });
                            },
                            child: Container(
                              width: mq.width * 0.25,
                              height: mq.height * 0.2,
                              decoration: BoxDecoration(
                                color: pztAktif ? Colors.green : Colors.grey,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Pazatesi',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  Checkbox(
                                      value: pztAktif,
                                      onChanged: (value) {
                                        setState(() {
                                          pztAktif = value;
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                saliAktif = !saliAktif;
                              });
                            },
                            child: Container(
                              width: mq.width * 0.25,
                              decoration: BoxDecoration(
                                  color: saliAktif ? Colors.green : Colors.grey,
                                  border: Border.all(
                                    color: Colors.black,
                                  )),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Salı',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  Checkbox(
                                      value: saliAktif,
                                      onChanged: (value) {
                                        setState(() {
                                          saliAktif = value;
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                crsAktif = !crsAktif;
                              });
                            },
                            child: Container(
                              width: mq.width * 0.25,
                              decoration: BoxDecoration(
                                  color: crsAktif ? Colors.green : Colors.grey,
                                  border: Border.all(
                                    color: Colors.black,
                                  )),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Çarşamba',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  Checkbox(
                                      value: crsAktif,
                                      onChanged: (value) {
                                        setState(() {
                                          crsAktif = value;
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                prsAktif = !prsAktif;
                              });
                            },
                            child: Container(
                              width: mq.width * 0.25,
                              decoration: BoxDecoration(
                                  color: prsAktif ? Colors.green : Colors.grey,
                                  border: Border.all(
                                    color: Colors.black,
                                  )),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Perşembe',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  Checkbox(
                                      value: prsAktif,
                                      onChanged: (value) {
                                        setState(() {
                                          prsAktif = value;
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          cumaAktif = !cumaAktif;
                        });
                      },
                      child: Container(
                        height: mq.height * 0.2,
                        child: Row(
                          children: [
                            Container(
                              width: mq.width * 0.33333,
                              decoration: BoxDecoration(
                                  color: cumaAktif ? Colors.green : Colors.grey,
                                  border: Border.all(
                                    color: Colors.black,
                                  )),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Cuma',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  Checkbox(
                                      value: cumaAktif,
                                      onChanged: (value) {
                                        setState(() {
                                          cumaAktif = value;
                                        });
                                      }),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  ctsAktif = !ctsAktif;
                                });
                              },
                              child: Container(
                                width: mq.width * 0.33333,
                                decoration: BoxDecoration(
                                    color:
                                        ctsAktif ? Colors.green : Colors.grey,
                                    border: Border.all(
                                      color: Colors.black,
                                    )),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Cumartesi',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Checkbox(
                                        value: ctsAktif,
                                        onChanged: (value) {
                                          setState(() {
                                            ctsAktif = value;
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  pzrAktif = !pzrAktif;
                                });
                              },
                              child: Container(
                                width: mq.width * 0.33333,
                                decoration: BoxDecoration(
                                    color:
                                        pzrAktif ? Colors.green : Colors.grey,
                                    border: Border.all(
                                      color: Colors.black,
                                    )),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Pazar',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Checkbox(
                                        value: pzrAktif,
                                        onChanged: (value) {
                                          setState(() {
                                            pzrAktif = value;
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          SizedBox(
            height: mq.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              bildirimlerAktif
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          saatGirildi = true;
                          _selectTime();
                        });
                      },
                      child: Text('Saat'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary),
                      ),
                    )
                  : Container(),
              bildirimlerAktif
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (_time == null) {
                              var prefs = await SharedPreferences.getInstance();
                              if (pztAktif)
                                Global.bildirimGunleri.add(DateTime.monday);
                              if (saliAktif)
                                Global.bildirimGunleri.add(DateTime.tuesday);
                              if (crsAktif)
                                Global.bildirimGunleri.add(DateTime.wednesday);
                              if (prsAktif)
                                Global.bildirimGunleri.add(DateTime.thursday);
                              if (cumaAktif)
                                Global.bildirimGunleri.add(DateTime.friday);
                              if (ctsAktif)
                                Global.bildirimGunleri.add(DateTime.saturday);
                              if (pzrAktif)
                                Global.bildirimGunleri.add(DateTime.sunday);
                              Global.setBildirimGunleri();

                              var _bildirimSaati =
                                  Time(_time.hour, _time.minute);
                              Global.bildirimSaati = _bildirimSaati;

                              print(
                                  'prefs pazartesi: ${prefs.getBool('isPazartesi')}');
                              print('prefs salı: ${prefs.getBool('isSali')}');
                              print(
                                  'prefs çarşamba: ${prefs.getBool('isCarsamba')}');
                              print(
                                  'prefs perşembe: ${prefs.getBool('isPersembe')}');
                              print('prefs cuma: ${prefs.getBool('isCuma')}');
                              print(
                                  'prefs cumartesi: ${prefs.getBool('isCumartesi')}');
                              print('prefs pazar: ${prefs.getBool('isPazar')}');
                              print(
                                  'prefs bildirim saati: ${prefs.getInt('bildirim-saat')}');
                              print(
                                  'prefs bildirim dakikası: ${prefs.getBool('bildirim-dakika')}');
                            } else {
                              setState(() {
                                hataText = true;
                              });
                            }
                          },
                          child: Text('Kaydet'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        hataText
                            ? Text(
                                'Lütfen saat giriniz',
                                style: TextStyle(color: Colors.red),
                              )
                            : Container()
                      ],
                    )
                  : Container()
            ],
          ),
        ],
      ),
    );
  }
}
