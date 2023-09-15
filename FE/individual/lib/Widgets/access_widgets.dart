import 'package:flutter/material.dart';
import 'package:individual/Database/access_db.dart';
import 'package:individual/Models/access.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/Profile/Materials/accesses.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

class AccessTile extends StatelessWidget {
  const AccessTile(
      {super.key,
      required this.userTo,
      required this.loggedUser,
      required this.studyMaterialId,
      this.accesId = 0,
      this.hasAccess = false});
  final User userTo;
  final bool hasAccess;
  final User loggedUser;
  final int studyMaterialId;
  final int accesId;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.1,
      width: width,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.all(0),
        child: Row(
          children: [
            SizedBox(
              width: width * 0.03,
            ),
            CircleAvatar(
              radius: height * 0.045,
              backgroundColor: Colors.white,
              child: Image.asset('assets/${userTo.avatarIndex}.png'),
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.6,
                      child: Text(
                        '${userTo.name} ${userTo.surname} ${calculateAge(int.parse(userTo.yearOfBirth))}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: height * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  width: width * 0.6,
                  height: height * 0.022,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (hasAccess == false) {
                            addAccess(Access(
                                id: 0,
                                from: loggedUser,
                                to: userTo,
                                studyMaterialId: studyMaterialId));

                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar('Access added',
                                    SnackBarType.success, context));
                          } else {
                            deleteAccessById(accesId);
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar('Access deleted',
                                    SnackBarType.success, context));
                          }

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccessPage(
                                      loggedUser: loggedUser,
                                      studyMaterialId: studyMaterialId,
                                    )),
                          );
                        },
                        child: Text(
                            (hasAccess == false)
                                ? "Add access"
                                : "Delete access",
                            style: TextStyle(
                                color: (hasAccess == false)
                                    ? mainColor
                                    : Colors.red,
                                fontSize: height * 0.017,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
