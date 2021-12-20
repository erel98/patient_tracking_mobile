import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient_tracking/Models/question.dart';
import 'package:patient_tracking/Providers/question_provider.dart';
import 'package:patient_tracking/Services/question_service.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:provider/provider.dart';

class AskQuestionScreen extends StatefulWidget {
  static final routeName = '/ask-question';
  @override
  _AskQuestionScreenState createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  final appBar = AppBar(backgroundColor: kPrimaryColor, elevation: 0);
  final subject = TextEditingController();
  final content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Column(
        children: [
          TopContainer(),
          Container(
            height: 54,
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 40),
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black.withOpacity(0.2), width: 0.3),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                ),
              ],
            ),
            child: TextField(
              controller: subject,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintText: 'Sorunuz ne hakkında?',
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.8),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 200,
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black.withOpacity(0.2), width: 0.3),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                ),
              ],
            ),
            child: TextField(
              controller: content,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintText: 'Lütfen sorunuzu tanımlayınız.',
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.8),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () async {
                  if (content.text.isNotEmpty && subject.text.isNotEmpty) {
                    Question question =
                        Question(body: content.text, title: subject.text);
                    var questionProvider =
                        Provider.of<QuestionProvider>(context, listen: false);
                    questionProvider.addQuestion(question);
                    content.clear();
                    subject.clear();
                    Navigator.of(context).popAndPushNamed('/my-questions');
                  } else {
                    Fluttertoast.showToast(
                        msg:
                            'Lütfen sizden istenen alanları eksiksiz doldurunuz.');
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
                child: Text(
                  'Gönder',
                  style: TextStyle(color: Colors.white),
                ),
              ))
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
      height: MediaQuery.of(context).size.height * 0.1,
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
