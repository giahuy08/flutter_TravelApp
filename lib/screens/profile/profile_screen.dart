import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 5.h),
        const Text(
          "Hồ sơ cá nhân",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        const Body(),
      ],
    );
  }
}
