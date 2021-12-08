import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../constants.dart';
import '../size_config.dart';

class TourCard extends StatelessWidget {
  const TourCard({
    Key? key,
    this.width = 160,
    this.height = 260,
    this.aspectRetio = 1.02,
    required this.tour,
    required this.press,
  }) : super(key: key);

  final double width, height, aspectRetio;
  final TourModel tour;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "en_US");
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(width),
          height: getProportionateScreenWidth(height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(
                    tour.imagesTour[0],
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                tour.name,
                style: const TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                children: [
                  Text(
                    tour.place,
                    style: TextStyle(color: Colors.grey.withOpacity(0.8)),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${oCcy.format(tour.payment)} VNĐ",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(13),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.sp, vertical: 2.sp),
                      decoration: BoxDecoration(
                        color: (tour.star! > 3)
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        children: [
                          Text(
                            tour.star!.toStringAsFixed(1),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 5),
                          SvgPicture.asset("assets/icons/Star Icon.svg")
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
