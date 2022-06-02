import "package:flutter/material.dart";
import 'package:flutter_travelapp/screens/home/components/categories.dart';
import 'package:flutter_travelapp/screens/home/components/discount_banner.dart';
import 'package:flutter_travelapp/screens/home/components/farvorite_tour.dart';
import 'package:flutter_travelapp/screens/home/components/historyaccess_tour.dart';
import 'package:flutter_travelapp/screens/home/components/home_header.dart';
import 'package:flutter_travelapp/screens/home/components/slider_banner.dart';
import 'package:flutter_travelapp/screens/home/components/special_offers.dart';
import 'package:flutter_travelapp/size_config.dart';


class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            const SliderBanner(),
            SizedBox(height: getProportionateScreenWidth(10)),
            const DiscountBanner(),
            const Categories(),
            const SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            const FarvoriteTours(),
            SizedBox(height: getProportionateScreenWidth(30)),
            const HistoryAccesses(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
