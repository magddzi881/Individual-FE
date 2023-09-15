import 'package:individual/Models/user.dart';

class Schedule {
  final int id;
  final User user1;
  final User user2;
  final String category;
  final DateTime start;
  final DateTime end;

  Schedule(
      {required this.id,
      required this.user1,
      required this.user2,
      required this.category,
      required this.end,
      required this.start});
}
