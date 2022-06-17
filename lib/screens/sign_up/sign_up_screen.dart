import 'package:flutter/material.dart';
import 'package:flutter_travelapp/screens/sign_up/components/body.dart';

import '../../localization/language/languages.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.registerText),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
