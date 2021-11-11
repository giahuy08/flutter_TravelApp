import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/screens/details_tour/components/hotel_tour.dart';
import 'package:flutter_travelapp/screens/details_tour/details_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class TourItem extends StatelessWidget {
   final List<dynamic> listTour;
  const TourItem({Key? key, required this.listTour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: listTour.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: _buildItem(context, index),
                    onTap: () {
                      Navigator.pushNamed(context, DetailScreen.routeName,
                          arguments:
                              ProductDetailsArguments(tour: listTour[index]));
                    },
                  );
                })),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          padding: EdgeInsets.all(getProportionateScreenHeight(12)),
          height: getProportionateScreenHeight(250),
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(listTour[index].imagesTour[0]),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 7, spreadRadius: 1, color: Colors.black12)
                    ]),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black87
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12, left: 40, right: 12),
                        child: Row(children: <Widget>[
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.directions,
                              color: Colors.white,
                              size: 20,
                            ),
                            decoration: const BoxDecoration(
                                color: Colors.black38,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * .43,
                height: 200,
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7, spreadRadius: 1, color: Colors.black12)
                    ]),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        const Icon(
                          Icons.attach_money_outlined,
                          size: 18,
                        ),
                        Text(
                          listTour[index].payment.toString(),
                          style:
                              const TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        const Text(' VND',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red))
                      ],
                    ),
                    Text(
                      listTour[index].name,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SmoothStarRating(
                          borderColor: Colors.yellow,
                          color: Colors.yellow,
                          allowHalfRating: true,
                          starCount: 5,
                          size: 12,
                          filledIconData: Icons.star,
                          onRated: (v) {},
                          isReadOnly: false,
                          spacing: 4,
                          rating: listTour[index].star,
                        ),
                        const Text(
                          "300 reviews",
                          style: TextStyle(color: Colors.black87, fontSize: 10),
                        )
                      ],
                    ),
                    Spacer(),
                    Wrap(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.only(bottom: 6, right: 6),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.green),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.place,
                                color: Colors.white,
                              ),
                              Text(
                                listTour[index].place,
                                style: const TextStyle(
                                    fontSize: 8, color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ])),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'London...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
             
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.search, size: 20, color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
