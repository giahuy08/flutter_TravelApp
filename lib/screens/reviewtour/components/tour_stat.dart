import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';

class TourStats extends StatelessWidget {
  const TourStats({
    Key? key,
    required this.tour,
  }) : super(key: key);

  final dynamic tour;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TourInfo(
          title: "Thời gian:",
          value: tour.time,
        ),
        TourInfo(
          title: "Giá: (VNĐ)",
          value: tour.payment.toString(),
        ),
        TourInfo(
          title: "Địa điểm:",
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
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: title + '\n',
              style: const TextStyle(
                color: kTextColor,
                fontSize: 14,
              )),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: kTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
