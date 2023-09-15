// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:individual/Utils/global_vars.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Center(
        child: LoadingAnimationWidget.newtonCradle(
      color: mainColor,
      size: height * 0.2,
    ));
  }
}

class ParagraptText extends StatelessWidget {
  const ParagraptText(
      {super.key,
      required this.index,
      required this.headers,
      required this.messages});
  final int index;
  final List<String> headers;
  final List<String> messages;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.03,
        ),
        Text(
          headers[index],
          style:
              TextStyle(fontSize: height * 0.022, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: height * 0.014,
        ),
        Text(
          messages[index],
          style: TextStyle(fontSize: height * 0.02, color: Colors.grey),
        ),
      ],
    );
  }
}

class IndividualLogo extends StatelessWidget {
  const IndividualLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
        width: width,
        height: height * 0.15,
        child: Container(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              SizedBox(width: width * 0.57),
              SizedBox(
                width: width * 0.4,
                child: Text(
                  'I N D I V I D U A L',
                  style: TextStyle(
                      fontSize: height * 0.022,
                      color: mainColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ));
  }
}
