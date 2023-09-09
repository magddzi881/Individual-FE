import 'package:flutter/material.dart';
import 'package:individual/Widgets/button_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Utils/global_vars.dart';

// ignore: must_be_immutable
class HelpTab extends StatelessWidget {
  HelpTab({super.key});

  List<String> headers = [
    "Welcome to the App!",
    "Listings:",
    "User Profile:",
    "Chat:",
    "Trusted Community:"
  ];

  List<String> messages = [
    "Enjoy a full range of features designed to make your experience unique and satisfying. The app is a place where you can connect with other users, share information, make new friends, and much more.",
    "Search through listings from other users or create your own. Publish your offers, services, or products to reach a wide audience. Whether you're looking for something specific or want to share your own offer, the app is the place to make it happen.",
    "Your profile is your business card. Add information about yourself, change your profile picture, and update your details to let others know who you are. Rate other users and let them rate you. Build your reputation within the community.",
    "Initiate conversations with other users, send messages, and stay in touch. Chat in real-time and exchange information. The app provides convenient and fast access to connect with other users.",
    "The community is built on trust and respect. We work hard to provide a safe and friendly environment for users. We encourage positive relationships and constructive dialogue.\n\nWe're proud of the app and confident you'll find many exciting opportunities here. Have fun, meet new people, and use the features to enhance your experience.\n\nThank you for being part of this!           MD."
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: background,
      bottomNavigationBar: const ButtonBack(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const IndividualLogo(),
            SizedBox(
              width: width * 0.9,
              child: Column(
                children: [
                  ParagraptText(
                    headers: headers,
                    messages: messages,
                    index: 0,
                  ),
                  ParagraptText(
                    headers: headers,
                    messages: messages,
                    index: 1,
                  ),
                  ParagraptText(
                    headers: headers,
                    messages: messages,
                    index: 2,
                  ),
                  ParagraptText(
                    headers: headers,
                    messages: messages,
                    index: 3,
                  ),
                  ParagraptText(
                    headers: headers,
                    messages: messages,
                    index: 4,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
