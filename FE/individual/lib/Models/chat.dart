import 'package:individual/Models/message.dart';
import 'package:individual/Models/user.dart';

const List<Message> defaultList = [];

class Chat {
  final int id;
  final User user1;
  final User user2;
  final String lastMessageBetween;
  DateTime lastlyViewed;
  final String senderUsername;
  bool seen;
  final DateTime lastMessageSendTime;

  Chat(
      {required this.id,
      required this.user1,
      required this.user2,
      required this.seen,
      required this.lastlyViewed,
      required this.senderUsername,
      required this.lastMessageBetween,
      required this.lastMessageSendTime});
}
