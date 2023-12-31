import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:individual/Models/user.dart';
import 'package:individual/Utils/global_vars.dart';

Future<List<String>> getUserUsernames() async {
  final List<String> usernames = [];
  final response = await http.get(Uri.parse('$url/users'), headers: getHeaders);

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);

    for (var data in jsonData) {
      final String username = data['username'];
      usernames.add(username);
    }
  }

  return usernames;
}

Future<User> getUser(String username) async {
  User user = User(
    username: '',
    email: '',
    password: 'xxx',
    name: '',
    surname: '',
    yearOfBirth: '',
    gender: '',
    avatarIndex: 0,
    rating: 0.0,
  );
  final response = await http.get(Uri.parse('$url/users/old/$username'),
      headers: getHeaders);
  if (response.statusCode == 200) {
    final Map<String, dynamic> userData = json.decode(response.body);
    user = User(
      username: userData['username'],
      email: userData['email'],
      password: '',
      name: userData['name'],
      surname: userData['surname'],
      yearOfBirth: userData['yearOfBirth'],
      gender: userData['gender'],
      avatarIndex: userData['avatarIndex'],
      rating: userData['rating'].toDouble(),
    );
  } else {}
  return user;
}

Future<User> authUser(String username, String password) async {
  User user = User(
    username: '',
    email: '',
    password: 'xxx',
    name: '',
    surname: '',
    yearOfBirth: '',
    gender: '',
    avatarIndex: 0,
    rating: 0.0,
  );
  final response = await http.get(
      Uri.parse('$url/users/$username?password=$password'),
      headers: getHeaders);
  print('$url/users/$username?password=$password');
  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    final Map<String, dynamic> userData = json.decode(response.body);
    user = User(
      username: userData['username'],
      email: userData['email'],
      password: userData['password'],
      name: userData['name'],
      surname: userData['surname'],
      yearOfBirth: userData['yearOfBirth'],
      gender: userData['gender'],
      avatarIndex: userData['avatarIndex'],
      rating: userData['rating'].toDouble(),
    );
  } else if (response.statusCode == 401) {
    user.rating = -1;
    return user;
  } else {}
  return user;
}

Future<User> getUserPassword(String username) async {
  User user = User(
    username: '',
    email: '',
    password: 'xxx',
    name: '',
    surname: '',
    yearOfBirth: '',
    gender: '',
    avatarIndex: 0,
    rating: 0.0,
  );
  final response =
      await http.get(Uri.parse('$url/users/$username'), headers: getHeaders);
  if (response.statusCode == 200) {
    final Map<String, dynamic> userData = json.decode(response.body);
    user = User(
      username: userData['username'],
      email: '',
      password: userData['password'],
      name: '',
      surname: '',
      yearOfBirth: '',
      gender: 'ND',
      avatarIndex: 1,
      rating: 0.0,
    );
  } else {}
  return user;
}

Future<User> getUserYearOfBirth(String username) async {
  User user = User(
    username: '',
    email: '',
    password: 'xxx',
    name: '',
    surname: '',
    yearOfBirth: '',
    gender: '',
    avatarIndex: 0,
    rating: 0.0,
  );
  final response = await http.get(Uri.parse('$url/users/old/$username'),
      headers: getHeaders);
  if (response.statusCode == 200) {
    final Map<String, dynamic> userData = json.decode(response.body);
    user = User(
      username: userData['username'],
      email: '',
      password: '',
      name: '',
      surname: '',
      yearOfBirth: userData['yearOfBirth'],
      gender: 'ND',
      avatarIndex: 1,
      rating: 0.0,
    );
  } else {}
  return user;
}

Future<bool> addUser(User user) async {
  bool added = false;
  final Map<String, dynamic> userData = {
    'username': user.username,
    'email': user.email,
    'password': user.password,
    'name': user.name,
    'surname': user.surname,
    'yearOfBirth': user.yearOfBirth,
    'gender': user.gender,
    'avatarIndex': user.avatarIndex,
    'rating': user.rating,
  };
  final response = await http.post(
    Uri.parse('$url/users'),
    headers: actionHeaders,
    body: json.encode(userData),
  );
  if (response.statusCode == 200) {
    added = true;
  } else {}
  return added;
}

Future<bool> editUser(User user) async {
  bool edited = false;
  final Map<String, dynamic> userData = {
    'username': user.username,
    'email': user.email,
    'password': user.password,
    'name': user.name,
    'surname': user.surname,
    'yearOfBirth': user.yearOfBirth,
    'gender': user.gender,
    'avatarIndex': user.avatarIndex,
    'rating': user.rating,
  };
  final response = await http.put(
    Uri.parse('$url/users/${user.username}'),
    headers: actionHeaders,
    body: json.encode(userData),
  );

  if (response.statusCode == 200) {
    edited = true;
  } else {}
  return edited;
}
