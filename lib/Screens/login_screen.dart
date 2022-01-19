import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient_tracking/Services/patient_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constraints.dart';
import '../global.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = '/login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

//phone_number
//password
//dotenv.env['API_URL'];
class _LoginScreenState extends State<LoginScreen> {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Global.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                TopContainer(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Hoşgeldiniz!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 100, left: 10),
                  child: Text(
                    '*Lütfen devam etmek için telefon numaranız ve size verilen şifre ile giriş yapın',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 54,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.05)),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-1, 1),
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.23),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      label: Text('telefon'),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      //hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: kPrimaryColor.withOpacity(0.5),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 54,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.05)),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-1, 1),
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.23),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text('Şifre'),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      //hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: kPrimaryColor.withOpacity(0.5),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                      backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    ),
                    onPressed: () async {
                      // setState(() {
                      //   Global.isLoading = true;
                      // });
                      //EasyLoading.show(status: 'loading...');
                      var phoneNumber = phoneController.text;
                      var password = passwordController.text;
                      if (phoneNumber.isNotEmpty && password.isNotEmpty) {
                        if (await PatientService.login(phoneNumber, password)) {
                          var prefs = await SharedPreferences.getInstance();
                          if (await PatientService.sendMe(
                              prefs.getString('token'))) {
                            //EasyLoading.dismiss();
                            Navigator.of(context).pushNamed('/ana-menu');
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Hay aksi! Bir şeyler ters gitti');
                          }
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Giriş alanları boş bırakılamaz',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.white,
                            textColor: Colors.green,
                            fontSize: 16.0);
                      }
                    },
                    child: Text(
                      'Giriş',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: kPrimaryColor),
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
      ),
    );
  }
}
