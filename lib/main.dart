import 'package:flutter/material.dart';
import 'package:flutter_travelapp/routes.dart';
import 'package:flutter_travelapp/screens/splash/splash_screen.dart';
import 'package:flutter_travelapp/theme.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(context),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
