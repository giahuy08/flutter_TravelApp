import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class ReviewScreen extends StatelessWidget {
  static String routeName = "/review";
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
