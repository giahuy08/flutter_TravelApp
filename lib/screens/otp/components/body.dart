import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:flutter_travelapp/screens/otp/components/otp_form.dart';
import 'package:flutter_travelapp/size_config.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                Languages.of(context)!.authorOtpText,
                style: headingStyle,
              ),
              Text(
                Languages.of(context)!.emailOtpText + " \n $email ",
                textAlign: TextAlign.center,
              ),
              // buildTimer(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              OtpForm(email: email),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Mã sẽ hết hạn sau:"),
        TweenAnimationBuilder<Duration>(
            tween:
                Tween(begin: const Duration(seconds: 30), end: Duration.zero),
            duration: const Duration(seconds: 30),
            builder: (BuildContext context, Duration value, Widget? child) {
              final seconds = value.inSeconds % 60;
              return Text(
                "00:$seconds",
                style: const TextStyle(color: kPrimaryColor),
              );
            })
      ],
    );
  }
}
