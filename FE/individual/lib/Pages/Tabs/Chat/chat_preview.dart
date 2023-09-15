// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:individual/Database/chat_db.dart';
import 'package:individual/Database/message_db.dart';
import 'package:individual/Models/chat.dart';
import 'package:individual/Models/message.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Widgets/chat_widgets.dart';
import 'package:individual/Widgets/form_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:intl/intl.dart';
import 'package:individual/Utils/global_vars.dart';

class ChatPreview extends StatefulWidget {
  const ChatPreview(
      {super.key,
      required this.chat,
      required this.lastlyViewed,
      required this.loggedUser});
  final Chat chat;
  final DateTime lastlyViewed;
  final User loggedUser;

  @override
  State<ChatPreview> createState() => _ChatPreviewState();
}

class _ChatPreviewState extends State<ChatPreview> {
  TextEditingController messageController = TextEditingController();
  late Future<List<Message>> chatMessages;
  late ScrollController _scrollController;

  String message = '';

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    chatMessages = getMessagesBetweenUsers(
        widget.chat.user1.username, widget.chat.user2.username);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> refreshChat() async {
    setState(() {
      message = '';
      messageController.text = message;
      chatMessages = getMessagesBetweenUsers(
          widget.chat.user1.username, widget.chat.user2.username);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Stack(children: [
          SizedBox(
            width: width,
            height: height,
            child: Column(
              children: [
                IndividualLogoWithAvatar(
                  chat: widget.chat,
                  user1: widget.chat.user1,
                  user2: widget.chat.user2,
                ),
                SizedBox(
                  width: width,
                  height: height * 0.7,
                  child: FutureBuilder(
                    future: chatMessages,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Loading();
                      } else {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          final DateFormat formatter =
                              DateFormat('HH:mm dd/MM/yyyy');
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            controller: _scrollController,
                            itemBuilder: (BuildContext context, int index) {
                              final message = snapshot.data![index];
                              final isUser1 = message.senderUsername ==
                                  widget.chat.user1.username;
                              return Align(
                                alignment: isUser1
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: isUser1
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: width * 0.6,
                                      child: Text(
                                        '  ${formatter.format(message.sendTime)} .',
                                        textAlign: isUser1
                                            ? TextAlign.end
                                            : TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: height * 0.0155),
                                      ),
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: width * 0.6,
                                          minWidth: width * 0.1),
                                      margin: EdgeInsets.symmetric(
                                          vertical: height * 0.01,
                                          horizontal: width * 0.02),
                                      padding: EdgeInsets.all(height * 0.014),
                                      decoration: BoxDecoration(
                                        color:
                                            isUser1 ? mainColor : Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Text(
                                        '${message.text}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: height * 0.02),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                              child: SizedBox(
                            width: width * 0.7,
                            child: Text(
                              'This empty chat is waiting for the first message.',
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
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                ButtonTextField(
                    hintText: 'Type your message here',
                    controller: messageController,
                    showLabel: false,
                    searchFunction: () async {
                      Message newMessage = Message(
                          chatId: widget.chat.id,
                          id: 0,
                          sendTime: DateTime.now(),
                          text: message,
                          receiverUsername: widget.chat.user2.username,
                          senderUsername: widget.loggedUser.username);
                      await addMessage(newMessage);
                      widget.chat.lastlyViewed = widget.lastlyViewed;
                      widget.chat.senderUsername = widget.loggedUser.username;
                      await editChat(widget.chat, message, newMessage.sendTime);
                      await editChatSeen(widget.chat.id, false);
                      setState(() {
                        refreshChat();
                      });
                    },
                    function: (_) {
                      setState(() {
                        message = messageController.text;
                      });
                    }),
              ],
            ),
          ),
          Positioned(
            bottom: height * 0.14,
            right: width * 0.76,
            child: FloatingActionButton(
              backgroundColor: mainColor,
              onPressed: () {
                setState(() {
                  _scrollToBottom();
                });
              },
              child: Icon(
                Icons.arrow_drop_down_sharp,
                color: Colors.white,
                size: height * 0.045,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
