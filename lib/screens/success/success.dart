import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/empty_section.dart';
import 'package:flutter_travelapp/components/sub_title.dart';
import 'package:flutter_travelapp/screens/navigation_bar/main_screen.dart';

import '../../constants.dart';


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
          const EmptySection(
            emptyImg: success,
            emptyMsg: 'Successful !!',
          ),
          const SubTitle(
            subTitleText: 'Your payment was done successfully',
          ),
          Container(
            height: 55,
            width: 170,
            child: DefaultButton(
              text: 'Ok',
              press: () => Navigator.pushNamed(context, MainScreen.routeName),
            ),
          ),
        ],
      ),
    );
  }
}
