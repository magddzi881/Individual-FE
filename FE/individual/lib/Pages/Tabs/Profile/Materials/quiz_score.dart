// ignore_for_file: division_optimization

import 'package:flutter/material.dart';
import 'package:individual/Models/quiz.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/Profile/study_materials.dart';
import 'package:individual/Utils/global_vars.dart';
import 'package:individual/Widgets/button_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class QuizScorePage extends StatefulWidget {
  const QuizScorePage(
      {super.key,
      required this.quiz,
      required this.userPoints,
      required this.user});
  final Quiz quiz;
  final User user;
  final int userPoints;

  @override
  State<QuizScorePage> createState() => _QuizScorePageState();
}

class _QuizScorePageState extends State<QuizScorePage> {
  @override
  Widget build(BuildContext context) {
    String correctCount = (widget.userPoints / 20).toInt().toString();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: backgroundColor,
        bottomNavigationBar: ButtonOneOptionNoBack(
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MaterialsPage(
                          user: widget.user,
                          shared: false,
                        )),
              );
            },
            text: 'END TEST'),
        body: Column(children: [
          const IndividualLogo(),
          Center(
            child: SizedBox(
              height: height * 0.6,
              width: width,
              child: CircularPercentIndicator(
                radius: height * 0.12,
                lineWidth: width * 0.07,
                animation: true,
                percent: (widget.userPoints / widget.quiz.points) / 10,
                center: Text(
                  '${(widget.userPoints / widget.quiz.points) * 10}%',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: height * 0.03),
                ),
                footer: Text(
                  'Your score',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: height * 0.024),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: mainColor,
              ),
            ),
          ),
          Text("You attempted ${widget.quiz.questionCount} questions and",
              style: TextStyle(fontSize: height * 0.02)),
          Text("from that $correctCount is correct.",
              style: TextStyle(fontSize: height * 0.02)),
        ]));
  }
}
