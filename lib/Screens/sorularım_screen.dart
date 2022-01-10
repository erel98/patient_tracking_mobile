import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Widgets/sorular%C4%B1m_list.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constraints.dart';

class MyQuestionsScreen extends StatefulWidget {
  static final routeName = '/my-questions';
  @override
  _MyQuestionsScreenState createState() => _MyQuestionsScreenState();
}

class _MyQuestionsScreenState extends State<MyQuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
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
                  children: [Text(questionsInfo)],
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
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [TopContainer(), SizedBox(height: 10), MyQuestionsList()],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(right: 50),
        child: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            child: Icon(FontAwesome5.comment),
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/ask-question')),
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
