import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {
  const IconTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.function,
      this.textInputType = TextInputType.name,
      this.hintText = '',
      this.showLabel = true});
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final void Function(String) function;
  final TextInputType textInputType;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      height: height * 0.095,
      width: width * 0.8,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: height * 0.022,
            width: width * 0.77,
            child: Text(
              (showLabel == true) ? hintText : '',
              style: TextStyle(
                fontSize: height * 0.018,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.008,
          ),
          Container(
            height: height * 0.065,
            alignment: Alignment.center,
            width: width * 0.8,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 5,
              semanticContainer: true,
              child: Row(
                children: [
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.02,
                  ),
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.065,
                    child: Icon(
                      icon,
                      size: height * 0.03,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.015,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: height * 0.05,
                        width: width * 0.67,
                        child: TextField(
                          keyboardType: textInputType,
                          autocorrect: true,
                          onChanged: function,
                          onSubmitted: function,
                          controller: controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: hintText,
                            hintStyle: TextStyle(
                                fontSize: height * 0.018, color: Colors.black),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox())
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

class IconLongTextField extends StatelessWidget {
  const IconLongTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.function,
      this.textInputType = TextInputType.name,
      this.hintText = '',
      this.showLabel = true});
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final void Function(String) function;
  final TextInputType textInputType;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      height: height * 0.2,
      width: width * 0.8,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: height * 0.02,
            width: width * 0.77,
            child: Text(
              (showLabel == true) ? hintText : '',
              style: TextStyle(
                fontSize: height * 0.018,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.008,
          ),
          Container(
            height: height * 0.17,
            alignment: Alignment.center,
            width: width * 0.8,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 5,
              semanticContainer: true,
              child: Row(
                children: [
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.02,
                  ),
                  SizedBox(
                    height: height * 0.17,
                    width: width * 0.065,
                    child: Icon(
                      icon,
                      size: height * 0.03,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.065,
                    width: width * 0.015,
                  ),
                  SizedBox(
                    height: height * 0.18,
                    width: width * 0.67,
                    child: TextField(
                      maxLength: 200,
                      maxLines: null,
                      keyboardType: textInputType,
                      autocorrect: true,
                      onChanged: function,
                      onSubmitted: function,
                      controller: controller,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: TextStyle(
                            fontSize: height * 0.018, color: Colors.black),
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

class IconPasswordTextField extends StatefulWidget {
  const IconPasswordTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.function,
      this.showLabel = true,
      this.hintText = ''});
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final void Function(String) function;
  final bool showLabel;

  @override
  State<IconPasswordTextField> createState() => _IconPasswordTextFieldState();
}

class _IconPasswordTextFieldState extends State<IconPasswordTextField> {
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
        alignment: Alignment.center,
        height: height * 0.095,
        width: width * 0.8,
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            height: height * 0.02,
            width: width * 0.77,
            child: Text(
              (widget.showLabel == true) ? widget.hintText : '',
              style: TextStyle(
                fontSize: height * 0.018,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.008,
          ),
          Container(
            alignment: Alignment.center,
            height: height * 0.065,
            width: width * 0.8,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 5,
              semanticContainer: true,
              child: Row(
                children: [
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.02,
                  ),
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.065,
                    child: Icon(
                      widget.icon,
                      size: height * 0.03,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.015,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                        width: width * 0.57,
                        child: TextField(
                          autocorrect: false,
                          obscureText: hide,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: widget.function,
                          onSubmitted: widget.function,
                          controller: widget.controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget.hintText,
                            hintStyle: TextStyle(
                                fontSize: height * 0.018, color: Colors.black),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox())
                    ],
                  ),
                  SizedBox(
                      height: height * 0.06,
                      width: width * 0.06,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              hide = !hide;
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            size: height * 0.03,
                            color: Colors.deepPurpleAccent,
                          ))),
                ],
              ),
            ),
          )
        ]));
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField(
      {super.key,
      required this.controller,
      required this.function,
      required this.searchFunction,
      this.textInputType = TextInputType.name,
      this.hintText = '',
      this.showLabel = true});
  final TextEditingController controller;
  final String hintText;
  final void Function(String) function;
  final void Function() searchFunction;
  final TextInputType textInputType;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      height: height * 0.095,
      width: width * 0.8,
      child: Column(
        children: [
          Container(
            height: height * 0.065,
            alignment: Alignment.center,
            width: width * 0.8,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 5,
              semanticContainer: true,
              child: Row(
                children: [
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.02,
                  ),
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.015,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                        width: width * 0.62,
                        child: TextField(
                          keyboardType: textInputType,
                          autocorrect: true,
                          onChanged: function,
                          onSubmitted: function,
                          controller: controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: hintText,
                            hintStyle: TextStyle(
                                fontSize: height * 0.018, color: Colors.black),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      onPressed: searchFunction,
                      icon: Icon(
                        Icons.search,
                        size: height * 0.03,
                        color: Colors.deepPurpleAccent,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonTextField extends StatelessWidget {
  const ButtonTextField(
      {super.key,
      required this.controller,
      required this.function,
      required this.searchFunction,
      this.textInputType = TextInputType.name,
      this.hintText = '',
      this.showLabel = true});
  final TextEditingController controller;
  final String hintText;
  final void Function(String) function;
  final void Function() searchFunction;
  final TextInputType textInputType;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      height: height * 0.095,
      width: width * 0.98,
      child: Column(
        children: [
          Container(
            height: height * 0.065,
            alignment: Alignment.center,
            width: width * 0.92,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 5,
              semanticContainer: true,
              child: Row(
                children: [
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.02,
                  ),
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.015,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                        width: width * 0.7,
                        child: TextField(
                          keyboardType: textInputType,
                          autocorrect: true,
                          onChanged: function,
                          onSubmitted: function,
                          controller: controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: hintText,
                            hintStyle: TextStyle(
                                fontSize: height * 0.018, color: Colors.black),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      onPressed: searchFunction,
                      icon: Icon(
                        Icons.send_outlined,
                        size: height * 0.03,
                        color: Colors.deepPurpleAccent,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
