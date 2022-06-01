import "package:flutter/material.dart";
import 'package:flutter_travelapp/components/listtours_argument.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import 'package:flutter_travelapp/screens/error/error_screen.dart';
import 'package:flutter_travelapp/screens/listtours/listtours_screen.dart';
import 'package:flutter_travelapp/size_config.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late List<dynamic> _listTour = [];
  late String search = '';
  initialController() {
    _listTour = [];
  }

  @override
  void initState() {
    super.initState();
    _listTour = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void findTourByName(name) async {
    // _listTour.clear();
    List<dynamic> tours = await TourRepository().findTourByName(name);

    _listTour = tours;
    if (_listTour.isEmpty) {
      Navigator.pushNamed(context, ErrorScreen.routeName);
    } else {
      Navigator.pushNamed(context, ListToursScreen.routeName,
          arguments: ListToursArguments(tours: _listTour));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.7,
      //height: 50,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) {
          search = value;
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Tìm kiếm",
          prefixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => {
                    // ignore: avoid_print
                    // print('hello'+_listTour.length);
                    findTourByName(search),
                  }),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(9),
          ),
        ),
      ),
    );
  }
}
