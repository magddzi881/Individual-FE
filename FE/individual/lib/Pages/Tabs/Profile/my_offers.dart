// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:foldable_list/foldable_list.dart';
import 'package:individual/Database/offer_db.dart';
import 'package:individual/Models/offer.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/Home/edit_offer.dart';
import 'package:individual/Pages/Tabs/Home/new_offer.dart';
import 'package:individual/Pages/menu.dart';
import 'package:individual/Widgets/button_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Widgets/offer_widgets.dart';
import 'package:individual/Widgets/rating_widgets.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

class MyOffers extends StatefulWidget {
  const MyOffers({super.key, required this.user});

  final User user;

  @override
  State<MyOffers> createState() => _MyOffersState();
}

class _MyOffersState extends State<MyOffers> {
  late Future<List<Offer>> offers;
  List<Widget> items = [];
  List<Widget> foldableItems = [];

  @override
  void initState() {
    offers = getOffersByTutorUsername(widget.user.username);
    super.initState();
  }

  void sortOffers(List<Offer> data) {
    for (int i = 0; i < data.length; i++) {
      items.add(ListItem(
        offer: data[i],
      ));
      foldableItems.add(ListItemFoldedOwner(
        offer: data[i],
        edit: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => EditOfferPage(
                      offer: data[i],
                    )),
          );
        },
        delete: () async {
          bool deleted = await deleteOfferById(data[i].id);
          (deleted == false)
              ? ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                  'An error occurred, try again later',
                  SnackBarType.error,
                  context))
              : {
                  ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar('Deleted', SnackBarType.success, context)),
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyOffers(
                              user: widget.user,
                            )),
                  )
                };
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: background,
      bottomNavigationBar: ButtonOneOption(
          navigatorBack: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MenuPage(
                        user: widget.user,
                        selectedIndex: 2,
                      )),
            );
          },
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddOfferPage(
                          user: widget.user,
                        )));
          },
          text: 'ADD NEW OFFER'),
      body: Column(
        children: [
          const IndividualLogo(),
          SizedBox(
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Your Current Rating',
                      style: TextStyle(
                          fontSize: height * 0.018,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    RatingStarBar(
                        rating: widget.user.rating, updateRanking: (_) {}),
                    SizedBox(
                      height: height * 0.022,
                    ),
                    Container(
                      height: height * 0.001,
                      width: width * 0.82,
                      color: const Color.fromARGB(255, 204, 203, 203),
                    ),
                    SingleChildScrollView(
                        child: SizedBox(
                            height: height * 0.635,
                            width: width,
                            child: FutureBuilder(
                              future: offers,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Loading();
                                } else {
                                  if (snapshot.hasData &&
                                      snapshot.data!.isNotEmpty) {
                                    sortOffers(snapshot.data!);
                                    return FoldableList(
                                      items: items,
                                      foldableItems: foldableItems,
                                    );
                                  } else {
                                    return Center(
                                        child: SizedBox(
                                      width: width * 0.7,
                                      child: Text(
                                        'There is nothing here. Add an offer today!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: height * 0.024,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ));
                                  }
                                }
                              },
                            )))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
