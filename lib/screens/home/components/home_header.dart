import 'package:flutter/material.dart';
import 'package:flutter_travelapp/screens/list_booked_tours/listbooked_screen.dart';
import 'package:flutter_travelapp/screens/notification/notification_list.dart';
import 'package:flutter_travelapp/size_config.dart';

import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SearchField(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/order-history.svg",
            press: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const ListBookedTourScreen()))
            },
          ),
          IconBtnWithCounter(
            svgSrc: 'assets/icons/Bell.svg',
            numOfItems: 3,
            press: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const NotificationList()))
            },
          )
        ],
      ),
    );
  }
}
