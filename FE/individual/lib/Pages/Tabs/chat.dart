import 'package:flutter/material.dart';
import 'package:individual/Database/chat_db.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Models/chat.dart';
import 'package:individual/Widgets/chat_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.loggedUser});
  final User loggedUser;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Future<List<Chat>> chats;

  @override
  void initState() {
    chats = getUsersChats(widget.loggedUser.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final DateFormat formatter = DateFormat('HH:mm');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: height * 0.18,
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
          Column(children: [
            const IndividualLogo(),
            SizedBox(
                height: height * 0.752,
                width: width,
                child: FutureBuilder(
                  future: chats,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loading();
                    } else {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            String time = formatter.format(
                                snapshot.data![index].lastMessageSendTime);

                            return ChatTile(
                              chat: snapshot.data![index],
                              messageSendTime: time,
                              loggedUser: widget.loggedUser,
                            );
                          },
                        );
                      } else {
                        return Center(
                            child: SizedBox(
                          width: width * 0.7,
                          child: Text(
                            'There is nothing here. Look for an offer and message someone!',
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
                ))
          ]),
        ],
      ),
    );
  }
}
