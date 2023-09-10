import 'dart:math';

import 'package:flutter/material.dart';
import 'package:individual/Database/user_db.dart';
import 'package:individual/Models/chat.dart';
import 'package:individual/Models/rating.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/Home/offers.dart';
import 'package:individual/Utils/global_vars.dart';

navigatorWithAnimation(
    BuildContext context,
    double sidex,
    Widget Function(BuildContext, Animation<double>, Animation<double>) page,
    Map arguments,
    {double sidey = 0.0}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      settings: RouteSettings(arguments: arguments),
      pageBuilder: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(sidex, sidey);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}

navigatorReplacementWithAnimation(
    BuildContext context,
    double sidex,
    Widget Function(BuildContext, Animation<double>, Animation<double>) page,
    Map arguments,
    {double sidey = 0.0}) {
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      settings: RouteSettings(arguments: arguments),
      pageBuilder: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(sidex, sidey);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}

int calculateAge(int yearOfBirth) {
  int currentYear = DateTime.now().year;
  int result = currentYear - yearOfBirth;
  return result;
}

Color generateRandomColor() {
  final random = Random();
  final red = random.nextInt(256);
  final green = random.nextInt(256);
  final blue = random.nextInt(256);

  return Color.fromRGBO(red, green, blue, 1.0);
}

SnackBar customSnackBar(String title, SnackBarType type, BuildContext context) {
  final double height = MediaQuery.of(context).size.height;
  final SnackBar snackBar = SnackBar(
    content: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: height * 0.022,
          fontWeight: FontWeight.bold,
          color: Colors.white),
    ),
    backgroundColor: (type == SnackBarType.success)
        ? Colors.deepPurpleAccent
        : ((type == SnackBarType.error)
            ? Colors.pinkAccent
            : Colors.lightBlueAccent),
    duration: const Duration(
      seconds: 2,
    ),
  );
  return snackBar;
}

Future<bool> logIn(String username, String password) async {
  bool auth = false;
  User user = await getUserPassword(username);
  if (password == user.password) {
    auth = true;
  }
  return auth;
}

Future<bool> restoreCheck(String username, String yearOfBirth) async {
  bool auth = false;
  User user = await getUserYearOfBirth(username);
  if (yearOfBirth == user.yearOfBirth) {
    auth = true;
  }
  return auth;
}

void navigatorCategories(User user, BuildContext context,
    {String category = '', String search = ''}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OffersPage(
                user: user,
                category: category,
                search: search,
              )));
}

String twoDigits(int n) {
  if (n >= 10) {
    return "$n";
  }
  return "0$n";
}

double calculateAverageRating(List<Rating> ratings, String username) {
  final userRatings = ratings.where((rating) => rating.to == username).toList();

  if (userRatings.isEmpty) {
    return -1.0;
  }

  double sum = 0.0;
  for (final rating in userRatings) {
    sum += rating.rating;
  }

  double average = sum / userRatings.length;
  return average;
}

bool hasUserAlreadyRated(
    List<Rating> ratings, String fromUsername, String toUsername) {
  return ratings
      .any((rating) => rating.from == fromUsername && rating.to == toUsername);
}

bool hasUserSeenMessage(Chat chat, String loggedUser) {
  final bool isUser1 = chat.senderUsername == loggedUser;
  return (isUser1 == true) &&
      chat.lastlyViewed.isAfter(chat.lastMessageSendTime) == false;
}

bool checkAge(String yearOfBirth) {
  int? birthYear = int.tryParse(yearOfBirth);

  if (birthYear == null) {
    return false;
  }

  int age = DateTime.now().year - birthYear;

  if (age < 16) {
    return false;
  }
  if (age > 101) {
    return false;
  }

  return true;
}

bool checkPrice(String price) {
  int? newPrice = int.tryParse(price);

  if (newPrice == null) {
    return false;
  }

  return true;
}

bool doesUsernameExist(String usernameToCheck, List<String> usernames) {
  return usernames.contains(usernameToCheck);
}
