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
  late Future<List<Access>> accesses;
  late Future<List<User>> chats;
  late User toUser;
  @override
  void initState() {
    accesses = getAccessesByMaterialId(widget.studyMaterialId);
    chats =
        getUniqueAccesses(widget.studyMaterialId, widget.loggedUser.username);
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
          Text(
            "Assigned accesses",
            style: TextStyle(fontSize: height * 0.02),
            textAlign: TextAlign.start,
          ),
          SizedBox(
              height: height * 0.4,
              width: width,
              child: FutureBuilder(
                future: accesses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loading();
                  } else {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return AccessTile(
                            userTo: snapshot.data![index].to,
                            loggedUser: widget.loggedUser,
                            accesId: snapshot.data![index].id,
                            studyMaterialId: widget.studyMaterialId,
                            hasAccess: true,
                          );
                        },
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
          Text(
            "Unassigned accesses",
            style: TextStyle(fontSize: height * 0.02),
            textAlign: TextAlign.start,
          ),
          SizedBox(
              height: height * 0.3,
              width: width,
              child: FutureBuilder(
                future: chats,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loading();
                  } else {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return AccessTile(
                            userTo: snapshot.data![index],
                            loggedUser: widget.loggedUser,
                            studyMaterialId: widget.studyMaterialId,
                          );
                        },
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
              ))
        ],
      ),
    );
  }
}
