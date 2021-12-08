import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import 'package:flutter_travelapp/screens/details_tour/components/hotel_card.dart';
import 'package:flutter_travelapp/screens/details_tour/details_screen.dart';
import '../../../size_config.dart';

class HotelTour extends StatefulWidget {
  const HotelTour({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HotelTourState();
}

class _HotelTourState extends State<HotelTour> {
  List<dynamic> _listTour = [];

  initialController() {
    _listTour = [];
  }

  @override
  void initState() {
    super.initState();
    getListTour();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getListTour() async {
    List<dynamic> tours = await TourRepository().getListTour(1, 5);
    setState(() {
      _listTour.addAll(tours);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenWidth(10)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                _listTour.length,
                (index) {
                  if (_listTour[index] != null) {
                    return HotelCard(
                      product: _listTour[index],
                      press: () => Navigator.pushNamed(
                          context, DetailScreen.routeName,
                          arguments:
                              ProductDetailsArguments(tour: _listTour[index])),
                    );
                  }
                  return const SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
