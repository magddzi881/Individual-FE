import 'package:flutter/material.dart';

enum SnackBarType { success, error, info }

Color backgroundColor = const Color.fromRGBO(235, 235, 233, 1);
Color mainColor = const Color(0xff85A389);
Color secondaryColor = const Color(0xffE1ECC8);

String url = 'http://10.0.2.2:8080';
Map<String, String> getHeaders = {
  "Accept": "application/json",
  "Content-Type": "application/x-www-form-urlencoded"
};
Map<String, String> actionHeaders = {
  "Accept": "application/json",
  'Content-Type': 'application/json',
};
