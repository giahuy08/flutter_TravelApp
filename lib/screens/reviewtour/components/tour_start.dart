import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class TourStarts extends StatelessWidget {
  const TourStarts({
    Key? key,
    required this.tour,
  }) : super(key: key);

  final dynamic tour;

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "en_US");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TourInfo(
          title: Languages.of(context)!.timeText + ":",
          value: tour.time,
        ),
        SizedBox(
          width: 2.w,
        ),
        TourInfo(
          title: Languages.of(context)!.priceText + ": (VNĐ)",
          value: oCcy.format(tour.payment),
        ),
        SizedBox(
          width: 2.w,
        ),
        TourInfo(
          title: Languages.of(context)!.placeText + ":",
          value: tour.place,
        ),
        // TourInfo(
        //   title: "Khách sạn:",
        //   value: "Hotel",
        // ),
        // TourInfo(
        //   title: "Nhà hàng:",
        //   value: "A&B",
        // ),
      ],
    );
  }
}

class TourInfo extends StatelessWidget {
  const TourInfo({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: title + '\n',
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: kTextColor,
                    fontSize: 12,
                  )),
              TextSpan(
                text: value,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: kTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
