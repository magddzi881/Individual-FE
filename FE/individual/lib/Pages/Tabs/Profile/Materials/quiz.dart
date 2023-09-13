import 'package:flutter/material.dart';
import 'package:individual/Database/question_db.dart';
import 'package:individual/Models/question.dart';
import 'package:individual/Models/quiz.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/Profile/Materials/quiz_score.dart';
import 'package:individual/Utils/global_vars.dart';
import 'package:individual/Widgets/button_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';

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
  bool shuffled = false;

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
        backgroundColor: background,
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

                  return Container(
                    width: width,
                    height: height * 0.85,
                    child: Column(
                      children: [
                        QuestionCard(
                            questionList: questionList,
                            shuffle: shuffled,
                            updateShuffle: (_) => setState(() {
                                  shuffled = true;
                                }),
                            question: list[index],
                            updateIndex: updateIndex,
                            index: helpIndex),
                        const Expanded(child: SizedBox()),
                        (index < listLen - 1)
                            ? ButtonOneOptionNoBack(
                                function: () {
                                  setState(() {
                                    if (questionList[helpIndex - 1] ==
                                        list[index].correctAnswer) {
                                      userPoints += 20;
                                    }
                                    index++;
                                    helpIndex = 0;
                                  });
                                },
                                text: 'NEXT',
                              )
                            : ButtonOneOptionNoBack(
                                function: () {
                                  setState(() {
                                    if (questionList[helpIndex - 1] ==
                                        list[index].correctAnswer) {
                                      userPoints += 20;
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

class QuestionCard extends StatefulWidget {
  const QuestionCard(
      {super.key,
      required this.question,
      required this.updateIndex,
      required this.questionList,
      required this.shuffle,
      required this.updateShuffle,
      required this.index});
  final Question question;
  final Function(int) updateIndex;
  final bool shuffle;
  final Function(bool) updateShuffle;
  final int index;
  final List<String> questionList;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    List<String> questionList = widget.questionList;

    initState() {
      () {
        widget.updateShuffle(true);
      };
    }

    return SizedBox(
      height: height * 0.55,
      width: width * 0.9,
      child: Column(
        children: [
          Text(widget.question.title,
              style: TextStyle(
                fontSize: height * 0.02,
              )),
          SizedBox(
            height: height * 0.03,
          ),
          GestureDetector(
            onTap: () {
              widget.updateIndex(1);
            },
            child: SizedBox(
              width: width * 0.9,
              height: height * 0.1,
              child: Card(
                color: (widget.index == 1)
                    ? Colors.deepPurpleAccent
                    : Colors.white,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                    child: Text(
                  questionList[0],
                  style: TextStyle(
                      fontSize: height * 0.02,
                      color: (widget.index == 1) ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              widget.updateIndex(2);
            },
            child: SizedBox(
              width: width * 0.9,
              height: height * 0.1,
              child: Card(
                color: (widget.index == 2)
                    ? Colors.deepPurpleAccent
                    : Colors.white,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                    child: Text(
                  questionList[1],
                  style: TextStyle(
                      fontSize: height * 0.02,
                      color: (widget.index == 2) ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              widget.updateIndex(3);
            },
            child: SizedBox(
              width: width * 0.9,
              height: height * 0.1,
              child: Card(
                color: (widget.index == 3)
                    ? Colors.deepPurpleAccent
                    : Colors.white,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                    child: Text(
                  questionList[2],
                  style: TextStyle(
                      fontSize: height * 0.02,
                      color: (widget.index == 3) ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              widget.updateIndex(4);
            },
            child: SizedBox(
              width: width * 0.9,
              height: height * 0.1,
              child: Card(
                color: (widget.index == 4)
                    ? Colors.deepPurpleAccent
                    : Colors.white,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                    child: Text(
                  questionList[3],
                  style: TextStyle(
                      fontSize: height * 0.02,
                      color: (widget.index == 4) ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
