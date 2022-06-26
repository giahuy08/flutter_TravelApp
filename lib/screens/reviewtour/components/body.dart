import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import 'package:flutter_travelapp/screens/details_tour/details_screen.dart';
import 'package:flutter_travelapp/screens/reviewtour/components/tour_start.dart';
import 'package:sizer/sizer.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../../localization/language/languages.dart';
import 'custom_app_bar.dart';
import 'multiline_input.dart';
import 'review_header.dart';

class Body extends StatefulWidget {
  final dynamic tour;
  const Body({
    Key? key,
    required this.tour,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late int selectedImage = 0;
  late double star = 0;
  dynamic itemtour;
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
                CustomAppBar(rating: widget.tour.star),
                SizedBox(
                  height: 25.h,
                  width: 50.w,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.tour.imagesTour[selectedImage]),
                        //AssetImage("assets/images/vungcao.jpg"),
                      ),
                    ],
                  ),
                ),
                Text(
                  Languages.of(context)!.tourText,
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 14,
                  ),
                ),
                Text(
                  widget.tour.name,
                  //"Nha Trang, Đà Lạc",
                  style: const TextStyle(
                      color: kTextColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: kDefaultPadding),
                const Divider(
                  color: kTextColor,
                ),
                const SizedBox(height: kDefaultPadding),
                TourStarts(
                  tour: widget.tour,
                ),
                const SizedBox(height: kDefaultPadding),
                const Divider(
                  color: kTextColor,
                ),
                const SizedBox(height: kDefaultPadding),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: DefaultButton(
                    text: Languages.of(context)!.detailText,
                    press: () async => {
                      itemtour =
                          await TourRepository().getOneTour(widget.tour.idTour),
                      Navigator.pushNamed(context, DetailScreen.routeName,
                          arguments: TourDetailsArguments(
                              object: TourModel.fromMap(itemtour))),
                    },
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                Text(
                  Languages.of(context)!.thankYouText,
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 14,
                  ),
                ),
                SvgPicture.asset(
                  "assets/icons/Heart Icon_2.svg",
                  color: Colors.red,
                ),
                Text(
                  Languages.of(context)!.feedbackText,
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
                    setState(() {
                      star = v;
                    });
                  },
                  starCount: 5,
                  size: 45,
                  isReadOnly: false,
                  spacing: kDefaultPadding,
                ),
                const SizedBox(height: kDefaultPadding),
                MultilineInput(idBookTour: widget.tour.id, star: star),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
