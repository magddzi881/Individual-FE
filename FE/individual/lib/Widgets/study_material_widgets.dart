// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:individual/Database/question_db.dart';
import 'package:individual/Database/quiz_db.dart';
import 'package:individual/Database/study_materials_db.dart';
import 'package:individual/Models/quiz.dart';
import 'package:individual/Models/study_material.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/Profile/Materials/accesses.dart';
import 'package:individual/Pages/Tabs/Profile/Materials/edit_material.dart';
import 'package:individual/Pages/Tabs/Profile/Materials/quiz.dart';
import 'package:individual/Pages/Tabs/Profile/study_materials.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';
import 'package:individual/Widgets/offer_widgets.dart';

class StudyMaterialCard extends StatelessWidget {
  const StudyMaterialCard(
      {super.key, required this.data, required this.loggedUser});
  final StudyMaterial data;
  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.7,
      width: width,
      child: Column(
        children: [
          SizedBox(
            height: height * 0.7,
            width: width,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.01,
                      ),
                      CategorySwitch(
                        category: data.category,
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.category,
                            style: TextStyle(fontSize: height * 0.022),
                          ),
                          SizedBox(
                            width: width * 0.7,
                            child: Row(
                              children: [
                                Text(
                                  '${data.tutor.name} ${data.tutor.surname} ${calculateAge(int.parse(data.tutor.yearOfBirth))}',
                                  style: TextStyle(
                                      fontSize: height * 0.018,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.5,
                    width: width * 0.85,
                    child: SingleChildScrollView(
                      child: Text(
                        data.text,
                        style: TextStyle(fontSize: height * 0.02),
                      ),
                    ),
                  ),
                  Container(
                      color: backgroundColor,
                      width: width * 0.85,
                      height: height * 0.001),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "Quiz related to this topic",
                    style:
                        TextStyle(fontSize: height * 0.018, color: Colors.grey),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        Quiz quiz = await getQuizByStudyMaterialId(data.id);
                        if (quiz.questionCount == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              customSnackBar('This quiz has no questions',
                                  SnackBarType.error, context));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuizPage(
                                      quiz: quiz,
                                      loggedUser: loggedUser,
                                    )),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: SizedBox(
                        width: width * 0.3,
                        height: height * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Attemp",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.018,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StudyMaterialCardFolded extends StatelessWidget {
  const StudyMaterialCardFolded({super.key, required this.data});
  final StudyMaterial data;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.11,
      width: width,
      child: Column(
        children: [
          SizedBox(
            height: height * 0.11,
            width: width,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.01,
                      ),
                      CategorySwitch(
                        category: data.category,
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.category,
                            style: TextStyle(fontSize: height * 0.022),
                          ),
                          SizedBox(
                            width: width * 0.7,
                            child: Row(
                              children: [
                                Text(
                                  '${data.tutor.name} ${data.tutor.surname} ${calculateAge(int.parse(data.tutor.yearOfBirth))}',
                                  style: TextStyle(
                                      fontSize: height * 0.018,
                                      color: Colors.grey),
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  ". . .",
                                  style: TextStyle(
                                      fontSize: height * 0.02,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StudyMaterialCardOwner extends StatelessWidget {
  const StudyMaterialCardOwner({super.key, required this.data});
  final StudyMaterial data;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.7,
      width: width,
      child: Column(
        children: [
          SizedBox(
            height: height * 0.7,
            width: width,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.01,
                      ),
                      CategorySwitch(
                        category: data.category,
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.category,
                            style: TextStyle(fontSize: height * 0.022),
                          ),
                          SizedBox(
                            width: width * 0.7,
                            child: Row(
                              children: [
                                Text(
                                  '${data.tutor.name} ${data.tutor.surname} ${calculateAge(int.parse(data.tutor.yearOfBirth))}',
                                  style: TextStyle(
                                      fontSize: height * 0.018,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.5,
                    width: width * 0.85,
                    child: SingleChildScrollView(
                      child: Text(
                        data.text,
                        style: TextStyle(fontSize: height * 0.02),
                      ),
                    ),
                  ),
                  Container(
                      color: backgroundColor,
                      width: width * 0.85,
                      height: height * 0.001),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccessPage(
                                        loggedUser: data.tutor,
                                        studyMaterialId: data.id,
                                      )),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: SizedBox(
                            width: width * 0.18,
                            height: height * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Accesses",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: height * 0.018,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () async {
                            Quiz quiz = await getQuizByStudyMaterialId(data.id);
                            if (quiz.id == -1) {
                              addQuiz(Quiz(
                                      id: 0,
                                      tutorUsername: data.tutor.username,
                                      studyMaterialId: data.id,
                                      points: 0,
                                      questionCount: 0))
                                  .then((value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditMaterialPage(
                                                  material: data,
                                                  user: data.tutor,
                                                )),
                                      ));
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditMaterialPage(
                                          material: data,
                                          user: data.tutor,
                                        )),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: SizedBox(
                            width: width * 0.18,
                            height: height * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Modify",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: height * 0.018,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () async {
                            await deleteQuestionsMaterialId(data.id);
                            await deleteQuizByMaterialId(data.id);
                            await deleteStudyMaterialById(data.id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MaterialsPage(
                                          user: data.tutor,
                                          shared: true,
                                        )));
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                    "Deleted", SnackBarType.success, context));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: SizedBox(
                            width: width * 0.18,
                            height: height * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Delete",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: height * 0.018,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
