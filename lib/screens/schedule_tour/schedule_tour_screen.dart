
import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';
import 'components/body.dart';

class ScheduleTourScreen extends StatelessWidget {
  static String routeName = "/scheduletour";
  const ScheduleTourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Truyền data qua route
    return Scaffold(
      body: Body(titleTour: "test", imageTour: logo),
    );
  }
}
