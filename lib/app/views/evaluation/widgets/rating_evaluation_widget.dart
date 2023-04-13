import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingEvaluationWidget extends StatelessWidget {
  final Function(double rating) onUpdateRating;
  const RatingEvaluationWidget({
    Key? key,
    required this.onUpdateRating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return RatingBar.builder(
      // initialRating: evaluationController.answerSelected,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      glow: false, //brilho
      itemSize: size.height * 0.08,
      wrapAlignment: WrapAlignment.end,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (double rating) {
        onUpdateRating(rating);
        //! store.showOptions();
      },
    );
  }
}
