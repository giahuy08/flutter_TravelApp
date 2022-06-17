import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../localization/language/languages.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5.h),
            Text(
              Languages.of(context)!.userProfile,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const Body(),
          ],
        ),
      ),
    );
  }
}
