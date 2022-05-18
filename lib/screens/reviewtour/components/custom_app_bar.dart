import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travelapp/constants.dart';
import 'rounded_button.dart';

class CustomAppBar extends StatelessWidget {
  final double? rating;
  const CustomAppBar({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RoundedButton(
          icon: const Icon(Icons.arrow_back),
          iconColor: kPrimaryColor,
          bgColor: Colors.white,
          tap: () => Navigator.pop(context),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Row(
            children: [
              Text(
                rating!.toStringAsFixed(1),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 5),
              SvgPicture.asset("assets/icons/Star Icon.svg")
            ],
          ),
        )
      ],
    );
  }
}
