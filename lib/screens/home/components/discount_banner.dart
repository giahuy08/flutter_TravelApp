import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/discount_repository.dart';
import 'package:flutter_travelapp/screens/details_tour/details_screen.dart';
import 'package:flutter_travelapp/screens/discount_list/discount_list.dart';
import 'package:flutter_travelapp/size_config.dart';

import 'section_title.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscountBanner> createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  List<dynamic> _listDiscount = [];

  @override
  void initState() {
    super.initState();
    getListDiscount();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getListDiscount() async {
    List<dynamic> discounts = await DiscountRepository().getListDiscountByEXP();

    setState(() {
      _listDiscount.addAll(discounts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _listDiscount.isEmpty
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
                  title: Languages.of(context)!.saleText,
                  press: () =>
                      Navigator.pushNamed(context, DiscountList.routeName),
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      _listDiscount.length,
                      (index) {
                        if (_listDiscount[index] != null) {
                          return DiscountBannerCard(
                            title: _listDiscount[index]['code'],
                            discount:
                                _listDiscount[index]['discount'].toString(),
                            tourName:
                                _listDiscount[index]['nameTour'].toString(),
                            press: () => {
                              Navigator.pushNamed(
                                  context, DetailScreen.routeName,
                                  arguments: TourDetailsArguments(
                                      object: TourModel.fromMap(
                                          _listDiscount[index]['tour']))),
                            },
                          );
                        }
                        return const SizedBox
                            .shrink(); // here by default width and height is 0
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

class DiscountBannerCard extends StatelessWidget {
  const DiscountBannerCard({
    Key? key,
    required this.title,
    required this.discount,
    required this.tourName,
    required this.press,
  }) : super(key: key);

  final String title;
  //final String image;
  final String discount;
  final String tourName;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(165),
          height: getProportionateScreenWidth(80),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A3298),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tourName,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "-" + discount.toString() + '%',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
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
