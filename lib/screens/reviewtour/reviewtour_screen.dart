import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'components/body.dart';

class ReviewScreen extends StatelessWidget {
  static String routeName = "/review";
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Truyền data qua route
    final arguments =
        ModalRoute.of(context)!.settings.arguments as TourDetailsArguments;
    return Scaffold(
      body: Body(
        tour: arguments.object,
      ),
    );
  }
}
