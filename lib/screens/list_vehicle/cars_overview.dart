import 'package:flutter/material.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
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
        title: Text(Languages.of(context)!.vehicleText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              Languages.of(context)!.listVehicleText,
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
