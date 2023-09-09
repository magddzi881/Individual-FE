import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingStarBar extends StatefulWidget {
  const RatingStarBar(
      {super.key,
      this.ignoreGestures = true,
      required this.updateRanking,
      required this.rating});
  final bool ignoreGestures;
  final Function(double) updateRanking;
  final double rating;

  @override
  State<RatingStarBar> createState() => _RatingStarBarState();
}

class _RatingStarBarState extends State<RatingStarBar> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return RatingBar.builder(
      initialRating: widget.rating,
      minRating: 1,
      ignoreGestures: widget.ignoreGestures,
      direction: Axis.horizontal,
      unratedColor: const Color.fromARGB(255, 224, 222, 222),
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: height * 0.01),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        size: height * 0.033,
        color: Colors.amber,
      ),
      onRatingUpdate: widget.updateRanking,
    );
  }
}

class MiniRatingStarBar extends StatefulWidget {
  const MiniRatingStarBar(
      {super.key,
      this.ignoreGestures = true,
      required this.updateRanking,
      required this.rating});
  final bool ignoreGestures;
  final Function(double) updateRanking;
  final double rating;

  @override
  State<MiniRatingStarBar> createState() => _MiniRatingStarBarState();
}

class _MiniRatingStarBarState extends State<MiniRatingStarBar> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return RatingBar.builder(
      initialRating: widget.rating,
      minRating: 1,
      ignoreGestures: widget.ignoreGestures,
      direction: Axis.horizontal,
      unratedColor: const Color.fromARGB(255, 224, 222, 222),
      allowHalfRating: true,
      itemCount: 5,
      itemSize: height * 0.026,
      itemPadding: EdgeInsets.symmetric(horizontal: height * 0.001),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: widget.updateRanking,
    );
  }
}
