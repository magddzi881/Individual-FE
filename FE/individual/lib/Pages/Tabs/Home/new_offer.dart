// ignore_for_file: use_build_context_synchronously

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:individual/Database/offer_db.dart';
import 'package:individual/Models/offer.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Pages/Tabs/Home/offers.dart';
import 'package:individual/Pages/Tabs/Profile/my_offers.dart';
import 'package:individual/Widgets/button_widgets.dart';
import 'package:individual/Widgets/form_widgets.dart';
import 'package:individual/Widgets/immutable_widgets.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

class AddOfferPage extends StatefulWidget {
  const AddOfferPage({super.key, required this.user, this.fromProfile = true});
  final User user;
  final bool fromProfile;

  @override
  State<AddOfferPage> createState() => _AddOfferPageState();
}

class _AddOfferPageState extends State<AddOfferPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  late User user;
  String title = '';
  String description = '';
  String price = '0';
  String city = '';
  String category = 'Other';

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    cityController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: background,
      bottomNavigationBar: ButtonOneOption(
          navigatorBack: () {
            if (widget.fromProfile == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MyOffers(
                          user: user,
                        )),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => OffersPage(
                          user: user,
                        )),
              );
            }
          },
          function: () async {
            if (title.isEmpty ||
                description.isEmpty ||
                price.isEmpty ||
                city.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                  'Form fields cannot be left blank',
                  SnackBarType.error,
                  context));
            } else {
              bool priceChecker = checkPrice(price);
              if (priceChecker == false) {
                ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                    'Wrong price field', SnackBarType.error, context));
              } else {
                Offer offer = Offer(
                    id: 0,
                    title: title,
                    city: city,
                    description: description,
                    creationTime: DateTime.now(),
                    tutor: user,
                    category: category,
                    price: double.parse(price));
                bool added = await addOffer(offer);
                (added == false)
                    ? ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                        'An error occurred, try again later',
                        SnackBarType.error,
                        context))
                    : {
                        ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(
                                'Added', SnackBarType.success, context)),
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyOffers(
                                    user: widget.user,
                                  )),
                        )
                      };
              }
            }
          },
          text: 'ADD OFFER'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const IndividualLogo(),
            IconTextField(
                controller: titleController,
                hintText: 'Title',
                icon: Icons.text_format_sharp,
                function: (_) {
                  setState(() {
                    title = titleController.text;
                  });
                }),
            SizedBox(
              height: height * 0.02,
            ),
            IconLongTextField(
                controller: descriptionController,
                hintText: 'Description',
                icon: Icons.edit_outlined,
                function: (_) {
                  setState(() {
                    description = descriptionController.text;
                  });
                }),
            SizedBox(
              height: height * 0.02,
            ),
            IconTextField(
                controller: priceController,
                hintText: 'Price',
                textInputType: TextInputType.number,
                icon: Icons.money_off,
                function: (_) {
                  setState(() {
                    price = priceController.text;
                  });
                }),
            SizedBox(
              height: height * 0.02,
            ),
            IconTextField(
                controller: cityController,
                hintText: 'City / Online',
                textInputType: TextInputType.name,
                icon: Icons.reduce_capacity_rounded,
                function: (_) {
                  setState(() {
                    city = cityController.text;
                  });
                }),
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: height * 0.022,
              width: width * 0.77,
              child: Text(
                'Category',
                style: TextStyle(
                  fontSize: height * 0.018,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.012,
            ),
            SizedBox(
              width: width * 0.8,
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                elevation: 5,
                semanticContainer: true,
                child: CustomDropdown(
                  hintText: 'Select category',
                  items: const [
                    'Mathematics',
                    'Physics',
                    'Science',
                    'History',
                    'Biology',
                    'Chemistry',
                    'Geography',
                    'Music',
                    'IT',
                    'Language',
                    'Literature',
                    'Other',
                  ],
                  controller: categoryController,
                  onChanged: (value) {
                    setState(() {
                      category = categoryController.text;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
