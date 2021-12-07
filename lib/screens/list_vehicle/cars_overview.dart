import 'package:flutter/material.dart';
import 'package:flutter_travelapp/screens/bookedtour_booking/bookedtour_app_theme.dart';

import 'components/cars_grid.dart';

class CarsOverviewScreen extends StatelessWidget {
  static String routeName = "/listvehicle";
  const CarsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BookedTourAppTheme.buildLightTheme().backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Vehicle',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Available Vehicles',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CarsGrid(),
          )
        ],
      ),
    );
  }
}
