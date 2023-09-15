// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:individual/Database/user_db.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/menu.dart';
import 'package:individual/Widgets/button_widgets.dart';
import 'package:individual/Widgets/form_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Widgets/profile_widgets.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.user});
  final User user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController yearOfBirthController = TextEditingController();
  late User user;
  late String name;
  late String surname;
  late String yearOfBirth;
  late int avatarIndex;

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    yearOfBirthController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    user = widget.user;
    nameController.text = user.name;
    surnameController.text = user.surname;
    yearOfBirthController.text = user.yearOfBirth;
    name = nameController.text;
    surname = surnameController.text;
    yearOfBirth = yearOfBirthController.text;
    avatarIndex = user.avatarIndex;
    super.initState();
  }

  void updateAvatarIndex(int newIndex) {
    setState(() {
      avatarIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: ButtonOneOption(
          navigatorBack: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MenuPage(
                        user: user,
                        selectedIndex: 3,
                      )),
            );
          },
          function: () async {
            if (name.isEmpty || surname.isEmpty || yearOfBirth.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                  'Form fields cannot be left blank',
                  SnackBarType.error,
                  context));
            } else {
              bool ageChecker = checkAge(yearOfBirth);
              if (ageChecker == true) {
                updateAvatarIndex(avatarIndex);
                User editedUser = user;
                setState(() {
                  editedUser.avatarIndex = avatarIndex;
                  editedUser.name = name;
                  editedUser.surname = surname;
                  editedUser.yearOfBirth = yearOfBirth;
                });

                bool edited = await editUser(editedUser);
                (edited == false)
                    ? ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                        'An error occurred, try again later',
                        SnackBarType.error,
                        context))
                    : {
                        ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar('Profile updated',
                                SnackBarType.success, context)),
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuPage(
                                    user: user,
                                    selectedIndex: 3,
                                  )),
                        )
                      };
              } else {
                ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                    'Wrong year of birth field. The user must be over 16. Maximum age is 100',
                    SnackBarType.error,
                    context));
              }
            }
          },
          text: 'SAVE CHANGES'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const IndividualLogo(),
            IconTextField(
              function: (_) {
                setState(() {
                  name = nameController.text;
                });
              },
              controller: nameController,
              icon: Icons.person_2_outlined,
              hintText: 'Name',
            ),
            SizedBox(
              height: height * 0.02,
            ),
            IconTextField(
              function: (_) {
                setState(() {
                  surname = surnameController.text;
                });
              },
              controller: surnameController,
              icon: Icons.person_2_outlined,
              hintText: 'Surname',
            ),
            SizedBox(
              height: height * 0.02,
            ),
            IconTextField(
              function: (_) {
                setState(() {
                  yearOfBirth = yearOfBirthController.text;
                });
              },
              controller: yearOfBirthController,
              icon: Icons.person_2_outlined,
              textInputType: TextInputType.number,
              hintText: 'Year Of Birth',
            ),
            SizedBox(
              height: height * 0.04,
            ),
            AvatarGallery(
              updateAvatarIndex: updateAvatarIndex,
              avatarIndex: avatarIndex,
            )
          ],
        ),
      ),
    );
  }
}
