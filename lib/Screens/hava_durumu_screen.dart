import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_tracking/Widgets/myTextField.dart';
import 'package:patient_tracking/constraints.dart';
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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 45),
              child: Text(
                'Bildirimler: ${bildirimlerAktif ? 'Aktif' : 'Kapalı'}',
                style: TextStyle(
                  color: bildirimlerAktif ? kPrimaryColor : Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Switch(
              value: bildirimlerAktif,
              activeColor: kPrimaryColor,
              onChanged: (state) {
                setState(() {
                  bildirimlerAktif = state;
                });
              },
            ),
            MyTextField(
              hintText: 'Şehir',
            ),
            /*
            Autocomplete(optionsBuilder: (TextEditingValue textEditingValue){
              if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return 
            }),
            */
            bildirimlerAktif
                ? Column(
                    children: [
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
                    ? Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: mq.width * 0.075),
                        width: mq.width * 0.35,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              saatGirildi = true;
                              _selectTime();
                            });
                          },
                          child: Text(
                            'Saat',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple),
                          ),
                        ),
                      )
                    : Container(),
                bildirimlerAktif
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: mq.width * 0.35,
                            margin: EdgeInsets.symmetric(
                                horizontal: mq.width * 0.075),
                            child: ElevatedButton(
                              onPressed: saatGirildi
                                  ? () async {
                                      if (_time == null) {
                                        var prefs = await SharedPreferences
                                            .getInstance();
                                        if (pztAktif)
                                          Global.bildirimGunleri
                                              .add(DateTime.monday);
                                        if (saliAktif)
                                          Global.bildirimGunleri
                                              .add(DateTime.tuesday);
                                        if (crsAktif)
                                          Global.bildirimGunleri
                                              .add(DateTime.wednesday);
                                        if (prsAktif)
                                          Global.bildirimGunleri
                                              .add(DateTime.thursday);
                                        if (cumaAktif)
                                          Global.bildirimGunleri
                                              .add(DateTime.friday);
                                        if (ctsAktif)
                                          Global.bildirimGunleri
                                              .add(DateTime.saturday);
                                        if (pzrAktif)
                                          Global.bildirimGunleri
                                              .add(DateTime.sunday);
                                        Global.setBildirimGunleri();

                                        var _bildirimSaati =
                                            Time(_time.hour, _time.minute);
                                        Global.bildirimSaati = _bildirimSaati;

                                        print(
                                            'prefs pazartesi: ${prefs.getBool('isPazartesi')}');
                                        print(
                                            'prefs salı: ${prefs.getBool('isSali')}');
                                        print(
                                            'prefs çarşamba: ${prefs.getBool('isCarsamba')}');
                                        print(
                                            'prefs perşembe: ${prefs.getBool('isPersembe')}');
                                        print(
                                            'prefs cuma: ${prefs.getBool('isCuma')}');
                                        print(
                                            'prefs cumartesi: ${prefs.getBool('isCumartesi')}');
                                        print(
                                            'prefs pazar: ${prefs.getBool('isPazar')}');
                                        print(
                                            'prefs bildirim saati: ${prefs.getInt('bildirim-saat')}');
                                        print(
                                            'prefs bildirim dakikası: ${prefs.getBool('bildirim-dakika')}');
                                      } else {
                                        setState(() {
                                          hataText = true;
                                        });
                                      }
                                    }
                                  : () => showAlertDialog(context),
                              child: Text(
                                'Kaydet',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  saatGirildi
                                      ? Colors.purple
                                      : Colors.purple.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
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
