import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_travelapp/components/listtours_argument.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import 'package:flutter_travelapp/screens/error/error_screen.dart';
import 'package:flutter_travelapp/screens/listtours/listtours_screen.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  List<dynamic> _listOthers = [];
  List<dynamic> _listSea = [];
  List<dynamic> _listHighLand = [];

  initialController() {
    _listOthers = [];
    _listSea = [];
    _listHighLand = [];
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
    List<TourModel> listOthers =
        await TourRepository().findAllTourByCategory(0);
    List<TourModel> listSea = await TourRepository().findAllTourByCategory(1);
    List<TourModel> listHighLand =
        await TourRepository().findAllTourByCategory(2);
    setState(() {
      _listOthers.addAll(listOthers);
      _listSea.addAll(listSea);
      _listHighLand.addAll(listHighLand);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _listSea.isEmpty
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
                  title: "Có thể bạn quan tâm",
                  press: () {},
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SpecialOfferCard(
                      image: "assets/images/biendep.jpg",
                      category: "Biển Đảo",
                      numOfTours: _listSea.length,
                      press: () {
                        if (_listSea.isEmpty) {
                          Navigator.pushNamed(context, ErrorScreen.routeName);
                        } else {
                          Navigator.pushNamed(
                              context, ListToursScreen.routeName,
                              arguments: ListToursArguments(tours: _listSea));
                        }
                      },
                    ),
                    SpecialOfferCard(
                      image: "assets/images/vungcao.jpg",
                      category: "Vùng Cao",
                      numOfTours: _listHighLand.length,
                      press: () {
                        if (_listHighLand.isEmpty) {
                          Navigator.pushNamed(context, ErrorScreen.routeName);
                        } else {
                          Navigator.pushNamed(
                              context, ListToursScreen.routeName,
                              arguments:
                                  ListToursArguments(tours: _listHighLand));
                        }
                      },
                    ),
                    SpecialOfferCard(
                      image: "assets/images/dulichkhac.jpg",
                      category: "Khác",
                      numOfTours: _listOthers.length,
                      press: () {
                        if (_listOthers.isEmpty) {
                          Navigator.pushNamed(context, ErrorScreen.routeName);
                        } else {
                          Navigator.pushNamed(
                              context, ListToursScreen.routeName,
                              arguments:
                                  ListToursArguments(tours: _listOthers));
                        }
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                ),
              ),
            ],
          );
  }
}

class SpecialOfferCard extends StatefulWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfTours,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfTours;
  final GestureTapCallback press;

  @override
  State<SpecialOfferCard> createState() => _SpecialOfferCardState();
}

class _SpecialOfferCardState extends State<SpecialOfferCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: widget.press,
        child: SizedBox(
          width: getProportionateScreenWidth(165),
          height: getProportionateScreenWidth(90),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  widget.image,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "${widget.category}\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "${widget.numOfTours} Tours")
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
  }
}
