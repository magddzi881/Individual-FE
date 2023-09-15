// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:foldable_list/foldable_list.dart';
import 'package:individual/Database/chat_db.dart';
import 'package:individual/Database/message_db.dart';
import 'package:individual/Database/offer_db.dart';
import 'package:individual/Models/chat.dart';
import 'package:individual/Models/message.dart';
import 'package:individual/Models/offer.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/Chat/chat_preview.dart';
import 'package:individual/Pages/Tabs/Home/edit_offer.dart';
import 'package:individual/Pages/Tabs/Home/new_offer.dart';
import 'package:individual/Pages/Tabs/Profile/my_offers.dart';
import 'package:individual/Pages/menu.dart';
import 'package:individual/Widgets/button_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Widgets/offer_widgets.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

class OffersPage extends StatefulWidget {
  const OffersPage(
      {super.key, required this.user, this.category = '', this.search = ''});
  final String category;
  final User user;
  final String search;

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  late Future<List<Offer>> offers;
  List<Widget> items = [];
  List<Widget> foldableItems = [];

  @override
  void initState() {
    if (widget.category == '') {
      offers = getOffers();
    } else {
      if (widget.category == 'Search') {
        if (widget.search == '.') {
          offers = getOffers();
        } else {
          offers = getOffersByKeyword(widget.search);
        }
      } else {
        offers = getOffersByCategory(widget.category);
      }
    }
    super.initState();
  }

  void sortOffers(List<Offer> data) {
    for (int i = 0; i < data.length; i++) {
      items.add(ListItem(
        offer: data[i],
      ));
      (widget.user.username == data[i].tutor.username)
          ? foldableItems.add(ListItemFoldedOwner(
              delete: () async {
                bool deleted = await deleteOfferById(data[i].id);
                (deleted == false)
                    ? ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                        'An error occurred, try again later',
                        SnackBarType.error,
                        context))
                    : {
                        ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(
                                'Deleted', SnackBarType.success, context)),
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyOffers(
                                    user: widget.user,
                                  )),
                        )
                      };
              },
              edit: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditOfferPage(
                            offer: data[i],
                            fromProfile: false,
                          )),
                );
              },
              offer: data[i],
            ))
          : foldableItems.add(ListItemFolded(
              offer: data[i],
              onMessage: () async {
                Chat dataChat =
                    await getChat(widget.user.username, data[i].tutor.username);

                if (dataChat.id != -1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatPreview(
                                loggedUser: widget.user,
                                chat: dataChat,
                                lastlyViewed: dataChat.lastlyViewed,
                              )));
                } else {
                  String exampleMessage =
                      'Hi! I am interested in the offer "${data[i].title}" from ${data[i].category} category, can I ask you for more details';
                  Chat chat = Chat(
                      id: 0,
                      seen: false,
                      user1: widget.user,
                      user2: data[i].tutor,
                      lastlyViewed: DateTime.now(),
                      senderUsername: data[i].tutor.username,
                      lastMessageSendTime: DateTime.now(),
                      lastMessageBetween: exampleMessage);
                  Chat tempChat = await getChat(
                      widget.user.username, data[i].tutor.username);
                  int chatId = tempChat.id;
                  Message message = Message(
                      chatId: chatId,
                      id: 0,
                      sendTime: DateTime.now(),
                      text: exampleMessage,
                      senderUsername: widget.user.username,
                      receiverUsername: data[i].tutor.username);
                  addChat(chat).then((value) =>
                      addMessage(message).then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatPreview(
                                    loggedUser: widget.user,
                                    chat: chat,
                                    lastlyViewed: chat.lastlyViewed,
                                  )))));
                }
              },
            ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        bottomNavigationBar: ButtonOneOption(
            navigatorBack: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MenuPage(
                          user: widget.user,
                          selectedIndex: 0,
                        )),
              );
            },
            text: 'ADD NEW OFFER',
            function: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddOfferPage(
                            user: widget.user,
                            fromProfile: false,
                          )));
            }),
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            const IndividualLogo(),
            SizedBox(
                height: height * 0.75,
                width: width,
                child: FutureBuilder(
                  future: offers,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loading();
                    } else {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
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
                            'There is nothing here. Add an offer and be the first!',
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
                )),
          ],
        ));
  }
}
