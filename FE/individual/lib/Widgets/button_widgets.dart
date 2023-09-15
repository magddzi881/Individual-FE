import 'package:flutter/material.dart';
import 'package:individual/Utils/global_vars.dart';

class ButtonOneOption extends StatelessWidget {
  const ButtonOneOption(
      {super.key,
      required this.function,
      required this.text,
      required this.navigatorBack});
  final String text;
  final void Function() function;
  final void Function() navigatorBack;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.white,
        width: width,
        height: height * 0.1,
        child: Column(
          children: [
            Container(
              width: width,
              color: Colors.grey,
              height: height * 0.001,
            ),
            SizedBox(
              height: height * 0.018,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.02,
                ),
                IconButton(
                    onPressed: navigatorBack,
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: height * 0.03,
                      color: Colors.black,
                    )),
                const Expanded(child: SizedBox()),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: function,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: SizedBox(
                      width: width * 0.7,
                      height: height * 0.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            text,
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
                SizedBox(
                  width: width * 0.05,
                ),
              ],
            )
          ],
        ));
  }
}

class ButtonOneOptionNoBack extends StatelessWidget {
  const ButtonOneOptionNoBack({
    super.key,
    required this.function,
    required this.text,
  });
  final String text;
  final void Function() function;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.white,
        width: width,
        height: height * 0.1,
        child: Column(
          children: [
            Container(
              width: width,
              color: Colors.grey,
              height: height * 0.001,
            ),
            SizedBox(
              height: height * 0.018,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: function,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: SizedBox(
                      width: width * 0.8,
                      height: height * 0.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            text,
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
                SizedBox(
                  width: width * 0.05,
                ),
              ],
            )
          ],
        ));
  }
}

class ButtonTwoOptions extends StatelessWidget {
  const ButtonTwoOptions(
      {super.key,
      required this.function,
      required this.function2,
      required this.text,
      required this.text2});
  final String text;
  final String text2;
  final void Function() function;
  final void Function() function2;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.white,
        width: width,
        height: height * 0.1,
        child: Column(
          children: [
            Container(
              width: width,
              color: Colors.grey,
              height: height * 0.001,
            ),
            SizedBox(
              height: height * 0.018,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.02,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: height * 0.03,
                      color: Colors.black,
                    )),
                const Expanded(child: SizedBox()),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: function,
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
                            text,
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
                SizedBox(
                  width: width * 0.03,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: function2,
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
                            text2,
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
                SizedBox(
                  width: width * 0.05,
                ),
              ],
            )
          ],
        ));
  }
}

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key, required this.function});
  final void Function() function;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.white,
        width: width,
        height: height * 0.1,
        child: Column(
          children: [
            Container(
              width: width,
              color: Colors.grey,
              height: height * 0.001,
            ),
            SizedBox(
              height: height * 0.018,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.02,
                ),
                IconButton(
                    onPressed: function,
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: height * 0.03,
                      color: Colors.black,
                    )),
                const Expanded(child: SizedBox()),
              ],
            )
          ],
        ));
  }
}
