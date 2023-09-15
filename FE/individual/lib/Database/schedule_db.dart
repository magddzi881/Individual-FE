import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:individual/Database/chat_db.dart';
import 'package:individual/Database/user_db.dart';
import 'package:individual/Models/chat.dart';
import 'package:individual/Models/schedule.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

Future<List<Schedule>> getSchedulesBetweenUsers(String username) async {
  List<Schedule> schedules = [];
  final response = await http.get(
      Uri.parse('$url/schedules/findByUsername?username=$username'),
      headers: getHeaders);
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    for (final s in data) {
      late User user1;
      late User user2;
      if (username == s['username1']) {
        user1 = await getUser(s['username1']);
        user2 = await getUser(s['username2']);
      } else {
        user2 = await getUser(s['username1']);
        user1 = await getUser(s['username2']);
      }
      final schedule = Schedule(
        id: s['id'],
        category: s['category'],
        user1: user1,
        user2: user2,
        start: DateTime.parse(s['start']),
        end: DateTime.parse(s['end']),
      );

      schedules.add(schedule);
    }
  } else {}
  return schedules;
}

Future<bool> addSchedule(Schedule schedule) async {
  bool added = false;
  String formattedStart =
      "${schedule.start.year}-${twoDigits(schedule.start.month)}-${twoDigits(schedule.start.day)} ${twoDigits(schedule.start.hour)}:${twoDigits(schedule.start.minute)}:${twoDigits(schedule.start.second)}";
  String formattedEnd =
      "${schedule.end.year}-${twoDigits(schedule.end.month)}-${twoDigits(schedule.end.day)} ${twoDigits(schedule.end.hour)}:${twoDigits(schedule.end.minute)}:${twoDigits(schedule.end.second)}";

  final Map<String, dynamic> ratingData = {
    'category': schedule.category,
    'username1': schedule.user1.username,
    'username2': schedule.user2.username,
    'start': formattedStart,
    'end': formattedEnd
  };

  final response = await http.post(
    Uri.parse('$url/schedules'),
    headers: actionHeaders,
    body: json.encode(ratingData),
  );

  if (response.statusCode == 201) {
    added = true;
  } else {}

  return added;
}

Future<List<User>> getUsersFromChats(String loggedUsername) async {
  List<Chat> chats = await getUsersChats(loggedUsername);

  List<User> users = [];

  for (int i = 0; i < chats.length; i++) {
    users.add(chats[i].user2);
  }

  return users;
}

Future deleteSchedule(int scheduleId) async {
  await http.delete(
    Uri.parse('$url/schedules/$scheduleId'),
    headers: getHeaders,
  );
}
