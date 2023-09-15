import 'package:flutter/material.dart';
import 'package:individual/Database/question_db.dart';
import 'package:individual/Models/question.dart';
import 'package:individual/Models/quiz.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/Profile/Materials/quiz_score.dart';
import 'package:individual/Utils/global_vars.dart';
import 'package:individual/Widgets/button_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Widgets/quiz_widgets.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.loggedUser, required this.quiz});
  final User loggedUser;
  final Quiz quiz;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<List<Question>> questions;
  int helpIndex = 0;
  int index = 0;
  int userPoints = 0;

  @override
  void initState() {
    questions = getQuestions(widget.quiz.studyMaterialId);
    super.initState();
  }

  void updateIndex(int newIndex) {
    setState(() {
      helpIndex = newIndex;
    });
  }

  void updateShuffle(bool newBool) {
    setState(() {
      newBool = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(children: [
          const IndividualLogo(),
          FutureBuilder(
            future: questions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              } else {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<Question> list = snapshot.data!;
                  int listLen = list.length;
                  List<String> questionList = [
                    list[index].answer3,
                    list[index].answer4,
                    list[index].answer1,
                    list[index].answer2,
                  ];

                  return SizedBox(
                    width: width,
                    height: height * 0.85,
                    child: Column(
                      children: [
                        QuestionCard(
                            questionList: questionList,
                            question: list[index],
                            updateIndex: updateIndex,
                            index: helpIndex),
                        const Expanded(child: SizedBox()),
                        (index < listLen - 1)
                            ? ButtonOneOptionNoBack(
                                function: () {
                                  if (helpIndex == 0) {
                                    setState(() {
                                      index++;
                                      helpIndex = 0;
                                    });
                                  } else {
                                    setState(() {
                                      if (questionList[helpIndex - 1] ==
                                          list[index].correctAnswer) {
                                        userPoints += 20;
                                      }
                                      index++;
                                      helpIndex = 0;
                                    });
                                  }
                                },
                                text: 'NEXT',
                              )
                            : ButtonOneOptionNoBack(
                                function: () {
                                  setState(() {
                                    if (helpIndex == 0) {
                                    } else {
                                      if (questionList[helpIndex - 1] ==
                                          list[index].correctAnswer) {
                                        userPoints += 20;
                                      }
                                    }
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuizScorePage(
                                              user: widget.loggedUser,
                                              quiz: widget.quiz,
                                              userPoints: userPoints,
                                            )),
                                  );
                                },
                                text: 'END TEST',
                              )
                      ],
                    ),
                  );
                } else {
                  return Center(
                      child: SizedBox(
                    width: width * 0.7,
                    child: Text(
                      'There is nothing here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: height * 0.024,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ));
                }
              }
            },
          )
        ]));
  }
}
