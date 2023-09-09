import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:individual/Models/rating.dart';
import 'package:individual/Utils/global_vars.dart';

Future<List<Rating>> getRatings() async {
  List<Rating> ratings = [];
  final response =
      await http.get(Uri.parse('$url/ratings'), headers: getHeaders);
  if (response.statusCode == 200) {
    final List<dynamic> ratingDataList = json.decode(response.body);

    for (final ratingData in ratingDataList) {
      final rating = Rating(
          id: ratingData['id'],
          from: ratingData['from'],
          to: ratingData['to'],
          rating: ratingData['rating']);

      ratings.add(rating);
    }
  } else {}
  return ratings;
}

Future<bool> addRating(Rating rating) async {
  bool added = false;

  final Map<String, dynamic> ratingData = {
    'from': rating.from,
    'to': rating.to,
    'rating': rating.rating,
  };

  final response = await http.post(
    Uri.parse('$url/ratings'),
    headers: actionHeaders,
    body: json.encode(ratingData),
  );

  if (response.statusCode == 201) {
    added = true;
  } else {}

  return added;
}
