import 'package:flutter/material.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import 'package:flutter_travelapp/screens/listtours/components/tour_item.dart';

class Body extends StatelessWidget {
  final List<dynamic> listTour;

  const Body({Key? key, required this.listTour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (listTour.isEmpty
        ? const Text('Không tìm thấy')
        : SafeArea(child: TourItem(listTour: listTour)));
  }
}
