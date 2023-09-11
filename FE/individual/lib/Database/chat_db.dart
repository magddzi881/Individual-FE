import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:individual/Database/user_db.dart';
import 'package:individual/Models/chat.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

Future<List<Chat>> getUsersChats(String username) async {
  final response = await http.get(Uri.parse('$url/chats/byUser?user=$username'),
      headers: getHeaders);

  if (response.statusCode == 200) {
    final List<dynamic> chatDataList = json.decode(response.body);
    List<Chat> chats = [];

    for (final chatData in chatDataList) {
      late User user1;
      late User user2;
      if (username == chatData['username1']) {
        user1 = await getUser(chatData['username1']);
        user2 = await getUser(chatData['username2']);
      } else {
        user2 = await getUser(chatData['username1']);
        user1 = await getUser(chatData['username2']);
      }

      Chat chat = Chat(
        id: chatData['id'],
        user1: user1,
        seen: chatData['seen'],
        user2: user2,
        senderUsername: chatData['senderUsername'],
        lastMessageSendTime: DateTime.parse(chatData['lastMessageSendTime']),
        lastlyViewed: DateTime.parse(chatData['lastlyViewed']),
        lastMessageBetween: chatData['lastMessageBetween'],
      );

      chats.add(chat);
    }

    return chats;
  } else {
    return [];
  }
}

Future<Chat> getChat(String username1, String username2) async {
  final response = await http.get(
    Uri.parse('$url/chats/betweenUsers?user1=$username1&user2=$username2'),
    headers: getHeaders,
  );

  if (response.statusCode == 200) {
    final chatData = json.decode(response.body);
    final List<Chat> chatList = [];

    for (final chatInfo in chatData) {
      User user1;
      User user2;

      if (username1 == chatInfo['username1']) {
        user1 = await getUser(chatInfo['username1']);
        user2 = await getUser(chatInfo['username2']);
      } else {
        user2 = await getUser(chatInfo['username1']);
        user1 = await getUser(chatInfo['username2']);
      }

      final chat = Chat(
        id: chatInfo['id'],
        lastMessageSendTime: DateTime.parse(chatInfo['lastMessageSendTime']),
        user1: user1,
        user2: user2,
        seen: chatInfo['seen'],
        senderUsername: chatInfo['senderUsername'],
        lastlyViewed: DateTime.parse(chatInfo['lastlyViewed']),
        lastMessageBetween: chatInfo['lastMessageBetween'],
      );
      chatList.add(chat);
    }

    return chatList.first;
  } else {
    return Chat(
        id: -1,
        seen: false,
        lastMessageSendTime: DateTime.now(),
        user1: User(
            username: 'username',
            email: 'email',
            password: 'password',
            name: 'name',
            surname: 'surname',
            yearOfBirth: 'yearOfBirth',
            gender: 'gender',
            avatarIndex: 2,
            rating: 3),
        user2: User(
            username: 'username',
            email: 'email',
            password: 'password',
            name: 'name',
            surname: 'surname',
            yearOfBirth: 'yearOfBirth',
            gender: 'gender',
            avatarIndex: 2,
            rating: 3),
        lastlyViewed: DateTime.now(),
        senderUsername: '',
        lastMessageBetween: 'lastMessageBetween');
  }
}

Future<bool> addChat(Chat chat) async {
  String formattedDate =
      "${chat.lastlyViewed.year}-${twoDigits(chat.lastlyViewed.month)}-${twoDigits(chat.lastlyViewed.day)} ${twoDigits(chat.lastlyViewed.hour)}:${twoDigits(chat.lastlyViewed.minute)}:${twoDigits(chat.lastlyViewed.second)}";
  String formattedLastMessageSendTime =
      "${chat.lastMessageSendTime.year}-${twoDigits(chat.lastMessageSendTime.month)}-${twoDigits(chat.lastMessageSendTime.day)} ${twoDigits(chat.lastMessageSendTime.hour)}:${twoDigits(chat.lastMessageSendTime.minute)}:${twoDigits(chat.lastMessageSendTime.second)}";

  bool added = false;
  final Map<String, dynamic> userData = {
    'username1': chat.user1.username,
    'username2': chat.user2.username,
    'lastMessageBetween': chat.lastMessageBetween,
    'lastlyViewed': formattedDate,
    'seen': chat.seen,
    'senderUsername': chat.senderUsername,
    'lastMessageSendTime': formattedLastMessageSendTime,
  };
  final response = await http.post(
    Uri.parse('$url/chats'),
    headers: actionHeaders,
    body: json.encode(userData),
  );
  if (response.statusCode == 200) {
    added = true;
  } else {}
  return added;
}

Future<bool> editChat(
    Chat chat, String lastMessage, DateTime messageTime) async {
  String formattedDate =
      "${chat.lastlyViewed.year}-${twoDigits(chat.lastlyViewed.month)}-${twoDigits(chat.lastlyViewed.day)} ${twoDigits(chat.lastlyViewed.hour)}:${twoDigits(chat.lastlyViewed.minute)}:${twoDigits(chat.lastlyViewed.second)}";

  String formattedLastMessageSendTime =
      "${messageTime.year}-${twoDigits(messageTime.month)}-${twoDigits(messageTime.day)} ${twoDigits(messageTime.hour)}:${twoDigits(messageTime.minute)}:${twoDigits(messageTime.second)}";

  final Map<String, dynamic> userData = {
    'username1': chat.user1.username,
    'username2': chat.user2.username,
    'lastMessageBetween': lastMessage,
    'lastlyViewed': formattedDate,
    'seen': chat.seen,
    'senderUsername': chat.senderUsername,
    'lastMessageSendTime': formattedLastMessageSendTime,
  };
  final response = await http.put(
    Uri.parse('$url/chats/${chat.id}'),
    headers: actionHeaders,
    body: json.encode(userData),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> editChatSeen(int id, bool seen) async {
  final Map<String, dynamic> chatData = {
    'seen': seen,
  };
  final response = await http.patch(
    Uri.parse('$url/chats/updateChatSeen?id=$id&seen=$seen'),
    headers: actionHeaders,
    body: json.encode(chatData),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
