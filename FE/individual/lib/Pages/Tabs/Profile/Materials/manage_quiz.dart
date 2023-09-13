// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:individual/Database/question_db.dart';
import 'package:individual/Database/quiz_db.dart';
import 'package:individual/Models/question.dart';
import 'package:individual/Models/quiz.dart';
import 'package:individual/Models/study_material.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';
import 'package:individual/Widgets/button_widgets.dart';
import 'package:individual/Widgets/form_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';

class ManageQuizPage extends StatefulWidget {
  const ManageQuizPage(
      {super.key, required this.user, required this.studyMaterial});
  final User user;
  final StudyMaterial studyMaterial;

  @override
  State<ManageQuizPage> createState() => _ManageQuizPageState();
}

class _ManageQuizPageState extends State<ManageQuizPage> {
  TextEditingController questionController = TextEditingController();
  TextEditingController correctController = TextEditingController();
  TextEditingController wrong1Controller = TextEditingController();
  TextEditingController wrong2Controller = TextEditingController();
  TextEditingController wrong3Controller = TextEditingController();
  late Future<List<Question>> questions;
  String question = '';
  String correct = '';
  String wrong1 = '';
  String wrong2 = '';
  String wrong3 = '';

  @override
  void dispose() {
    questionController.dispose();
    correctController.dispose();
    wrong1Controller.dispose();
    wrong2Controller.dispose();
    wrong3Controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    questions = getQuestions(widget.studyMaterial.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: ButtonOneOption(
            function: () async {
              Quiz quiz =
                  await getQuizByStudyMaterialId(widget.studyMaterial.id);
              quiz.points = quiz.points + 2;
              quiz.questionCount = quiz.questionCount + 1;
              editQuiz(quiz);
              addQuestion(Question(
                      id: 0,
                      quizId: quiz.id,
                      title: question,
                      answer1: correct,
                      answer2: wrong1,
                      answer3: wrong2,
                      answer4: wrong3,
                      correctAnswer: correct))
                  .then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar('Added', SnackBarType.success, context));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageQuizPage(
                              user: widget.user,
                              studyMaterial: widget.studyMaterial,
                            )));
              });
            },
            text: 'ADD QUESTION',
            navigatorBack: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: background,
        body: SingleChildScrollView(
          child: Column(children: [
            const IndividualLogo(),
            SizedBox(
              width: width,
              height: height * 0.61,
              child: Column(
                children: [
                  IconTextField(
                      controller: questionController,
                      hintText: 'Question',
                      icon: Icons.edit_outlined,
                      function: (_) {
                        setState(() {
                          question = questionController.text;
                        });
                      }),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  IconTextField(
                      controller: correctController,
                      hintText: 'Correct answer',
                      icon: Icons.edit_outlined,
                      function: (_) {
                        setState(() {
                          correct = correctController.text;
                        });
                      }),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  IconTextField(
                      controller: wrong1Controller,
                      hintText: 'Wrong answer',
                      icon: Icons.edit_outlined,
                      function: (_) {
                        setState(() {
                          wrong1 = wrong1Controller.text;
                        });
                      }),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  IconTextField(
                      controller: wrong2Controller,
                      hintText: 'Wrong answer',
                      icon: Icons.edit_outlined,
                      function: (_) {
                        setState(() {
                          wrong2 = wrong2Controller.text;
                        });
                      }),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  IconTextField(
                      controller: wrong3Controller,
                      hintText: 'Wrong answer',
                      icon: Icons.edit_outlined,
                      function: (_) {
                        setState(() {
                          wrong3 = wrong3Controller.text;
                        });
                      }),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "List of questions",
                    style: TextStyle(
                      fontSize: height * 0.018,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width,
              height: height * 0.3,
              child: FutureBuilder(
                future: questions,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loading();
                  } else {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width * 0.03,
                              ),
                              SizedBox(
                                width: width * 0.8,
                                height: height * 0.03,
                                child: Text(
                                  snapshot.data![index].title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: height * 0.02),
                                ),
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    bool deleted = await deleteQuestionById(
                                        snapshot.data![index].id);
                                    if (deleted == true) {
                                      Quiz quiz =
                                          await getQuizByStudyMaterialId(
                                              widget.studyMaterial.id);
                                      quiz.points = quiz.points - 2;
                                      quiz.questionCount =
                                          quiz.questionCount - 1;
                                      editQuiz(quiz);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(customSnackBar(
                                              'Deleted',
                                              SnackBarType.success,
                                              context));
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ManageQuizPage(
                                                    user: widget.user,
                                                    studyMaterial:
                                                        widget.studyMaterial,
                                                  )));
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete_forever_outlined,
                                    size: height * 0.03,
                                    color: Colors.red,
                                  )),
                              SizedBox(
                                width: width * 0.03,
                              ),
                            ],
                          );
                        },
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return Center(
                          child: SizedBox(
                        width: width * 0.7,
                        child: Text(
                          'There are no questions assigned to the quiz.',
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
              ),
            ),
          ]),
        ));
  }
}
