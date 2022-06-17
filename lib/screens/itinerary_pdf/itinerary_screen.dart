import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'components/body.dart';

class ItineraryScreen extends StatelessWidget {
  static String routeName = "/itinerary";
  const ItineraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Truyền data qua route
    final arguments =
        ModalRoute.of(context)!.settings.arguments as TourDetailsArguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F6F9),
        centerTitle: true,
        title:  Text(Languages.of(context)!.scheduleText),
      ),
      body: Body(
        tour: arguments.object,
      ),
    );
  }
}
