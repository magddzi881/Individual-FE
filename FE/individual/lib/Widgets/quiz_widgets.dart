import 'package:flutter/material.dart';
import 'package:individual/Models/question.dart';
import 'package:individual/Utils/global_vars.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard(
      {super.key,
      required this.question,
      required this.updateIndex,
      required this.questionList,
      required this.index});
  final Question question;
  final Function(int) updateIndex;
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

    return SizedBox(
      height: height * 0.55,
      width: width * 0.9,
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: width * 0.8,
              child: Text(widget.question.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: height * 0.02,
                  )),
            ),
          ),
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
                color: (widget.index == 1) ? mainColor : Colors.white,
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
                color: (widget.index == 2) ? mainColor : Colors.white,
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
                color: (widget.index == 3) ? mainColor : Colors.white,
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
                color: (widget.index == 4) ? mainColor : Colors.white,
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
