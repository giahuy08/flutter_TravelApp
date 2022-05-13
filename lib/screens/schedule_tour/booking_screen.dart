import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/screens/schedule_tour/components/custom_app_bar.dart';
import 'components/date_selector.dart';
import 'components/location_text.dart';
import 'components/pay_button.dart';
import 'components/seat_selector.dart';
import 'components/time_selector.dart';

class BookingScreen extends StatefulWidget {
  static String routeName = "/schedule";
  final String movieName;

  const BookingScreen({Key? key, required this.movieName}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            //app bar
            CustomAppBar(widget.movieName),

            //date selector
            const DateSelector(),

            //Time selector
            const TimeSelector(),

            //Location and theatre
            const LocationText(),

            //Seat selector
            const SeatSelector(),

            //Pay button and seat categories
            const PayButton(),
          ],
        ),
      ),
    );
  }
}
