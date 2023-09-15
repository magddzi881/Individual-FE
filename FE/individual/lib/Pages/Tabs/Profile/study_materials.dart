import 'package:flutter/material.dart';
import 'package:foldable_list/foldable_list.dart';
import 'package:individual/Database/study_materials_db.dart';
import 'package:individual/Models/study_material.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/Profile/Materials/new_material.dart';
import 'package:individual/Pages/menu.dart';
import 'package:individual/Utils/global_vars.dart';
import 'package:individual/Widgets/button_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Widgets/study_material_widgets.dart';

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({super.key, required this.user, this.shared = false});
  final User user;
  final bool shared;

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  late Future<List<StudyMaterial>> studyMaterials;
  List<Widget> foldableItems = [];
  List<Widget> items = [];

  @override
  void initState() {
    if (widget.shared == true) {
      studyMaterials = getSharedMaterials(widget.user.username);
    } else {
      studyMaterials = getUserAccessibleMaterials(widget.user.username);
    }

    super.initState();
  }

  void sortMaterials(List<StudyMaterial> data) {
    for (int i = 0; i < data.length; i++) {
      items.add(StudyMaterialCardFolded(
        data: data[i],
      ));
      (widget.shared == false)
          ? foldableItems.add(StudyMaterialCard(
              loggedUser: widget.user,
              data: data[i],
            ))
          : foldableItems.add(StudyMaterialCardOwner(
              data: data[i],
            ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: (widget.shared == false)
          ? ButtonBack(function: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MenuPage(
                          user: widget.user,
                          selectedIndex: 3,
                        )),
              );
            })
          : ButtonOneOption(
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewMaterialPage(
                            user: widget.user,
                          )),
                );
              },
              text: 'ADD MATERIAL',
              navigatorBack: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuPage(
                            user: widget.user,
                            selectedIndex: 3,
                          )),
                );
              }),
      body: Column(
        children: [
          const IndividualLogo(),
          SizedBox(
            height: height * 0.75,
            width: width,
            child: FutureBuilder(
              future: studyMaterials,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loading();
                } else {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    sortMaterials(snapshot.data!);
                    return FoldableList(
                      items: items,
                      foldableItems: foldableItems,
                    );
                  } else {
                    return Center(
                        child: SizedBox(
                      width: width * 0.7,
                      child: Text(
                        'There is nothing here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: height * 0.024,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ));
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
