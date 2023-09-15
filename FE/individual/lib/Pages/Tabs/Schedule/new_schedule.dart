// ignore_for_file: use_build_context_synchronously

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:individual/Database/schedule_db.dart';
import 'package:individual/Database/user_db.dart';
import 'package:individual/Models/schedule.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/menu.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';
import 'package:individual/Widgets/button_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:time_range/time_range.dart';

class NewSchedulePage extends StatefulWidget {
  const NewSchedulePage(
      {super.key, required this.user, required this.selectedDate});
  final User user;
  final DateTime selectedDate;

  @override
  State<NewSchedulePage> createState() => _NewSchedulePageState();
}

class _NewSchedulePageState extends State<NewSchedulePage> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController usersController = TextEditingController();
  DateTime startDate = DateTime.parse("1992-09-15 14:30:00.123456");
  DateTime endDate = DateTime.parse("1992-09-15 14:30:00.123456");
  String category = 'Other';
  String selectedUser = '';
  late Future<List<User>> users;

  @override
  void dispose() {
    categoryController.dispose();
    usersController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    users = getUsersFromChats(widget.user.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: backgroundColor,
        bottomNavigationBar: ButtonOneOption(
            navigatorBack: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MenuPage(
                          user: widget.user,
                          selectedIndex: 1,
                        )),
              );
            },
            function: () async {
              if (startDate == DateTime.parse("1992-09-15 14:30:00.123456") ||
                  endDate == DateTime.parse("1992-09-15 14:30:00.123456")) {
                ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                    'Select correct time range', SnackBarType.error, context));
              } else {
                if (selectedUser.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                      'Select correct user', SnackBarType.error, context));
                } else {
                  List<String> nameParts = selectedUser.split(' ');
                  String firstName = nameParts[2];
                  User user2 = await getUser(firstName);
                  addSchedule(Schedule(
                          id: 0,
                          user1: widget.user,
                          user2: user2,
                          category: category,
                          end: endDate,
                          start: startDate))
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                        'Lesson added', SnackBarType.success, context));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MenuPage(
                                user: widget.user,
                                selectedIndex: 1,
                              )),
                    );
                  });
                }
              }
            },
            text: 'ADD LESSON'),
        body: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height * 0.9,
            child: FutureBuilder(
              future: users,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loading();
                } else {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<String> usersData = [];
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      usersData.add(
                          '${snapshot.data?[i].name} ${snapshot.data?[i].surname} ${snapshot.data?[i].username}');
                    }
                    return Column(
                      children: [
                        const IndividualLogo(),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: height * 0.022,
                          width: width * 0.77,
                          child: Text(
                            'Selected date',
                            style: TextStyle(
                              fontSize: height * 0.018,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.012,
                        ),
                        Container(
                          height: height * 0.065,
                          alignment: Alignment.center,
                          width: width * 0.8,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            elevation: 5,
                            semanticContainer: true,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.06,
                                  width: width * 0.02,
                                ),
                                SizedBox(
                                  height: height * 0.06,
                                  width: width * 0.065,
                                  child: Icon(
                                    Icons.date_range_outlined,
                                    size: height * 0.03,
                                    color: mainColor,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.06,
                                  width: width * 0.03,
                                ),
                                Text(
                                  '${widget.selectedDate.day}.${widget.selectedDate.month}.${widget.selectedDate.year}',
                                  style: TextStyle(
                                      fontSize: height * 0.02,
                                      color: mainColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: height * 0.022,
                          width: width * 0.77,
                          child: Text(
                            'Category',
                            style: TextStyle(
                              fontSize: height * 0.018,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.012,
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
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
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: height * 0.022,
                          width: width * 0.77,
                          child: Text(
                            'Student',
                            style: TextStyle(
                              fontSize: height * 0.018,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.012,
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            elevation: 5,
                            semanticContainer: true,
                            child: CustomDropdown(
                              hintText: 'Select student',
                              items: usersData,
                              controller: usersController,
                              onChanged: (value) {
                                setState(() {
                                  selectedUser = usersController.text;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.07,
                        ),
                        SizedBox(
                          width: width * 0.9,
                          child: TimeRange(
                              fromTitle: Text(
                                'Start time',
                                style: TextStyle(
                                  fontSize: height * 0.02,
                                ),
                              ),
                              toTitle: Text(
                                'End time',
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                              titlePadding: width * 0.02,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87,
                                  fontSize: height * 0.019),
                              activeTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: height * 0.019),
                              borderColor: Colors.white,
                              backgroundColor: Colors.transparent,
                              activeBorderColor: mainColor,
                              activeBackgroundColor: mainColor,
                              alwaysUse24HourFormat: true,
                              firstTime: const TimeOfDay(hour: 5, minute: 00),
                              lastTime: const TimeOfDay(hour: 23, minute: 50),
                              timeStep: 10,
                              timeBlock: 30,
                              onRangeCompleted: (range) {
                                if (range != null) {
                                  setState(() {
                                    startDate = widget.selectedDate;
                                    int hourS = range.start.hour;
                                    int minuteS = range.start.minute;
                                    startDate = DateTime(
                                        startDate.year,
                                        startDate.month,
                                        startDate.day,
                                        hourS,
                                        minuteS);

                                    endDate = widget.selectedDate;
                                    int hourE = range.end.hour;
                                    int minuteE = range.end.minute;
                                    endDate = DateTime(
                                        endDate.year,
                                        endDate.month,
                                        endDate.day,
                                        hourE,
                                        minuteE);
                                  });
                                } else {
                                  setState(() {
                                    startDate = DateTime.parse(
                                        "1992-09-15 14:30:00.123456");
                                    endDate = DateTime.parse(
                                        "1992-09-15 14:30:00.123456");
                                  });
                                }
                              }),
                        )
                      ],
                    );
                  } else {
                    return Center(
                        child: SizedBox(
                      width: width * 0.7,
                      child: Text(
                        'You cannot add lesson. Chat with users first!',
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
        ));
  }
}
