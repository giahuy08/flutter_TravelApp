import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:flutter_travelapp/screens/otp_signup/components/otp_signup_form.dart';
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
                Languages.of(context)!.emailOtpText + " \n $email",
                textAlign: TextAlign.center,
              ),
              // buildTimer(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              OtpSignUpForm(email: email),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
