// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:individual/Database/email_db.dart';
import 'package:individual/Database/user_db.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Authorization/login.dart';
import 'package:individual/Widgets/form_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

class RestorePasswordPage extends StatefulWidget {
  const RestorePasswordPage({super.key});

  @override
  State<RestorePasswordPage> createState() => _RestorePasswordPageState();
}

class _RestorePasswordPageState extends State<RestorePasswordPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController yearOfBirthController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  String username = '';
  String password = '';
  String password2 = '';
  String yearOfBirth = '';

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    password2Controller.dispose();
    yearOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const IndividualLogo(),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    height: height * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Restore Account',
                          style: TextStyle(
                              fontSize: height * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * 0.022,
                        ),
                        IconTextField(
                          controller: usernameController,
                          icon: Icons.person_outlined,
                          hintText: 'Username',
                          function: (_) {
                            setState(() {
                              username = usernameController.text;
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        IconTextField(
                          controller: yearOfBirthController,
                          icon: Icons.person_outlined,
                          textInputType: TextInputType.number,
                          hintText: 'Year Of Birth',
                          function: (_) {
                            setState(() {
                              yearOfBirth = yearOfBirthController.text;
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        IconPasswordTextField(
                          controller: passwordController,
                          icon: Icons.email_outlined,
                          hintText: 'New Password',
                          function: (_) {
                            setState(() {
                              password = passwordController.text;
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        IconPasswordTextField(
                          controller: password2Controller,
                          icon: Icons.email_outlined,
                          hintText: 'Confirm New Password',
                          function: (_) {
                            setState(() {
                              password2 = password2Controller.text;
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (username.isEmpty ||
                                  yearOfBirth.isEmpty ||
                                  password.isEmpty ||
                                  password2.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    customSnackBar(
                                        'Form fields cannot be left blank',
                                        SnackBarType.error,
                                        context));
                              } else {
                                if (password != password2) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      customSnackBar(
                                          'Password fields are not the same',
                                          SnackBarType.error,
                                          context));
                                } else {
                                  bool correctData =
                                      await restoreCheck(username, yearOfBirth);
                                  if (correctData == true) {
                                    User user = await getUser(username);
                                    print(user.password);
                                    user.password = password;
                                    print(user.password);
                                    await editUser(user);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        customSnackBar(
                                            'Password has been changed',
                                            SnackBarType.success,
                                            context));
                                    sendChangedPassword({
                                      "address": user.email,
                                      "name": user.name,
                                      "surname": user.surname,
                                      "username": user.username
                                    });
                                    navigatorReplacementWithAnimation(
                                        context,
                                        -1.0,
                                        (context, animation,
                                                secondaryAnimation) =>
                                            const LoginPage(),
                                        {});
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        customSnackBar(
                                            'The data of the verification fields do not match',
                                            SnackBarType.error,
                                            context));
                                  }
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: SizedBox(
                              width: width * 0.26,
                              height: height * 0.05,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'RESTORE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 0.018,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_outlined,
                                    size: height * 0.028,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Container(
                    height: height * 0.1,
                    width: width * 0.8,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Go back and',
                          style: TextStyle(
                              fontSize: height * 0.02, color: Colors.grey),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () {
                            navigatorWithAnimation(
                                context,
                                -1.0,
                                (context, animation, secondaryAnimation) =>
                                    const LoginPage(),
                                {});
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: height * 0.018,
                                color: Colors.deepPurpleAccent),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
