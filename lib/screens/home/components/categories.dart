import "package:flutter/material.dart";
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/screens/bookedtour_booking/bookedtour_home_screen.dart';
import 'package:flutter_travelapp/screens/list_enterprise/listenterprise_screen.dart';
import 'package:flutter_travelapp/screens/list_vehicle/cars_overview.dart';
import 'package:flutter_travelapp/size_config.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/images/tour.png",
        "text": "Du lịch",
        "press": BookedTourHomeScreen.routeName
      },
      {
        "icon": "assets/images/hotelbuilding.png",
        "text": "Khách sạn",
        "press": ListEnterpriseScreen.routeName
      },
      {
        "icon": "assets/images/restaurant.png",
        "text": "Nhà hàng",
        "press": ListEnterpriseScreen.routeName
      },
      {
        "icon": "assets/images/vehicles.png",
        "text": "Phương tiện",
        "press": CarsOverviewScreen.routeName
      },
      // {"icon": "assets/images/more.png", "text": "Khác"},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () => Navigator.pushNamed(
              context,
              categories[index]["press"],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(icon),
            ),
            const SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
