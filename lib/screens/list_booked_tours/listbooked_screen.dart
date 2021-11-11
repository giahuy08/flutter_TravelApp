import 'package:flutter/material.dart';
import 'package:flutter_travelapp/screens/list_booked_tours/components/body.dart';

class ListBookedTourScreen extends StatelessWidget {
  static String routeName = "/listbookedtour";
  const ListBookedTourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách tour đã đặt'),
      ),
      body: const Body(),
    );
  }
}
