import 'package:flutter/material.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/Profile/edit_profile.dart';
import 'package:individual/Pages/Tabs/Profile/my_offers.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Widgets/profile_widgets.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.user});
  final User user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User user;

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: background,
      body: Stack(children: [
        const IndividualLogo(),
        Column(
          children: [
            SizedBox(
              height: height * 0.4,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.065,
                  ),
                  CircleAvatar(
                    radius: height * 0.09,
                    backgroundColor: background,
                    child: Image.asset('assets/${user.avatarIndex}.png'),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    '${user.name} ${user.surname} ${calculateAge(int.parse(user.yearOfBirth))}',
                    style: TextStyle(
                        fontSize: height * 0.02,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: height * 0.007,
                  ),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: height * 0.02,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.5,
              width: width,
              child: Card(
                  elevation: 0,
                  margin: const EdgeInsets.all(0),
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Container(
                    height: height * 0.4,
                    width: width * 0.8,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.04,
                        ),
                        CustomProfileTile(
                          function: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                        user: user,
                                      )),
                            );
                          },
                          title: 'Edit Profile',
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        CustomProfileTile(
                          function: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyOffers(
                                        user: user,
                                      )),
                            );
                          },
                          title: 'My Offers',
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        CustomProfileTile(
                          title: 'Help & About',
                          function: () {
                            Navigator.of(context).pushNamed('/help');
                          },
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        CustomProfileTile(
                          function: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/login', (route) => false);
                          },
                          title: 'Log Out',
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ]),
    );
  }
}
