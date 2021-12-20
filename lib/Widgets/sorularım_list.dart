import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Models/question.dart';
import 'package:patient_tracking/Providers/question_provider.dart';
import 'package:patient_tracking/Services/question_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class MyQuestionsList extends StatefulWidget {
  // final List<Question> questions;
  // MyQuestionsList(this.questions);
  @override
  State<MyQuestionsList> createState() => _MyQuestionsListState();
}

class _MyQuestionsListState extends State<MyQuestionsList> {
  List<Item> _data = [];
  List<bool> isExpandedList = [];
  bool currentIsExpanded = false;
  @override
  void initState() {
    super.initState();
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    questionProvider.getQuestions(context);
  }

  void mapQuestionsToData(List<Question> questions) {
    _data.clear();
    questions.forEach((element) {
      _data.add(Item(
        subjectText: element.subject,
        contentText: element.question,
        answer: element.answer,
        isAnswered: element.answer != null,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionsData = Provider.of<QuestionProvider>(context);
    final questions = questionsData.questions;

    mapQuestionsToData(questions);
    //_data.forEach((element) => print(element.isAnswered));

    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          questions[index].isExpanded = !questions[index].isExpanded;
        });
      },
      children: questions.map<ExpansionPanel>((Question item) {
        //print(item.runtimeType);
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) =>
              ChangeNotifierProvider.value(
            value: item,
            child: Consumer<Question>(
              builder: (ctx, itemRef, c) {
                return ListTile(
                  leading: Icon(
                    item.answer != null
                        ? FontAwesome5.envelope_open
                        : FontAwesome5.envelope,
                    color: item.answer != null ? Colors.green : Colors.black,
                  ),
                  title: Text(
                    item.subject,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  subtitle: Text(item.answer == null
                      ? 'Sorunuz en kısa sürede yanıtlanacaktır'
                      : 'Sorunuz yanıtlandı!'),
                );
              },
            ),
          ),
          body: ChangeNotifierProvider.value(
            value: item,
            child: Consumer<Question>(
              builder: (ctx, itemRef, c) {
                return ListTile(
                  title: Text(item.answer != null
                      ? 'Yanıt: ${item.answer}'
                      : 'Soru: ${item.question}'),
                );
              },
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class Item extends ChangeNotifier {
  String subjectText;
  String contentText;
  String answer;
  bool isExpanded;
  bool isAnswered;

  Item(
      {String subjectText,
      String contentText,
      String answer,
      bool isExpanded = false,
      bool isAnswered = false}) {
    this.subjectText = subjectText;
    this.contentText = contentText;
    this.answer = answer;
    this.isExpanded = isExpanded;
    this.isAnswered = isAnswered;
  }
}

Item generateItem(List<Question> questions, int i) {
  return Item(
      subjectText: questions[i].subject,
      contentText: questions[i].question,
      isAnswered: false,
      isExpanded: false,
      answer: questions[i].answer);
}
