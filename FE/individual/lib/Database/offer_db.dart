import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:individual/Database/user_db.dart';
import 'package:individual/Models/offer.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Utils/functions.dart';
import 'package:individual/Utils/global_vars.dart';

Future<List<Offer>> getOffers() async {
  List<Offer> offers = [];
  final response =
      await http.get(Uri.parse('$url/offers'), headers: getHeaders);
  if (response.statusCode == 200) {
    final List<dynamic> offerDataList = json.decode(response.body);

    for (final offerData in offerDataList) {
      User tutor = await getUser(offerData['tutorUsername']);
      final offer = Offer(
        id: offerData['id'],
        title: offerData['title'],
        city: offerData['city'],
        description: offerData['description'],
        creationTime: DateTime.parse(offerData['creationTime']),
        tutor: tutor,
        category: offerData['category'],
        price: offerData['price'].toDouble(),
      );
      offers.add(offer);
    }
  } else {}
  return offers;
}

Future<List<Offer>> getOffersByCategory(String category) async {
  List<Offer> offers = [];
  final response = await http.get(
      Uri.parse('$url/offers/byCategory?category=$category'),
      headers: getHeaders);
  if (response.statusCode == 200) {
    final List<dynamic> offerDataList = json.decode(response.body);

    for (final offerData in offerDataList) {
      User tutor = await getUser(offerData['tutorUsername']);
      final offer = Offer(
        id: offerData['id'],
        title: offerData['title'],
        city: offerData['city'],
        description: offerData['description'],
        creationTime: DateTime.parse(offerData['creationTime']),
        tutor: tutor,
        category: offerData['category'],
        price: offerData['price'].toDouble(),
      );
      offers.add(offer);
    }
  } else {}
  return offers;
}

Future<List<Offer>> getOffersByKeyword(String keyword) async {
  List<Offer> offers = [];
  final response = await http.get(
      Uri.parse('$url/offers/search?keyword=$keyword'),
      headers: getHeaders);
  if (response.statusCode == 200) {
    final List<dynamic> offerDataList = json.decode(response.body);

    for (final offerData in offerDataList) {
      User tutor = await getUser(offerData['tutorUsername']);
      final offer = Offer(
        id: offerData['id'],
        title: offerData['title'],
        city: offerData['city'],
        description: offerData['description'],
        creationTime: DateTime.parse(offerData['creationTime']),
        tutor: tutor,
        category: offerData['category'],
        price: offerData['price'].toDouble(),
      );
      offers.add(offer);
    }
  } else {}
  return offers;
}

Future<List<Offer>> getOffersByTutorUsername(String tutorUsername) async {
  List<Offer> offers = [];
  final response = await http.get(
      Uri.parse('$url/offers/byTutor?tutor_username=$tutorUsername'),
      headers: getHeaders);
  if (response.statusCode == 200) {
    final List<dynamic> offerDataList = json.decode(response.body);

    for (final offerData in offerDataList) {
      User tutor = await getUser(offerData['tutorUsername']);
      final offer = Offer(
        id: offerData['id'],
        title: offerData['title'],
        city: offerData['city'],
        description: offerData['description'],
        creationTime: DateTime.parse(offerData['creationTime']),
        tutor: tutor,
        category: offerData['category'],
        price: offerData['price'].toDouble(),
      );
      offers.add(offer);
    }
  } else {}
  return offers;
}

Future<Offer> getOfferById(int offerId) async {
  Offer offer = Offer(
      id: 0,
      title: 'title',
      city: 'city',
      description: 'description',
      creationTime: DateTime.now(),
      tutor: User(
          username: '',
          email: '',
          password: 'password',
          name: 'name',
          surname: 'surname',
          yearOfBirth: 'yearOfBirth',
          gender: 'K',
          avatarIndex: 0,
          rating: 0),
      category: 'Other',
      price: 0);
  final response =
      await http.get(Uri.parse('$url/offers/$offerId'), headers: getHeaders);
  if (response.statusCode == 200) {
    final List<dynamic> offerDataList = json.decode(response.body);

    for (final offerData in offerDataList) {
      User tutor = await getUser(offerData['tutorUsername']);
      offer = Offer(
        id: offerData['id'],
        title: offerData['title'],
        city: offerData['city'],
        description: offerData['description'],
        creationTime: DateTime.parse(offerData['creationTime']),
        tutor: tutor,
        category: offerData['category'],
        price: offerData['price'].toDouble(),
      );
    }
  } else {}
  return offer;
}

Future<bool> addOffer(Offer offer) async {
  String formattedDate =
      "${offer.creationTime.year}-${twoDigits(offer.creationTime.month)}-${twoDigits(offer.creationTime.day)} ${twoDigits(offer.creationTime.hour)}:${twoDigits(offer.creationTime.minute)}:${twoDigits(offer.creationTime.second)}";

  bool added = false;
  final Map<String, dynamic> userData = {
    'title': offer.title,
    'city': offer.city,
    'description': offer.description,
    'creationTime': formattedDate,
    'tutorUsername': offer.tutor.username,
    'category': offer.category,
    'price': offer.price
  };
  final response = await http.post(
    Uri.parse('$url/offers'),
    headers: actionHeaders,
    body: json.encode(userData),
  );
  if (response.statusCode == 200) {
    added = true;
  } else {}
  return added;
}

Future<bool> editOffer(Offer offer) async {
  String formattedDate =
      "${offer.creationTime.year}-${twoDigits(offer.creationTime.month)}-${twoDigits(offer.creationTime.day)} ${twoDigits(offer.creationTime.hour)}:${twoDigits(offer.creationTime.minute)}:${twoDigits(offer.creationTime.second)}";

  final Map<String, dynamic> userData = {
    'title': offer.title,
    'city': offer.city,
    'description': offer.description,
    'creationTime': formattedDate,
    'tutorUsername': offer.tutor.username,
    'category': offer.category,
    'price': offer.price
  };
  final response = await http.put(
    Uri.parse('$url/offers/${offer.id}'),
    headers: actionHeaders,
    body: json.encode(userData),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> deleteOfferById(int offerId) async {
  final response = await http.delete(
    Uri.parse('$url/offers/$offerId'),
    headers: getHeaders,
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
