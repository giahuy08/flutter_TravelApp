import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/text_argument.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextArguments arguments =
        ModalRoute.of(context)!.settings.arguments as TextArguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP"),
        centerTitle: true,
      ),
      body: Body(email: arguments.text),
    );
  }
}
