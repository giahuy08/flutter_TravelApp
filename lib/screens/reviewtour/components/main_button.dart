import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/screens/reviewtour/components/rounded_button.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          "Nhận xét",
          style: TextStyle(
              color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(width: kDefaultPadding),
        RoundedButton(
          icon: const Icon(Icons.arrow_forward),
          iconColor: Colors.white,
          bgColor: kPrimaryColor,
          tap: () {},
        ),
      ],
    );
  }
}
