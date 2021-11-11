import 'package:flutter/material.dart';
import 'package:flutter_travelapp/screens/list_booked_tours/components/tour_booked_item.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: TourBookedItem());
  }
}
