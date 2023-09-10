import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:individual/Utils/global_vars.dart';

void sendChangedPassword(Map<String, String> data) async {
  final Map<String, dynamic> userData = {
    'address': data["address"],
    'name': data["name"],
    'surname': data["surname"],
    'username': data["username"],
  };
  await http.post(
    Uri.parse('$url/emails/sendChangedPassword'),
    headers: actionHeaders,
    body: json.encode(userData),
  );
}

void sendNewUser(Map<String, String> data) async {
  final Map<String, dynamic> userData = {
    'address': data["address"],
    'name': data["name"],
    'surname': data["surname"],
    'username': data["username"],
  };
  await http.post(
    Uri.parse('$url/emails/sendNewUser'),
    headers: actionHeaders,
    body: json.encode(userData),
  );
}
