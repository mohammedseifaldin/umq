

import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

Widget RatingStars(rating, size, {required onChanged}) {
  return SmoothStarRating(
      allowHalfRating: true,
      onRatingChanged: (v) => onChanged(v),
      starCount: 5,
      rating: double.parse(rating),
      size: size,
      filledIconData: Icons.star,
      defaultIconData: Icons.star_border,
      halfFilledIconData: Icons.star_half_outlined,
      color: Colors.orange[300],
      borderColor: Colors.orange[300],
      spacing: 0.0);
}
