import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/listtours_argument.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import 'package:flutter_travelapp/screens/details_tour/components/tour_card.dart';
import 'package:flutter_travelapp/screens/details_tour/details_screen.dart';
import 'package:flutter_travelapp/screens/home/components/section_title.dart';
import 'package:flutter_travelapp/screens/listtours/listtours_screen.dart';
import '../../../size_config.dart';

class ListTourMore extends StatefulWidget {
  const ListTourMore({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListTourMoreState();
}

class _ListTourMoreState extends State<ListTourMore> {
  List<dynamic> _listTour = [];
  List<dynamic> _listTourMore = [];

  initialController() {
    _listTour = [];
    _listTourMore = [];
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
    List<TourModel> toursMore = await TourRepository().getListTour(1, 15);
    setState(() {
      _listTour.addAll(tours);
      _listTourMore.addAll(toursMore);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Chuyến du lịch khác",
            press: () => Navigator.pushNamed(context, ListToursScreen.routeName,
                arguments: ListToursArguments(tours: _listTourMore)),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(10)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                _listTour.length,
                (index) {
                  if (_listTour[index] != null) {
                    return TourCard(
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
