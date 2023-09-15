import 'package:flutter/material.dart';
import 'package:individual/Database/schedule_db.dart';
import 'package:individual/Models/schedule.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/menu.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';
import 'package:individual/Widgets/offer_widgets.dart';
import 'package:intl/intl.dart';

class ScheduleTile extends StatelessWidget {
  const ScheduleTile(
      {super.key, required this.schedule, required this.loggedUser});
  final Schedule schedule;
  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('HH:mm');
    String formattedTimeRange =
        '${dateFormat.format(schedule.start)} - ${dateFormat.format(schedule.end)}';
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * 0.9,
      height: height * 0.11,
      child: Row(
        children: [
          SizedBox(
            width: width * 0.01,
          ),
          CategorySwitch(
            category: schedule.category,
          ),
          SizedBox(
            width: width * 0.04,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedTimeRange,
                style: TextStyle(
                    fontSize: height * 0.0195, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Text(
                '${schedule.user1.name} & ${schedule.user2.name} ${schedule.user2.surname}',
                style: TextStyle(fontSize: height * 0.018, color: Colors.grey),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          IconButton(
              onPressed: () async {
                await deleteSchedule(schedule.id).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                      'Lesson deleted', SnackBarType.success, context));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MenuPage(
                              user: loggedUser,
                              selectedIndex: 1,
                            )),
                  );
                });
              },
              icon: Icon(
                Icons.delete_forever_outlined,
                color: Colors.red,
                size: height * 0.03,
              ))
        ],
      ),
    );
  }
}
