import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:individual/Database/study_materials_db.dart';
import 'package:individual/Models/study_material.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/Profile/Materials/manage_quiz.dart';
import 'package:individual/Pages/Tabs/Profile/study_materials.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';
import 'package:individual/Widgets/button_widgets.dart';
import 'package:individual/Widgets/form_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';

class EditMaterialPage extends StatefulWidget {
  const EditMaterialPage(
      {super.key, required this.user, required this.material});
  final User user;
  final StudyMaterial material;

  @override
  State<EditMaterialPage> createState() => _EditMaterialPageState();
}

class _EditMaterialPageState extends State<EditMaterialPage> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  String description = '';

  String category = 'Other';

  @override
  void dispose() {
    descriptionController.dispose();

    categoryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    description = widget.material.text;
    category = widget.material.category;
    descriptionController.text = description;
    categoryController.text = category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: ButtonOneOption(
            function: () {
              if (description.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                    "Description field cannot be empty",
                    SnackBarType.error,
                    context));
              } else {
                editMaterial(StudyMaterial(
                    id: widget.material.id,
                    category: category,
                    text: description,
                    tutor: widget.user));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageQuizPage(
                              user: widget.user,
                              studyMaterial: widget.material,
                            )));
              }
            },
            text: 'MODIFY TEST',
            navigatorBack: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MaterialsPage(
                          user: widget.user,
                          shared: true,
                        )),
              );
            }),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(children: [
            const IndividualLogo(),
            Column(
              children: [
                IconLongerTextField(
                    controller: descriptionController,
                    hintText: 'Description',
                    icon: Icons.edit_outlined,
                    function: (_) {
                      setState(() {
                        description = descriptionController.text;
                      });
                    }),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  width: width * 0.8,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 5,
                    semanticContainer: true,
                    child: CustomDropdown(
                      hintText: 'Select category',
                      items: const [
                        'Mathematics',
                        'Physics',
                        'Science',
                        'History',
                        'Biology',
                        'Chemistry',
                        'Geography',
                        'Music',
                        'IT',
                        'Language',
                        'Literature',
                        'Art',
                        'Other',
                      ],
                      controller: categoryController,
                      onChanged: (value) {
                        setState(() {
                          category = categoryController.text;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }
}
