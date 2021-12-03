import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_travelapp/components/default_appbar.dart';
import 'package:flutter_travelapp/components/default_backbutton.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/discount_repository.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import 'package:flutter_travelapp/screens/details_tour/details_screen.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/discount_tiles.dart';

class DiscountList extends StatefulWidget {
  static String routeName = "/discountlist";
  const DiscountList({Key? key}) : super(key: key);

  @override
  _DiscountListState createState() => _DiscountListState();
}

class _DiscountListState extends State<DiscountList> {
  List<dynamic> _listDiscount = [];
  dynamic tour;

  late int i;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListDiscount();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getListDiscount() async {
    List<dynamic> discounts = await DiscountRepository().getListDiscount();

    setState(() {
      _listDiscount.addAll(discounts);
      // for (i = 0; i < discounts.length; i++) {
      //   dynamic tour = TourRepository().getOneTour(_listDiscount[i]['idTour']);
      //   _listTour.add(tour);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const DefaultAppBar(
        title: 'Ưu đãi',
        child: DefaultBackButton(),
      ),
      body: _listDiscount.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/airline.png',
                    width: getProportionateScreenHeight(50.w),
                    height: getProportionateScreenHeight(20.h)),
                SizedBox(height: 5.h),
                const SpinKitSpinningLines(
                  color: Colors.red,
                )
              ],
            )
          : ListView.separated(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: _listDiscount.length,
              itemBuilder: (context, index) {
                return DiscountTiles(
                  title: "Mã: " + _listDiscount[index]['code'].toString(),
                  discount:
                      "-" + _listDiscount[index]['discount'].toString() + "%",
                  tourname: _listDiscount[index]['nameTour'].toString(),
                  image: _listDiscount[index]['imageTour'].toString(),
                  enable: true,
                  onTap: () async => {
                    // tour = await TourRepository()
                    //     .getOneTour(_listDiscount[index]['idTour']),
                    // Navigator.pushNamed(context, DetailScreen.routeName,
                    //     arguments: ProductDetailsArguments(tour: tour)),
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              }),
    );
  }
}
