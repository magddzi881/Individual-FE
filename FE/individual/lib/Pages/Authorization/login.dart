// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:individual/Database/user_db.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Authorization/restore_password.dart';
import 'package:individual/Pages/menu.dart';
import 'package:individual/Pages/Authorization/register.dart';
import 'package:individual/Widgets/form_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hideText = true;
  String username = '';
  String password = '';

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
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
                          'Login',
                          style: TextStyle(
                              fontSize: height * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Please sign in to continue.',
                          style: TextStyle(
                              fontSize: height * 0.022, color: Colors.grey),
                        ),
                        SizedBox(
                          height: height * 0.07,
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
                        IconPasswordTextField(
                          controller: passwordController,
                          icon: Icons.lock_outline,
                          hintText: 'Password',
                          function: (_) {
                            setState(() {
                              password = passwordController.text;
                            });
                          },
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
                                      const RestorePasswordPage(),
                                  {});
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: height * 0.017),
                              ),
                            )),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () async {
                              bool auth = await logIn(username, password);

                              if (auth == false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    customSnackBar('Invalid login or password',
                                        SnackBarType.error, context));
                              } else {
                                User user = await getUser(username);
                                Navigator.of(context).pushAndRemoveUntil(
                                    PageRouteBuilder(
                                      settings:
                                          const RouteSettings(arguments: {}),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          MenuPage(
                                              user: user, selectedIndex: 0),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = const Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;
                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));

                                        var offsetAnimation =
                                            animation.drive(tween);

                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                    ),
                                    (route) => false);
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
                                    'LOGIN',
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
                          'Don\'t have an account?',
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
                                    const RegisterPage(),
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
