import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:individual/Database/chat_db.dart';
import 'package:individual/Database/user_db.dart';
import 'package:individual/Models/access.dart';
import 'package:individual/Models/chat.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Utils/global_vars.dart';

Future<List<int>> getStudyMaterialIdsByToUser(String usernameTo) async {
  final response = await http.get(
    Uri.parse('$url/accesses/studyMaterialIdsByToUser?toUser=$usernameTo'),
    headers: getHeaders,
  );

  if (response.statusCode == 200) {
    final List<dynamic> responseBody = json.decode(response.body);

    return responseBody.cast<int>();
  } else {
    throw Exception('Nie udało się pobrać danych.');
  }
}

Future<List<int>> getStudyMaterialIdsByFromUser(String usernameFrom) async {
  final response = await http.get(
    Uri.parse(
        '$url/accesses/studyMaterialIdsByFromUser?fromUser=$usernameFrom'),
    headers: getHeaders,
  );

  if (response.statusCode == 200) {
    final List<dynamic> responseBody = json.decode(response.body);

    return responseBody.cast<int>();
  } else {
    throw Exception('Nie udało się pobrać danych.');
  }
}

Future<List<Access>> getAccessesByMaterialId(int materialId) async {
  final response = await http.get(
      Uri.parse('$url/accesses/byMaterial/$materialId'),
      headers: getHeaders);

  List<Access> studyMaterials = [];

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    for (final a in data) {
      User from = await getUser(a['from']);
      User to = await getUser(a['to']);
      final access = Access(
        id: a['id'],
        from: from,
        to: to,
        studyMaterialId: a['studyMaterialId'],
      );
      studyMaterials.add(access);
    }
  } else {}
  return studyMaterials;
}

Future<List<User>> getUniqueAccesses(
    int studyMaterialId, String loggedUsername) async {
  List<Access> accesses = await getAccessesByMaterialId(studyMaterialId);
  List<Chat> chats = await getUsersChats(loggedUsername);

  List<User> users = [];
  List<User> aUsers = [];
  for (int i = 0; i < accesses.length; i++) {
    users.add(accesses[i].to);
    aUsers.add(accesses[i].to);
  }

  for (int i = 0; i < chats.length; i++) {
    users.add(chats[i].user2);
  }
  List<User> result = [];

  for (var user in users) {
    if (!aUsers.any((aUser) => aUser.username == user.username)) {
      result.add(user);
    }
  }

  return result;
}

Future<bool> addAccess(Access access) async {
  bool added = false;

  final Map<String, dynamic> ratingData = {
    'from': access.from.username,
    'to': access.to.username,
    'studyMaterialId': access.studyMaterialId,
  };

  final response = await http.post(
    Uri.parse('$url/accesses'),
    headers: actionHeaders,
    body: json.encode(ratingData),
  );

  if (response.statusCode == 201) {
    added = true;
  } else {}

  return added;
}

Future<bool> deleteAccessById(int accesId) async {
  final response = await http.delete(
    Uri.parse('$url/accesses/$accesId'),
    headers: getHeaders,
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
