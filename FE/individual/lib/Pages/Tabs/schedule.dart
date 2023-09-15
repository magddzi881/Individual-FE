import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:individual/Database/schedule_db.dart';
import 'package:individual/Models/schedule.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/Schedule/new_schedule.dart';
import 'package:individual/Utils/global_vars.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Widgets/offer_widgets.dart';
import 'package:individual/Widgets/schedule_widgets.dart';

class SchedeluePage extends StatefulWidget {
  const SchedeluePage({super.key, required this.user});
  final User user;

  @override
  State<SchedeluePage> createState() => _SchedeluePageState();
}

class _SchedeluePageState extends State<SchedeluePage> {
  late Future<List<Schedule>> schedules;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    schedules = getSchedulesBetweenUsers(widget.user.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Stack(
          children: [
            Container(
              height: height * 0.34,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(235, 235, 233, 1),
                    Color.fromRGBO(235, 235, 233, 1)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
              ),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                  width: width,
                  height: height * 0.088,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        SizedBox(width: width * 0.57),
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            'I N D I V I D U A L',
                            style: TextStyle(
                                fontSize: height * 0.022,
                                color: mainColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  )),
              Container(
                alignment: Alignment.center,
                width: width,
                child: EasyDateTimeLine(
                  initialDate: DateTime.now(),
                  onDateChange: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  activeColor: mainColor,
                  dayProps: EasyDayProps(
                    borderColor: Colors.white,
                    todayHighlightStyle: TodayHighlightStyle.withBackground,
                    todayHighlightColor: secondaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.09,
              ),
              SizedBox(
                width: width * 0.9,
                height: height * 0.5,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewSchedulePage(
                                    user: widget.user,
                                    selectedDate: selectedDate,
                                  )),
                        );
                      },
                      child: SizedBox(
                        width: width * 0.9,
                        height: height * 0.11,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.01,
                            ),
                            const CategorySwitch(
                              category: 'Add',
                            ),
                            SizedBox(
                              width: width * 0.04,
                            ),
                            Text(
                              'Add private lesson to schedule',
                              style: TextStyle(fontSize: height * 0.0195),
                            )
                          ],
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: schedules,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Loading();
                        } else {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            snapshot.data!
                                .sort((a, b) => a.start.compareTo(b.start));
                            return SizedBox(
                              width: width * 0.9,
                              height: height * 0.38,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  if (snapshot.data![index].start.day ==
                                          selectedDate.day &&
                                      snapshot.data![index].start.month ==
                                          selectedDate.month &&
                                      snapshot.data![index].start.year ==
                                          selectedDate.year) {
                                    return ScheduleTile(
                                        loggedUser: widget.user,
                                        schedule: snapshot.data![index]);
                                  } else {
                                    return Container();
                                  }
                                },
                                itemCount: snapshot.data?.length,
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ]),
          ],
        )));
  }
}
