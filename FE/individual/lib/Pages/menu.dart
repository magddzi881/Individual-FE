import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/chat.dart';
import 'package:individual/Pages/Tabs/home.dart';
import 'package:individual/Pages/Tabs/profile.dart';

// ignore: must_be_immutable
class MenuPage extends StatefulWidget {
  MenuPage({super.key, required this.user, this.selectedIndex = 0});
  final User user;
  late int selectedIndex;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Widget> tabItems = [];

  @override
  void initState() {
    tabItems = [
      Home(
        user: widget.user,
      ),
      ChatPage(
        loggedUser: widget.user,
      ),
      Profile(user: widget.user),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: tabItems[widget.selectedIndex],
      ),
      bottomNavigationBar: FlashyTabBar(
        animationCurve: Curves.linear,
        selectedIndex: widget.selectedIndex,
        iconSize: height * 0.035,
        onItemSelected: (index) => setState(() {
          widget.selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home_outlined),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: height * 0.018,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.messenger_outline_outlined),
            title: Text(
              'Chat',
              style: TextStyle(
                fontSize: height * 0.018,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.person_outline),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: height * 0.018,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
