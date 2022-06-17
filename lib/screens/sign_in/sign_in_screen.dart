import 'package:flutter/material.dart';
import 'package:flutter_travelapp/localization/locale_constant.dart';
import 'package:fswitch/fswitch.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:rolling_switch/rolling_switch.dart';
import '../../localization/language/languages.dart';
import '../../models/language_data.dart';
import 'components/body.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) => const Scaffold(body: Body());
}
