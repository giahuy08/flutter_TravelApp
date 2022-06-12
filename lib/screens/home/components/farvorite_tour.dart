import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_travelapp/components/listtours_argument.dart';
import 'package:flutter_travelapp/components/tour_card.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import 'package:flutter_travelapp/screens/details_tour/details_screen.dart';
import 'package:flutter_travelapp/screens/listtours/listtours_screen.dart';
import 'package:flutter_travelapp/size_config.dart';

import 'section_title.dart';

class FarvoriteTours extends StatefulWidget {
  const FarvoriteTours({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FarvoriteToursState();
}

class _FarvoriteToursState extends State<FarvoriteTours> {
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
    //List<TourModel> tours = await TourRepository().getListTour(1, 5);
    List<TourModel> tours = await TourRepository().getUserFarvorite();
    if (tours.isEmpty) {
      tours = await TourRepository().getListTour(1, 5);
    }
    List<TourModel> toursMore = await TourRepository().getListTour('', '');
    setState(() {
      _listTour.addAll(tours);
      _listTourMore.addAll(toursMore);
    });
  }

  void favoriteTour(String idTour) async {
    await TourRepository().favoriteTour(idTour).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return _listTourMore.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              SpinKitSpinningLines(
                color: Colors.red,
              )
            ],
          )
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(
                  title: "Có thể bạn sẽ thích",
                  press: () => Navigator.pushNamed(
                      context, ListToursScreen.routeName,
                      arguments: ListToursArguments(tours: _listTourMore)),
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      _listTour.length,
                      (index) {
                        if (_listTour[index] != null) {
                          return TourCard(
                              tour: _listTour[index],
                              press: () => {
                                    favoriteTour(_listTour[index].id),
                                    Navigator.pushNamed(
                                        context, DetailScreen.routeName,
                                        arguments: TourDetailsArguments(
                                            object: _listTour[index]))
                                  });
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

