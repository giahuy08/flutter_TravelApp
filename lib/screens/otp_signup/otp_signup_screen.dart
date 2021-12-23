import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/text_argument.dart';

import 'components/body.dart';

class OtpSignUpScreen extends StatelessWidget {
  static String routeName = "/otpsignup";
  const OtpSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextArguments arguments =
        ModalRoute.of(context)!.settings.arguments as TextArguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Đăng ký"),
        centerTitle: true,
      ),
      body: Body(email: arguments.text),
    );
  }
}
