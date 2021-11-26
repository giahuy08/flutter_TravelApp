import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelapp/constants.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'custom_app_bar.dart';
import 'main_button.dart';
import 'multiline_input.dart';
import 'review_header.dart';
import 'tour_stat.dart';

class Body extends StatelessWidget {
  final dynamic tour;
  const Body({
    Key? key,
    required this.tour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedImage = 0;
    double star = 0;
    return SingleChildScrollView(
      child: Stack(
        children: [
          const ReviewHeader(),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding * 2),
            child: Column(
              children: [
                CustomAppBar(rating: tour.star),
                SizedBox(
                  height: 166,
                  width: 166,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(tour.imagesTour[selectedImage]),
                        //AssetImage("assets/images/vungcao.jpg"),
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
                Text(
                  tour.name,
                  //"Nha Trang, Đà Lạc",
                  style: const TextStyle(
                      color: kTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: kDefaultPadding),
                const Divider(
                  color: kTextColor,
                ),
                const SizedBox(height: kDefaultPadding),
                TourStats(
                  tour: tour,
                ),
                const SizedBox(height: kDefaultPadding),
                const Divider(
                  color: kTextColor,
                ),
                const SizedBox(height: kDefaultPadding),
                const Text(
                  "Cảm ơn bạn đã chọn chúng tôi",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 14,
                  ),
                ),
                SvgPicture.asset(
                  "assets/icons/Heart Icon_2.svg",
                  color: Colors.red,
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
                  onRated: (v) {
                    star = v;
                  },
                  starCount: 5,
                  size: 45,
                  isReadOnly: false,
                  spacing: kDefaultPadding,
                ),
                const SizedBox(height: kDefaultPadding),
                MultilineInput(idTour: tour.idTour, star: star),
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
