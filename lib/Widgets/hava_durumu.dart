import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Models/place.dart';
import 'package:patient_tracking/Services/places_service.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../BildirimAPI.dart';
import '../global.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Weather extends StatefulWidget {
  final List<String> placeNames;
  Weather(this.placeNames);
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  TimeOfDay _time;
  List<int> weatherDays = [];
  final saatController = TextEditingController();
  DateTime bildirimSaati;
  bool pztAktif = false;
  bool saliAktif = false;
  bool crsAktif = false;
  bool prsAktif = false;
  bool cumaAktif = false;
  bool ctsAktif = false;
  bool pzrAktif = false;
  bool saatGirildi = false;
  bool hataText = false;
  String dropdownValue;

  Future<void> _selectTime() async {
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
      //print('new time: ${newTime.hour}:${newTime.minute}');
      _time = newTime;
      saatController.text =
          '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.of(context).pop(),
    );

    AlertDialog alert = AlertDialog(
      title: Text("Hata!"),
      content: Text("Lütfen saat giriniz."),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initWeatherData();
  }

  void initWeatherData() async {
    var prefs = await SharedPreferences.getInstance();
    pztAktif = prefs.getBool('isPazartesi') ?? false;
    saliAktif = prefs.getBool('isSali') ?? false;
    crsAktif = prefs.getBool('isCarsamba') ?? false;
    prsAktif = prefs.getBool('isPersembe') ?? false;
    cumaAktif = prefs.getBool('isCuma') ?? false;
    ctsAktif = prefs.getBool('isCumartesi') ?? false;
    pzrAktif = prefs.getBool('isPazar') ?? false;
    bildirimSaati = DateTime(
        prefs.getInt('bildirim-saat') ?? DateTime.now().hour,
        prefs.getInt('bildirim-minute') ?? DateTime.now().minute);
    saatController.text =
        '${bildirimSaati.hour.toString().padLeft(2, '0')}:${bildirimSaati.minute.toString().padLeft(2, '0')}';
    dropdownValue = prefs.getString('city') ?? widget.placeNames.first;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Bulunduğunuz ilçe:',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String newVal) {
                  setState(() {
                    dropdownValue = newVal;
                  });
                },
                items: widget.placeNames
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              pztAktif = !pztAktif;
            });
          },
          child: WeekDay(
            pztAktif ? kPrimaryColor : Colors.grey,
            'Pazartesi',
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              saliAktif = !saliAktif;
            });
          },
          child: WeekDay(
            saliAktif ? kPrimaryColor : Colors.grey,
            'Salı',
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              crsAktif = !crsAktif;
            });
          },
          child: WeekDay(
            crsAktif ? kPrimaryColor : Colors.grey,
            'Çarşamba',
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              prsAktif = !prsAktif;
            });
          },
          child: WeekDay(
            prsAktif ? kPrimaryColor : Colors.grey,
            'Perşembe',
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              cumaAktif = !cumaAktif;
            });
          },
          child: WeekDay(
            cumaAktif ? kPrimaryColor : Colors.grey,
            'Cuma',
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              ctsAktif = !ctsAktif;
            });
          },
          child: WeekDay(
            ctsAktif ? kPrimaryColor : Colors.grey,
            'Cumartesi',
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              pzrAktif = !pzrAktif;
            });
          },
          child: WeekDay(
            pzrAktif ? kPrimaryColor : Colors.grey,
            'Pazar',
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 30),
          width: mq.width * 0.5,
          child: TextField(
            controller: saatController,
            readOnly: true,
            showCursor: true,
            decoration: InputDecoration(
                icon: Icon(
              FontAwesome5.clock,
              color: Colors.black,
            )),
            onTap: () {
              setState(() async {
                saatGirildi = true;
                await _selectTime();
                //print('şuan time: $_time');
              });
            },
          ),
        ),
        Container(
          width: mq.width * 0.6,
          child: ElevatedButton(
            onPressed: saatGirildi
                ? () async {
                    if (_time != null) {
                      //print('başladı');
                      var prefs = await SharedPreferences.getInstance();
                      if (pztAktif) {
                        Global.bildirimGunleri.add(DateTime.monday);
                        weatherDays.add(1);
                        //print('pzt ekledi');
                      }

                      if (saliAktif) {
                        Global.bildirimGunleri.add(DateTime.tuesday);
                        weatherDays.add(2);
                        //print('salı ekledi');
                      }
                      if (crsAktif) {
                        Global.bildirimGunleri.add(DateTime.wednesday);
                        weatherDays.add(3);
                        //print('çrş ekledi');
                      }

                      if (prsAktif) {
                        Global.bildirimGunleri.add(DateTime.thursday);
                        weatherDays.add(4);
                        //print('prş ekledi');
                      }

                      if (cumaAktif) {
                        Global.bildirimGunleri.add(DateTime.friday);
                        weatherDays.add(5);
                        //print('cuma ekledi');
                      }

                      if (ctsAktif) {
                        Global.bildirimGunleri.add(DateTime.saturday);
                        weatherDays.add(6);
                        //print('cts ekledi');
                      }

                      if (pzrAktif) {
                        Global.bildirimGunleri.add(DateTime.sunday);
                        weatherDays.add(7);
                        //print('pzr ekledi');
                      }
                      Global.setBildirimGunleri();
                      BildirimAPI.scheduleWeekly(Time(_time.hour, _time.minute),
                          days: weatherDays);
                      prefs.setString('city', dropdownValue);
                      /* //print(
                                    'prefs pazartesi: ${prefs.getBool('isPazartesi')}');
                                //print('prefs salı: ${prefs.getBool('isSali')}');
                                //print(
                                    'prefs çarşamba: ${prefs.getBool('isCarsamba')}');
                                //print(
                                    'prefs perşembe: ${prefs.getBool('isPersembe')}');
                                //print('prefs cuma: ${prefs.getBool('isCuma')}');
                                //print(
                                    'prefs cumartesi: ${prefs.getBool('isCumartesi')}');
                                //print('prefs pazar: ${prefs.getBool('isPazar')}');
                                //print(
                                    'prefs bildirim saati: ${prefs.getInt('bildirim-saat')}');
                                //print(
                                    'prefs bildirim dakikası: ${prefs.getBool('bildirim-dakika')}'); */
                    } else {
                      //print('time null dedi');
                      setState(() {
                        hataText = true;
                      });
                    }
                  }
                : () => showAlertDialog(context),
            child: Text(
              'Kaydet',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                saatGirildi ? Colors.purple : Colors.purple.withOpacity(0.6),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WeekDay extends StatelessWidget {
  final Color color;
  final String day;
  WeekDay(this.color, this.day);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 40,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          day,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
