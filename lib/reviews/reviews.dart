import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/default_appbar.dart';
import 'package:flutter_travelapp/components/default_backbutton.dart';
import 'package:flutter_travelapp/components/review_ui.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../constants.dart';

class Reviews extends StatefulWidget {
  final List<dynamic> reviewTour;
  final dynamic tour;
  const Reviews({Key? key, required this.reviewTour, required this.tour})
      : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool isMore = false;
  List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];

  get kWhiteColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const DefaultAppBar(
        title: "Reviews",
        child: DefaultBackButton(),
      ),
      body: Column(
        children: [
          Container(
            color: kAccentColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: widget.tour.star.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 48.0),
                          ),
                          const TextSpan(
                            text: "/5",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: kLightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SmoothStarRating(
                      starCount: 5,
                      rating: 4.5,
                      size: 28.0,
                      color: Colors.orange,
                      borderColor: Colors.orange,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "${widget.reviewTour.length} Reviews",
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: kLightColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(width: 4.0),
                          const Icon(Icons.star, color: Colors.orange),
                          const SizedBox(width: 8.0),
                          LinearPercentIndicator(
                            lineHeight: 6.0,
                            // linearStrokeCap: LinearStrokeCap.roundAll,
                            width: MediaQuery.of(context).size.width / 2.8,
                            animation: true,
                            animationDuration: 2500,
                            percent: ratings[index],
                            progressColor: Colors.orange,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              itemCount: widget.reviewTour.length,
              itemBuilder: (context, index) {
                return ReviewUI(
                  image: widget.reviewTour[index].avatarUser,
                  name: widget.reviewTour[index].nameUser,
                  date: DateFormat('yyyy-MM-dd – kk:mm')
                      .format(widget.reviewTour[index].createdAt)
                      .toString(),
                  comment: widget.reviewTour[index].comment,
                  rating: widget.reviewTour[index].star,
                  onPressed: () => print("More Action $index"),
                  onTap: () => setState(() {
                    isMore = !isMore;
                  }),
                  isLess: isMore,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 2.0,
                  color: kAccentColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
