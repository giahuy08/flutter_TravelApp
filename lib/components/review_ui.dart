import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../constants.dart';

class ReviewUI extends StatelessWidget {
  final String image, name, date, comment;
  final List<String> reviewImages;
  final double rating;
  final Function() onTap, onPressed;
  final bool isLess;
  const ReviewUI(
      {Key? key,
      required this.image,
      required this.name,
      required this.date,
      required this.comment,
      required this.rating,
      required this.onTap,
      required this.isLess,
      required this.onPressed,
      required this.reviewImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 2.0,
        bottom: 2.0,
        left: 16.0,
        right: 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 45.0,
                width: 45.0,
                margin: const EdgeInsets.only(right: 16.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(44.0),
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              SmoothStarRating(
                starCount: 5,
                rating: rating,
                size: 28.0,
                isReadOnly: true,
                color: Colors.orange,
                borderColor: Colors.orange,
              ),
              const SizedBox(width: kFixPadding),
              Text(
                date,
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: onTap,
            child: isLess
                ? Text(
                    comment,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: kLightColor,
                    ),
                  )
                : Text(
                    comment,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: kLightColor,
                    ),
                  ),
          ),
          reviewImages.isEmpty
              ? Container()
              : Row(
                  children: reviewImages
                      .map<Widget>((imgSrc) => Container(
                            height: 60.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(imgSrc),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ))
                      .toList())
        ],
      ),
    );
  }
}
