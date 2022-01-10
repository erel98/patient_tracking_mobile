import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient_tracking/Models/question.dart';
import 'package:patient_tracking/Providers/question_provider.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../constraints.dart';

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

    return questions.isNotEmpty
        ? ExpansionPanelList(
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
                          color:
                              item.answer != null ? Colors.green : Colors.black,
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
                        trailing: item.answer != null || item.answer != ''
                            ? IconButton(
                                icon: Icon(
                                  FontAwesome5.trash_alt,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Dikkat'),
                                          content: Container(
                                            child: Text(
                                                'Bu soruyu kalıcı olarak silmek istediğinize emin misiniz?'),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                var success =
                                                    await questionsData
                                                        .removeQuestion(
                                                            item.id);
                                                if (success) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Sorunuz başarıyla silindi');
                                                  Navigator.of(context).pop();

                                                  setState(() {});
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Hay aksi! Bir şeyler ters gitti');
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              child: Text(
                                                'Evet',
                                                style: TextStyle(
                                                    color: kPrimaryColor),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text(
                                                'Hayır',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                              )
                            : Container(),
                      );
                    },
                  ),
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          )
        : Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: NoDataFound('Sorunuz'));
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
