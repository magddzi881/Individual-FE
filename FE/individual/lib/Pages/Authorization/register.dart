import 'package:flutter/material.dart';
import 'package:individual/Database/user_db.dart';
import 'package:individual/Pages/Authorization/login.dart';
import 'package:individual/Pages/Authorization/profile_data.dart';
import 'package:individual/Widgets/form_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  List<String> usernames = [];
  bool hideText = true;
  String username = '';
  String email = '';
  String password = '';
  String password2 = '';
  @override
  void initState() {
    loadUsernames();
    super.initState();
  }

  void loadUsernames() async {
    usernames = await getUserUsernames();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    password2Controller.dispose();
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
                          controller: emailController,
                          icon: Icons.email_outlined,
                          textInputType: TextInputType.emailAddress,
                          hintText: 'E-mail',
                          function: (_) {
                            setState(() {
                              email = emailController.text;
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        IconPasswordTextField(
                          controller: passwordController,
                          icon: Icons.lock_open_outlined,
                          hintText: 'Password',
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
                          icon: Icons.lock_open_outlined,
                          hintText: 'Confirm Password',
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
                            onPressed: () {
                              if (username.isEmpty ||
                                  email.isEmpty ||
                                  password.isEmpty ||
                                  password2.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    customSnackBar(
                                        'Form fields cannot be left blank',
                                        SnackBarType.error,
                                        context));
                              } else {
                                if (doesUsernameExist(username, usernames) ==
                                    true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      customSnackBar(
                                          'Username is already taken',
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
                                    navigatorWithAnimation(
                                        context,
                                        1.0,
                                        (context, animation,
                                                secondaryAnimation) =>
                                            const ProfileDataPage(),
                                        {
                                          'username': username,
                                          'email': email,
                                          'password': password,
                                          'password2': password2
                                        });
                                  }
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
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
                                    'NEXT',
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
                            navigatorWithAnimation(
                                context,
                                1.0,
                                (context, animation, secondaryAnimation) =>
                                    const LoginPage(),
                                {});
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: height * 0.018, color: mainColor),
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
