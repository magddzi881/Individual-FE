// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:individual/Database/chat_db.dart';
import 'package:individual/Models/chat.dart';
import 'package:individual/Pages/Tabs/Chat/chat_preview.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Database/rating_db.dart';
import 'package:individual/Database/user_db.dart';
import 'package:individual/Models/rating.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/menu.dart';
import 'package:individual/Widgets/rating_widgets.dart';
import 'package:individual/Utils/global_vars.dart';

class ChatTile extends StatelessWidget {
  ChatTile(
      {super.key,
      required this.chat,
      required this.messageSendTime,
      required this.loggedUser});
  Chat chat;
  final String messageSendTime;
  final String loggedUser;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final bool seen = !chat.seen && loggedUser == chat.senderUsername;

    return GestureDetector(
      onTap: () {
        if (loggedUser == chat.senderUsername) {
          editChatSeen(chat.id, true);
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatPreview(chat: chat, lastlyViewed: chat.lastlyViewed)));
      },
      child: SizedBox(
        width: width * 0.95,
        height: height * 0.12,
        child: Card(
          elevation: 0,
          margin: const EdgeInsets.all(0),
          child: Row(
            children: [
              SizedBox(
                width: width * 0.03,
              ),
              CircleAvatar(
                radius: height * 0.045,
                backgroundColor: Colors.white,
                child: Image.asset('assets/${chat.user2.avatarIndex}.png'),
              ),
              SizedBox(
                width: width * 0.03,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.6,
                        child: Text(
                          '${chat.user2.name} ${chat.user2.surname} ${calculateAge(int.parse(chat.user2.yearOfBirth))}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: height * 0.02,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    width: width * 0.6,
                    height: height * 0.022,
                    child: Text(chat.lastMessageBetween,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: height * 0.018,
                          color: (seen == true) ? Colors.black : Colors.grey,
                        )),
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * 0.12,
                    child: Text(messageSendTime,
                        style: TextStyle(
                          fontSize: height * 0.018,
                          color: Colors.grey,
                        )),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(
                          (seen == true)
                              ? Icons.sms_outlined
                              : Icons.done_all_outlined,
                          size: height * 0.025,
                          color: (seen == true)
                              ? Colors.amber
                              : Colors.deepPurpleAccent),
                    ],
                  )
                ],
              ),
              SizedBox(
                width: width * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IndividualLogoWithAvatar extends StatelessWidget {
  IndividualLogoWithAvatar(
      {super.key,
      this.color = Colors.deepPurpleAccent,
      required this.user1,
      required this.chat,
      this.rating = 5,
      required this.user2});
  final Color color;
  final User user1;
  final User user2;
  double rating;
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return SizedBox(
        width: width,
        height: height * 0.15,
        child: Container(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              SizedBox(
                width: width * 0.57,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuPage(
                                        user: user1,
                                        selectedIndex: 1,
                                      )));
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: height * 0.03,
                          color: Colors.black,
                        )),
                    CircleAvatar(
                        backgroundColor: background,
                        radius: height * 0.03,
                        child: Image.asset('assets/${user2.avatarIndex}.png')),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () async {
                        List<Rating> ratings = await getRatings();
                        bool hasRated = hasUserAlreadyRated(
                            ratings, user1.username, user2.username);
                        (hasRated == true)
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                    'The user has already been rated.',
                                    SnackBarType.error,
                                    context))
                            : showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: height * 0.14,
                                    width: width,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        RatingStarBar(
                                            ignoreGestures: false,
                                            updateRanking: (_) {
                                              rating = _;
                                            },
                                            rating: 5),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              Rating newRating = Rating(
                                                  id: 0,
                                                  from: user1.username,
                                                  to: user2.username,
                                                  rating: rating);

                                              Navigator.pop(context);
                                              await addRating(newRating);
                                              double helper =
                                                  calculateAverageRating(
                                                      ratings, user2.username);
                                              if (helper == -1.0) {
                                                user2.rating = rating;
                                              } else {
                                                user2.rating = helper;
                                              }

                                              await editUser(user2).then(
                                                  (value) => ScaffoldMessenger
                                                          .of(context)
                                                      .showSnackBar(customSnackBar(
                                                          'User has been rated',
                                                          SnackBarType.success,
                                                          context)));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.deepPurpleAccent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            child: SizedBox(
                                              width: width * 0.7,
                                              height: height * 0.05,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'RATE USER',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            height * 0.018,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(child: SizedBox())
                                      ],
                                    ),
                                  );
                                },
                              );
                      },
                      child: Text(
                        'Rate User',
                        style: TextStyle(
                            fontSize: height * 0.018, color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.4,
                child: Text(
                  'I N D I V I D U A L',
                  style: TextStyle(
                      fontSize: height * 0.022,
                      color: color,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ));
  }
}
