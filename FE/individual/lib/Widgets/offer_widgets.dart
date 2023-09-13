import 'package:flutter/material.dart';
import 'package:individual/Models/offer.dart';
import 'package:individual/Widgets/rating_widgets.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon(
      {super.key, required this.color, required this.icon, this.size = 0.045});
  final Color color;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.09,
      width: height * 0.09,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 0,
        color: background,
        child: Icon(icon, color: color, size: height * size),
      ),
    );
  }
}

class CategorySwitch extends StatelessWidget {
  const CategorySwitch({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    IconData icon = Icons.abc_outlined;

    switch (category) {
      case 'Mathematics':
        {
          color = Colors.black;
          icon = Icons.calculate_outlined;
        }
        break;
      case 'Physics':
        {
          color = Colors.amber;
          icon = Icons.av_timer_outlined;
        }
        break;
      case 'Science':
        {
          color = Colors.blue;
          icon = Icons.precision_manufacturing_outlined;
        }
        break;
      case 'Art':
        {
          color = Colors.blueGrey;
          icon = Icons.format_paint_outlined;
        }
        break;
      case 'History':
        {
          color = Colors.deepOrangeAccent;
          icon = Icons.book_outlined;
        }
        break;
      case 'Biology':
        {
          color = Colors.pink;
          icon = Icons.biotech_outlined;
        }
        break;
      case 'Chemistry':
        {
          color = Colors.green;
          icon = Icons.science_outlined;
        }
        break;
      case 'Geography':
        {
          color = Colors.red;
          icon = Icons.wrong_location_outlined;
        }
        break;
      case 'Music':
        {
          color = Colors.purple;
          icon = Icons.piano;
        }
        break;
      case 'IT':
        {
          color = Colors.lightBlue;
          icon = Icons.computer_outlined;
        }
        break;
      case 'Language':
        {
          color = Colors.lime;
          icon = Icons.language_rounded;
        }
        break;
      case 'Literature':
        {
          color = Colors.teal;
          icon = Icons.library_books_outlined;
        }
        break;
      case 'Other':
        {
          color = Colors.orange;
          icon = Icons.document_scanner_outlined;
        }
        break;
      case 'Edit Profile':
        {
          color = Colors.pink;
          icon = Icons.edit_outlined;
        }
        break;
      case 'My Offers':
        {
          color = Colors.deepOrangeAccent;
          icon = Icons.local_offer_outlined;
        }
        break;
      case 'My Shared Materials':
        {
          color = Colors.blue;
          icon = Icons.folder_shared_outlined;
        }
        break;
      case 'Accessible Materials':
        {
          color = Colors.green;
          icon = Icons.share_outlined;
        }
        break;
      case 'Help & About':
        {
          color = Colors.indigo;
          icon = Icons.info_outlined;
        }
        break;
      case 'Log Out':
        {
          color = Colors.grey;
          icon = Icons.logout;
        }
        break;
      case 'All':
        {
          color = Colors.indigoAccent;
          icon = Icons.all_inclusive_outlined;
        }
        break;
    }
    return CategoryIcon(color: color, icon: icon);
  }
}

class CustomTile extends StatelessWidget {
  const CustomTile({super.key, required this.function, required this.title});
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

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.offer});
  final Offer offer;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.1,
      width: width * 0.8,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 0,
        margin: const EdgeInsets.all(0),
        semanticContainer: true,
        child: Row(
          children: [
            SizedBox(
              width: width * 0.02,
            ),
            CategorySwitch(
              category: offer.category,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.7,
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.02,
                      ),
                      SizedBox(
                        width: width * 0.5,
                        child: Text(
                          offer.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: height * 0.022,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                        '${offer.price}/h \$',
                        style: TextStyle(
                            fontSize: height * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  width: width * 0.7,
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        offer.city,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: height * 0.018,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                        '. . .',
                        style: TextStyle(
                          fontSize: height * 0.024,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ListItemFolded extends StatelessWidget {
  const ListItemFolded(
      {super.key, required this.offer, required this.onMessage});
  final Offer offer;
  final Function() onMessage;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.36,
      width: width * 0.8,
      child: Column(
        children: [
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            elevation: 0,
            margin: const EdgeInsets.all(0),
            semanticContainer: true,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.005,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.02,
                    ),
                    CategorySwitch(
                      category: offer.category,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * 0.7,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.02,
                              ),
                              SizedBox(
                                width: width * 0.5,
                                child: Text(
                                  offer.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: height * 0.022,
                                  ),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Text(
                                '${offer.price}/h \$',
                                style: TextStyle(
                                    fontSize: height * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                offer.city,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: height * 0.018,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: SizedBox(
                height: height * 0.26,
                width: width,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.007,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          '${offer.tutor.name} ${offer.tutor.surname} ${calculateAge(int.parse(offer.tutor.yearOfBirth))}',
                          style: TextStyle(
                              fontSize: height * 0.018,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: width * 0.7,
                          height: height * 0.16,
                          child: Text(
                            offer.description,
                            style: TextStyle(
                              fontSize: height * 0.017,
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        CircleAvatar(
                          radius: height * 0.036,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                              'assets/${offer.tutor.avatarIndex}.png'),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.03,
                        ),
                        MiniRatingStarBar(
                            rating: offer.tutor.rating, updateRanking: (_) {}),
                        const Expanded(child: SizedBox()),
                        Container(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: onMessage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: SizedBox(
                              width: width * 0.26,
                              height: height * 0.04,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'MESSAGE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 0.018,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                      ],
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

class ListItemFoldedOwner extends StatelessWidget {
  const ListItemFoldedOwner(
      {super.key,
      required this.offer,
      required this.delete,
      required this.edit});
  final Offer offer;
  final Function() delete;
  final Function() edit;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.36,
      width: width * 0.8,
      child: Column(
        children: [
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            elevation: 0,
            margin: const EdgeInsets.all(0),
            semanticContainer: true,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.005,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.02,
                    ),
                    CategorySwitch(
                      category: offer.category,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * 0.7,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.02,
                              ),
                              SizedBox(
                                width: width * 0.5,
                                child: Text(
                                  offer.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: height * 0.022,
                                  ),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Text(
                                '${offer.price}/h \$',
                                style: TextStyle(
                                    fontSize: height * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                offer.city,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: height * 0.018,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: SizedBox(
                height: height * 0.26,
                width: width,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.007,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          '${offer.tutor.name} ${offer.tutor.surname} ${calculateAge(int.parse(offer.tutor.yearOfBirth))}',
                          style: TextStyle(
                              fontSize: height * 0.018,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: width * 0.7,
                          height: height * 0.16,
                          child: Text(
                            offer.description,
                            style: TextStyle(
                              fontSize: height * 0.017,
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        CircleAvatar(
                          radius: height * 0.036,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                              'assets/${offer.tutor.avatarIndex}.png'),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.03,
                        ),
                        MiniRatingStarBar(
                            rating: offer.tutor.rating, updateRanking: (_) {}),
                        const Expanded(child: SizedBox()),
                        Container(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: edit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: SizedBox(
                              width: width * 0.17,
                              height: height * 0.04,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'EDIT',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 0.018,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: delete,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: SizedBox(
                              width: width * 0.17,
                              height: height * 0.04,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'DELETE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 0.018,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                      ],
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
