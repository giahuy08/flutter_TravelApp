import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'custom_app_bar.dart';
import 'main_button.dart';
import 'multiline_input.dart';
import 'review_header.dart';
import 'tour_stat.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          const ReviewHeader(),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding * 2),
            child: Column(
              children: [
                const CustomAppBar(),
                SizedBox(
                  height: 166,
                  width: 166,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: const [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/vungcao.jpg"),
                      ),
                    ],
                  ),
                ),
                const Text(
                  "Chuyến du lịch:",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  "Nha Trang, Đà Lạc",
                  style: TextStyle(
                      color: kTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: kDefaultPadding),
                const Divider(
                  color: kTextColor,
                ),
                const SizedBox(height: kDefaultPadding),
                const TourStats(),
                const SizedBox(height: kDefaultPadding),
                const Divider(
                  color: kTextColor,
                ),
                const SizedBox(height: kDefaultPadding),
                const Text(
                  "Thiên,",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  "Trải nghiệm của bạn thế nào?",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
               SmoothStarRating(
                  borderColor: kPrimaryColor,
                  color: kPrimaryColor,
                  allowHalfRating: false,
                  onRated: (v) {},
                  starCount: 5,
                  size: 45,
                  isReadOnly: false,
                  spacing: kDefaultPadding,
                ),
                const SizedBox(height: kDefaultPadding),
                const MultilineInput(),
                const SizedBox(height: kDefaultPadding),
                const MainButton(),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
