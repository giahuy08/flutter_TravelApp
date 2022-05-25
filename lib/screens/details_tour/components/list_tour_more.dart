import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/listtours_argument.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import 'package:flutter_travelapp/screens/details_tour/components/tour_card.dart';
import 'package:flutter_travelapp/screens/details_tour/details_screen.dart';
import 'package:flutter_travelapp/screens/home/components/section_title.dart';
import 'package:flutter_travelapp/screens/listtours/listtours_screen.dart';
import 'package:flutter_travelapp/size_config.dart';

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
        SizedBox(height: getProportionateScreenWidth(14)),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Chuyến du lịch khác",
            press: () => Navigator.pushNamed(context, ListToursScreen.routeName,
                arguments: ListToursArguments(tours: _listTourMore)),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(_listTour.length, (index) {
                return Padding(
                  padding:
                      EdgeInsets.only(left: getProportionateScreenWidth(20)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, DetailScreen.routeName,
                          arguments:
                              TourDetailsArguments(object: _listTour[index]));
                    },
                    child: SizedBox(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Image.network(
                              _listTour[index].imagesTour[0],
                              width: getProportionateScreenWidth(150),
                              height: getProportionateScreenWidth(200),
                              fit: BoxFit.cover,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(0xFF343434).withOpacity(0.4),
                                    const Color(0xFF343434).withOpacity(0.15),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${_listTour[index].name}\n",
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(16),
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${(_listTour[index].star).toStringAsFixed(1)}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Icon(Icons.star,
                                            size: 20, color: Colors.orange),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}
