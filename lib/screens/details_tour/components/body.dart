import 'package:flutter/material.dart';
import 'package:flutter_travelapp/screens/details_tour/components/tour_description.dart';

class Body extends StatelessWidget {
  final dynamic tour;
  const Body({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TourDescription(tour: tour, pressOnSeeMore: () {});
  }
}
