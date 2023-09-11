import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:individual/Database/chat_db.dart';
import 'package:individual/Models/chat.dart';
import 'package:individual/Models/message.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

Future<Message> getLatestMessage(String username1, String username2) async {
  Chat chat = await getChat(username1, username2);
  final response = await http.get(
      Uri.parse('$url/chats/latestMessage?user1=$username1&user2=$username2'),
      headers: getHeaders);

  if (response.statusCode == 200) {
    final messageData = json.decode(response.body);

    final message = Message(
      chatId: chat.id,
      id: messageData['id'],
      sendTime: DateTime.parse(messageData['sendTime']),
      text: messageData['text'],
      receiverUsername: messageData['receiverUsername'],
      senderUsername: messageData['senderUsername'],
    );

    return message;
  } else {
    return Message(
        chatId: -1,
        id: -1,
        sendTime: DateTime.now(),
        text: 'text',
        receiverUsername: 'receiverUsername',
        senderUsername: 'senderUsername');
  }
}

Future<List<Message>> getMessagesBetweenUsers(
    String username1, String username2) async {
  final response = await http.get(
      Uri.parse(
          '$url/messages/betweenUsers?username1=$username1&username2=$username2'),
      headers: getHeaders);

  if (response.statusCode == 200) {
    final List<dynamic> chatDataList = json.decode(response.body);
    List<Message> messages = [];

    for (final chatData in chatDataList) {
      Chat chat = await getChat(username1, username2);
      Message message = Message(
          chatId: chat.id,
          id: chatData['id'],
          sendTime: DateTime.parse(chatData['sendTime']),
          text: chatData['text'],
          receiverUsername: chatData['receiverUsername'],
          senderUsername: chatData['senderUsername']);

      messages.add(message);
    }
    return messages;
  } else {
    return [];
  }
}

Future<List<Message>> getMessagesByChatId(int chatId) async {
  final response = await http.get(
      Uri.parse('$url/messages/findByChatId/$chatId'),
      headers: getHeaders);

  if (response.statusCode == 200) {
    final List<dynamic> chatDataList = json.decode(response.body);
    List<Message> messages = [];

    for (final chatData in chatDataList) {
      Message message = Message(
          chatId: chatId,
          id: chatData['id'],
          sendTime: DateTime.parse(chatData['sendTime']),
          text: chatData['text'],
          receiverUsername: chatData['receiverUsername'],
          senderUsername: chatData['senderUsername']);

      messages.add(message);
    }
    return messages;
  } else {
    return [];
  }
}

Future<bool> addMessage(Message message) async {
  String formattedDate =
      "${message.sendTime.year}-${twoDigits(message.sendTime.month)}-${twoDigits(message.sendTime.day)} ${twoDigits(message.sendTime.hour)}:${twoDigits(message.sendTime.minute)}:${twoDigits(message.sendTime.second)}";
  Chat chat = await getChat(message.senderUsername, message.receiverUsername);
  bool added = false;
  final Map<String, dynamic> userData = {
    'chatId': chat.id,
    'senderUsername': message.senderUsername,
    'receiverUsername': message.receiverUsername,
    'text': message.text,
    'sendTime': formattedDate,
  };
  final response = await http.post(
    Uri.parse('$url/messages'),
    headers: actionHeaders,
    body: json.encode(userData),
  );
  if (response.statusCode == 200) {
    added = true;
  } else {}
  return added;
}
