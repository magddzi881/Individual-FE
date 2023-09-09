import 'package:individual/Models/user.dart';

class Offer {
  final int id;
  final String title;
  final String description;
  final User tutor;
  final String category;
  final double price;
  final String city;
  final DateTime creationTime;

  Offer(
      {required this.id,
      required this.title,
      required this.city,
      required this.description,
      required this.creationTime,
      required this.tutor,
      required this.category,
      required this.price});
}
