import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Models/question.dart';
import 'package:patient_tracking/Providers/question_provider.dart';
import 'package:patient_tracking/Services/question_service.dart';
import 'package:patient_tracking/Widgets/sorular%C4%B1m_list.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constraints.dart';

class MyQuestionsScreen extends StatefulWidget {
  static final routeName = '/my-questions';
  @override
  _MyQuestionsScreenState createState() => _MyQuestionsScreenState();
}

class _MyQuestionsScreenState extends State<MyQuestionsScreen> {
  void fetchQuestions(BuildContext context) async {
    var questionsProvider = context.read<QuestionProvider>();
    questionsProvider.empty();
    List<Question> list = await QuestionService.getMyQuestions();
    list.forEach((element) {
      questionsProvider.addQuestion(element);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fetchQuestions(context);

    final appBar = AppBar(
      elevation: 0,
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
