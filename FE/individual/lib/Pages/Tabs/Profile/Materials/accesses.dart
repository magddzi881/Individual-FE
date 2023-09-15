import 'package:flutter/material.dart';
import 'package:individual/Database/access_db.dart';
import 'package:individual/Models/access.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Utils/global_vars.dart';
import 'package:individual/Widgets/access_widgets.dart';
import 'package:individual/Widgets/button_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';

class AccessPage extends StatefulWidget {
  const AccessPage(
      {super.key, required this.studyMaterialId, required this.loggedUser});
  final int studyMaterialId;
  final User loggedUser;

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  late Future<List<dynamic>> dynamics;
  late User toUser;
  @override
  void initState() {
    dynamics =
        getAccessesAndUsers(widget.loggedUser.username, widget.studyMaterialId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: ButtonBack(function: () {
        Navigator.of(context).pop();
      }),
      backgroundColor: background,
      body: Column(
        children: [
          const IndividualLogo(),
          SizedBox(
              height: height * 0.75,
              width: width,
              child: FutureBuilder(
                future: dynamics,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loading();
                  } else {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      List<Access> accesses = [];
                      List<User> users = [];
                      for (var element in snapshot.data!) {
                        if (element is Access) {
                          accesses.add(element);
                        } else if (element is User) {
                          users.add(element);
                        }
                      }
                      return Column(
                        children: [
                          SizedBox(
                            width: width,
                            height: height * 0.75,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                if (index < accesses.length) {
                                  return AccessTile(
                                    userTo: accesses[index].to,
                                    loggedUser: widget.loggedUser,
                                    accesId: accesses[index].id,
                                    studyMaterialId: widget.studyMaterialId,
                                    hasAccess: true,
                                  );
                                } else {
                                  int uIndex = index - accesses.length;
                                  return AccessTile(
                                    userTo: users[uIndex],
                                    loggedUser: widget.loggedUser,
                                    studyMaterialId: widget.studyMaterialId,
                                  );
                                }
                              },
                              itemCount: accesses.length + users.length,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                          child: SizedBox(
                        width: width * 0.7,
                        child: Text(
                          'There is nothing here. Add access!',
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
              )),
        ],
      ),
    );
  }
}
