import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/screens/bookedtour_booking/bookedtour_home_screen.dart';
import 'package:flutter_travelapp/screens/home/home_screen.dart';
import 'package:flutter_travelapp/screens/map/map.dart';
import 'package:flutter_travelapp/screens/profile/profile_screen.dart';
import 'package:flutter_travelapp/services/fcm.dart';
import 'package:flutter_travelapp/services/socket.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:alan_voice/alan_voice.dart';

class BottomNavBar extends StatefulWidget {
  static String routeName = "/navbar";
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    connectAndListen();
    handleReceiveNotification(context);
    super.initState();
    // ChatRepository().connectSocket();
  }

  int _selectedIndex = 0;

  _BottomNavBarState() {
    _initAlanButton();
  }

  void _initAlanButton() {
    //AlanVoice.addButton("6a08424e07d808c550a84ac957d366da2e956eca572e1d8b807a3e2338fdd0dc/stage");
    AlanVoice.addButton(
        "d7cb65f737884d94f6e100e6a8628e282e956eca572e1d8b807a3e2338fdd0dc/stage");

    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
    });
    AlanVoice.onCommand.add((command) {
      debugPrint("meme ${command.data["command"].toString()}");

      switch (command.data["command"].toString()) {
        case "booking":
          setState(() {
            _selectedIndex = 2;
          });
          break;
        case "map":
          setState(() {
            _selectedIndex = 1;
          });
          break;
        case "profile":
          setState(() {
            _selectedIndex = 3;
          });
          break;
        case "home":
          setState(() {
            _selectedIndex = 0;
          });
          break;
        case "back":
          setState(() {
            _selectedIndex = 0;
          });
          break;
        default:
          debugPrint("Unknown");
      }
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  final screen = [
    const HomeScreen(),
    const Map(),
    const BookedTourHomeScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: kPrimaryColor,
              iconSize: 22,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.white,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.location_on,
                  text: 'Place',
                ),
                GButton(
                  icon: Icons.history_edu,
                  text: 'Booking',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
