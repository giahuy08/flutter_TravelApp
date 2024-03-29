import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_travelapp/components/listtours_argument.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import 'package:flutter_travelapp/screens/error/error_screen.dart';
import 'package:flutter_travelapp/screens/listtours/listtours_screen.dart';
import 'package:alan_voice/alan_voice.dart';

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
  List<dynamic> _listTourMore = [];

  initialController() {
    _listOthers = [];
    _listSea = [];
    _listHighLand = [];
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
    List<TourModel> listOthers =
        await TourRepository().findAllTourByCategory(0);
    List<TourModel> listSea = await TourRepository().findAllTourByCategory(1);
    List<TourModel> listHighLand =
        await TourRepository().findAllTourByCategory(2);
    List<TourModel> toursMore = await TourRepository().getListTour('', '');
    setState(() {
      _listOthers.addAll(listOthers);
      _listSea.addAll(listSea);
      _listHighLand.addAll(listHighLand);
      _listTourMore.addAll(toursMore);
    });
  }

  _SpecialOffersState() {
    _initAlanCategory();
  }

  void _initAlanCategory() {
    //AlanVoice.addButton("6a08424e07d808c550a84ac957d366da2e956eca572e1d8b807a3e2338fdd0dc/stage");
    // AlanVoice.addButton(
    //     "d7cb65f737884d94f6e100e6a8628e282e956eca572e1d8b807a3e2338fdd0dc/stage");

    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
    });
    AlanVoice.onCommand.add((command) {
      debugPrint("meme ${command.data["command"].toString()}");

      switch (command.data["command"].toString()) {
        case "sea":
          Navigator.pushNamed(context, ListToursScreen.routeName,
              arguments: ListToursArguments(tours: _listSea));

          break;
        case "highland":
          Navigator.pushNamed(context, ListToursScreen.routeName,
              arguments: ListToursArguments(tours: _listHighLand));
          break;
        case "other":
          Navigator.pushNamed(context, ListToursScreen.routeName,
              arguments: ListToursArguments(tours: _listOthers));
          break;
        default:
          debugPrint("Unknown");
      }
    });
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
                  title: Languages.of(context)!.youCanCareText,
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  widget.image,
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
                  bottom: 8,
                  left: 0,
                  child: Padding(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
