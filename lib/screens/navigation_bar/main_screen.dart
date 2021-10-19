import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/screens/home/home_screen.dart';
import 'package:flutter_travelapp/screens/login_success/login_success_screen.dart';
import 'package:flutter_travelapp/screens/navigation_bar/cart.dart';
import 'package:flutter_travelapp/screens/navigation_bar/feed.dart';
import 'package:flutter_travelapp/screens/navigation_bar/message.dart';
import 'package:flutter_travelapp/screens/profile/profile_screen.dart';
import 'package:flutter_travelapp/size_config.dart';

import 'navbar_key.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "/main";
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final screen = [
    const HomeScreen(),
    const LoginSuccessScreen(),
    const MessageScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: getProportionateScreenHeight(62),
        backgroundColor: Colors.transparent,
        color: kPrimaryColor,
        buttonBackgroundColor: kPrimaryColor,
        index: selectedIndex,
        key: NavbarKey.getKey(),
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.rss_feed,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.message,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        animationCurve: Curves.easeInBack,
        animationDuration: const Duration(milliseconds: 300),
      ),
      body: screen[selectedIndex],
    );
  }
}
