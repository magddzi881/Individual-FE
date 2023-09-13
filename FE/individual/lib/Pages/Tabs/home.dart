// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Widgets/form_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Widgets/offer_widgets.dart';
import 'package:individual/Utils/functions.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.user});
  final User user;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  String search = '.';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: height * 0.24,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(235, 235, 233, 1),
                  Color.fromRGBO(235, 235, 233, 1)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0),
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: height * 0.9,
              child: Column(
                children: [
                  const IndividualLogo(),
                  SearchTextField(
                      hintText: 'Biology final exam...',
                      controller: searchController,
                      showLabel: false,
                      searchFunction: () async {
                        setState(() {
                          navigatorCategories(widget.user, context,
                              category: 'Search', search: search);
                        });
                        searchController.text = '';
                        search = '.';
                      },
                      function: (_) {
                        setState(() {
                          search = searchController.text;
                        });
                      }),
                  SingleChildScrollView(
                    child: Center(
                      child: SizedBox(
                        width: width * 0.9,
                        height: height * 0.655,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            CustomTile(
                                title: 'All',
                                function: () async {
                                  navigatorCategories(
                                    widget.user,
                                    context,
                                  );
                                }),
                            CustomTile(
                              title: 'Mathematics',
                              function: () async {
                                navigatorCategories(widget.user, context,
                                    category: 'Mathematics');
                              },
                            ),
                            CustomTile(
                              title: 'Physics',
                              function: () async {
                                navigatorCategories(widget.user, context,
                                    category: 'Physics');
                              },
                            ),
                            CustomTile(
                              title: 'Science',
                              function: () async {
                                navigatorCategories(widget.user, context,
                                    category: 'Science');
                              },
                            ),
                            CustomTile(
                              title: 'History',
                              function: () async {
                                navigatorCategories(widget.user, context,
                                    category: 'History');
                              },
                            ),
                            CustomTile(
                              title: 'Biology',
                              function: () async {
                                navigatorCategories(widget.user, context,
                                    category: 'Biology');
                              },
                            ),
                            CustomTile(
                              title: 'Chemistry',
                              function: () async {
                                navigatorCategories(widget.user, context,
                                    category: 'Chemistry');
                              },
                            ),
                            CustomTile(
                              title: 'Art',
                              function: () async {
                                navigatorCategories(widget.user, context,
                                    category: 'Art');
                              },
                            ),
                            CustomTile(
                              title: 'Geography',
                              function: () async {
                                navigatorCategories(widget.user, context,
                                    category: 'Geography');
                              },
                            ),
                            CustomTile(
                              title: 'Music',
                              function: () async {
                                navigatorCategories(widget.user, context,
                                    category: 'Music');
                              },
                            ),
                            CustomTile(
                              title: 'IT',
                              function: () async {
                                navigatorCategories(widget.user, context,
                                    category: 'IT');
                              },
                            ),
                            CustomTile(
                              title: 'Language',
                              function: () async {
                                navigatorCategories(widget.user, context,
                                    category: 'Language');
                              },
                            ),
                            CustomTile(
                              title: 'Literature',
                              function: () async {
                                navigatorCategories(widget.user, context,
                                    category: 'Literature');
                              },
                            ),
                            CustomTile(
                              title: 'Other',
                              function: () async {
                                navigatorCategories(widget.user, context,
                                    category: 'Other');
                              },
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
