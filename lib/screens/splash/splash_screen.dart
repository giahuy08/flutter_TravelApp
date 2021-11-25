
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_travelapp/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_travelapp/size_config.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4),
        () => Navigator.pushNamed(context, SignInScreen.routeName));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/images/airline.png',
            height: getProportionateScreenHeight(150)),
        const SizedBox(height: 30.0),
        const SpinKitSpinningLines(
          color: Colors.red,
        )
      ],
    ));
  }
}
