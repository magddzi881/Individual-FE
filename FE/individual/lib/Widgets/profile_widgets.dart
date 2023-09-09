// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:individual/Widgets/offer_widgets.dart';
import 'package:individual/Utils/global_vars.dart';

class AvatarGallery extends StatefulWidget {
  AvatarGallery(
      {super.key, required this.avatarIndex, required this.updateAvatarIndex});
  int avatarIndex;
  final Function(int) updateAvatarIndex;

  @override
  State<AvatarGallery> createState() => _AvatarGalleryState();
}

class _AvatarGalleryState extends State<AvatarGallery> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                widget.updateAvatarIndex(1);
              },
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: (widget.avatarIndex == 1)
                    ? Colors.deepPurpleAccent
                    : background,
                child: Image.asset('assets/1.png'),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            GestureDetector(
              onTap: () {
                widget.updateAvatarIndex(2);
              },
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: (widget.avatarIndex == 2)
                    ? Colors.deepPurpleAccent
                    : background,
                child: Image.asset('assets/2.png'),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            GestureDetector(
              onTap: () {
                widget.updateAvatarIndex(3);
              },
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: (widget.avatarIndex == 3)
                    ? Colors.deepPurpleAccent
                    : background,
                child: Image.asset('assets/3.png'),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            GestureDetector(
              onTap: () {
                widget.updateAvatarIndex(4);
              },
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: (widget.avatarIndex == 4)
                    ? Colors.deepPurpleAccent
                    : background,
                child: Image.asset('assets/4.png'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                widget.updateAvatarIndex(5);
              },
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: (widget.avatarIndex == 5)
                    ? Colors.deepPurpleAccent
                    : background,
                child: Image.asset('assets/5.png'),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            GestureDetector(
              onTap: () {
                widget.updateAvatarIndex(6);
              },
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: (widget.avatarIndex == 6)
                    ? Colors.deepPurpleAccent
                    : background,
                child: Image.asset('assets/6.png'),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            GestureDetector(
              onTap: () {
                widget.updateAvatarIndex(7);
              },
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: (widget.avatarIndex == 7)
                    ? Colors.deepPurpleAccent
                    : background,
                child: Image.asset('assets/7.png'),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            GestureDetector(
              onTap: () {
                widget.updateAvatarIndex(8);
              },
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: (widget.avatarIndex == 8)
                    ? Colors.deepPurpleAccent
                    : background,
                child: Image.asset('assets/8.png'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                widget.updateAvatarIndex(9);
              },
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: (widget.avatarIndex == 9)
                    ? Colors.deepPurpleAccent
                    : background,
                child: Image.asset('assets/9.png', fit: BoxFit.contain),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            GestureDetector(
              onTap: () {
                widget.updateAvatarIndex(10);
              },
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: (widget.avatarIndex == 10)
                    ? Colors.deepPurpleAccent
                    : background,
                child: Image.asset('assets/10.png'),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            GestureDetector(
              onTap: () {
                widget.updateAvatarIndex(11);
              },
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: (widget.avatarIndex == 11)
                    ? Colors.deepPurpleAccent
                    : background,
                child: Image.asset('assets/11.png'),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            GestureDetector(
              onTap: () {
                widget.updateAvatarIndex(12);
              },
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: (widget.avatarIndex == 12)
                    ? Colors.deepPurpleAccent
                    : background,
                child: Image.asset('assets/12.png'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomProfileTile extends StatelessWidget {
  const CustomProfileTile(
      {super.key, required this.function, required this.title});
  final String title;
  final void Function() function;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: function,
      child: SizedBox(
        width: width * 0.9,
        height: height * 0.1,
        child: Row(
          children: [
            SizedBox(
              width: width * 0.01,
            ),
            CategorySwitch(
              category: title,
            ),
            SizedBox(
              width: width * 0.04,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: height * 0.02,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const Expanded(child: SizedBox()),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
              size: height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
