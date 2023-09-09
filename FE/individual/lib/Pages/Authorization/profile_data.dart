import 'dart:math';

import 'package:flutter/material.dart';
import 'package:individual/Database/user_db.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Authorization/login.dart';
import 'package:individual/Widgets/form_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Utils/functions.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:individual/Utils/global_vars.dart';

class ProfileDataPage extends StatefulWidget {
  const ProfileDataPage({super.key});

  @override
  State<ProfileDataPage> createState() => _ProfileDataPageState();
}

class _ProfileDataPageState extends State<ProfileDataPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController yearOfBirthController = TextEditingController();
  String name = '';
  String surname = '';
  String yearOfBirth = '';
  String gender = 'ND';

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    yearOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    final random = Random();

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
                    height: height * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Account',
                          style: TextStyle(
                              fontSize: height * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        IconTextField(
                          controller: nameController,
                          icon: Icons.person_outlined,
                          hintText: 'Name',
                          function: (_) {
                            setState(() {
                              name = nameController.text;
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        IconTextField(
                          controller: surnameController,
                          icon: Icons.person_outlined,
                          hintText: 'Surname',
                          function: (_) {
                            setState(() {
                              surname = surnameController.text;
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        IconTextField(
                          controller: yearOfBirthController,
                          icon: Icons.calendar_month_outlined,
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
                        Container(
                          alignment: Alignment.center,
                          width: width * 0.8,
                          height: height * 0.08,
                          child: ToggleSwitch(
                            customWidths: [
                              width * 0.25,
                              width * 0.25,
                              width * 0.25,
                            ],
                            initialLabelIndex: 2,
                            cornerRadius: 10,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.white,
                            inactiveFgColor: Colors.black,
                            totalSwitches: 3,
                            icons: const [
                              Icons.woman_2_sharp,
                              Icons.man_2_sharp,
                              Icons.people_outline
                            ],
                            iconSize: height * 0.03,
                            borderColor: const [Colors.white],
                            activeBgColors: const [
                              [Colors.deepPurpleAccent],
                              [Colors.deepPurpleAccent],
                              [Colors.deepPurpleAccent]
                            ],
                            onToggle: (index) {
                              switch (index) {
                                case 0:
                                  gender = 'F';
                                  break;
                                case 1:
                                  gender = 'M';
                                  break;
                                case 2:
                                  gender = 'ND';
                                  break;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_outlined,
                                    size: height * 0.028,
                                    color: Colors.black,
                                  )),
                              const Expanded(child: SizedBox()),
                              ElevatedButton(
                                onPressed: () {
                                  if (name.isEmpty ||
                                      surname.isEmpty ||
                                      yearOfBirth.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        customSnackBar(
                                            'Form fields cannot be left blank',
                                            SnackBarType.error,
                                            context));
                                  } else {
                                    bool ageChecker = checkAge(yearOfBirth);
                                    if (ageChecker == true) {
                                      late int avatar;
                                      switch (gender) {
                                        case 'F':
                                          avatar = random.nextInt(4) + 1;
                                          break;
                                        case 'M':
                                          avatar = random.nextInt(4) + 5;
                                          break;
                                        case 'ND':
                                          avatar = random.nextInt(4) + 9;
                                          break;
                                      }
                                      setState(() {
                                        User user = User(
                                            username: args['username'],
                                            email: args['email'],
                                            password: args['password'],
                                            name: name,
                                            surname: surname,
                                            yearOfBirth: yearOfBirth,
                                            gender: gender,
                                            avatarIndex: avatar,
                                            rating: 0);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(customSnackBar(
                                                'The account has been created',
                                                SnackBarType.success,
                                                context));
                                        addUser(user).then((value) {
                                          navigatorReplacementWithAnimation(
                                              context,
                                              1.0,
                                              (context, animation,
                                                      secondaryAnimation) =>
                                                  const LoginPage(),
                                              {});
                                        });
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(customSnackBar(
                                              'Wrong year of birth field. The user must be over 16. Maximum age is 100',
                                              SnackBarType.error,
                                              context));
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
                                        'SIGN UP',
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
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.1,
                    width: width * 0.8,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                              fontSize: height * 0.02, color: Colors.grey),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const LoginPage(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Sign in',
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
