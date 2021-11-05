import 'package:flutter/material.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import 'package:flutter_travelapp/screens/listtours/components/tour_item.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: TourItem());
  }
}