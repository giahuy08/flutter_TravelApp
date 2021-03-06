import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/empty_section.dart';
import 'package:flutter_travelapp/components/sub_title.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/screens/navigation_bar/bottom_nav_bar.dart';

import '../../localization/language/languages.dart';

class Success extends StatefulWidget {
  static String routeName = "/success";
  const Success({Key? key}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  get kWhiteColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptySection(
            emptyImg: success,
            emptyMsg: Languages.of(context)!.successText + ' !!',
          ),
          SubTitle(
            subTitleText: Languages.of(context)!.paymentSuccessText,
          ),
          SizedBox(
            height: 55,
            width: 170,
            child: DefaultButton(
              text: Languages.of(context)!.confirmText,
              press: () => Navigator.pushNamed(context, BottomNavBar.routeName),
            ),
          ),
        ],
      ),
    );
  }
}
