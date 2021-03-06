import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:flutter_travelapp/screens/navigation_bar/bottom_nav_bar.dart';
import 'package:flutter_travelapp/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset("assets/images/success.png"),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          Languages.of(context)!.loginSuccess,
          style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        const Spacer(),
        SizedBox(
            width: SizeConfig.screenWidth * 0.6,
            child: DefaultButton(
                text: Languages.of(context)!.gotoHome,
                press: () =>
                    Navigator.pushNamed(context, BottomNavBar.routeName))),
        const Spacer(),
      ],
    );
  }
}
