import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/models/booktour.dart';
import 'package:flutter_travelapp/repository/booktour_repository.dart';
import 'package:flutter_travelapp/screens/details_tour/details_screen.dart';
import 'package:flutter_travelapp/screens/reviewtour/reviewtour_screen.dart';
import 'package:sizer/sizer.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../size_config.dart';
import 'package:intl/intl.dart';

class TourBookedItem extends StatefulWidget {
  const TourBookedItem({Key? key}) : super(key: key);

  @override
  _TourBookedItemState createState() => _TourBookedItemState();
}

class _TourBookedItemState extends State<TourBookedItem> {
  List<dynamic> _listBookTour = [];
  final oCcy = NumberFormat("#,##0", "en_US");

  //get kPrimaryColor => null;

  initialController() {
    _listBookTour = [];
  }

  @override
  void initState() {
    super.initState();
    getListBookTour();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getListBookTour() async {
    List<BookTourModel> tours =
        await BookTourRepository().getUserBookTour('1', '5');
    setState(() {
      _listBookTour.addAll(tours);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _listBookTour.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10.h),
                  Image.asset('assets/images/airline.png',
                      width: getProportionateScreenHeight(50.w),
                      height: getProportionateScreenHeight(20.h)),
                  SizedBox(height: 5.h),
                  const SpinKitSpinningLines(
                    color: Colors.red,
                  )
                ],
              )
            : Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _listBookTour.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: _buildItem(context, index),
                        onTap: () {
                          Navigator.pushNamed(context, ReviewScreen.routeName,
                              arguments: ProductDetailsArguments(
                                  tour: _listBookTour[index]));
                        },
                      );
                    })),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          padding: EdgeInsets.all(getProportionateScreenHeight(12)),
          height: getProportionateScreenHeight(250),
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(_listBookTour[index].imagesTour[0]),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 7, spreadRadius: 1, color: Colors.black12)
                    ]),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black87
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12, left: 40, right: 12),
                        child: Row(children: <Widget>[
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.directions,
                              color: Colors.white,
                              size: 20,
                            ),
                            decoration: const BoxDecoration(
                                color: Colors.black38,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * .48,
                height: 200,
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7, spreadRadius: 1, color: Colors.black12)
                    ]),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        const Icon(
                          Icons.attach_money_outlined,
                          size: 18,
                        ),
                        Text(
                          oCcy.format(_listBookTour[index].finalpayment),
                          style:
                              const TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        const Text(' VNĐ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red))
                      ],
                    ),
                    Text(
                      _listBookTour[index].name,
                      style: const TextStyle(
                          fontFamily: 'Muli',
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SmoothStarRating(
                          borderColor: Colors.yellow,
                          color: Colors.yellow,
                          allowHalfRating: true,
                          starCount: 5,
                          size: 12,
                          filledIconData: Icons.star,
                          onRated: (v) {},
                          isReadOnly: false,
                          spacing: 4,
                          rating: _listBookTour[index].star,
                        ),
                        Text(
                          _listBookTour[index].star.toStringAsFixed(1) + " Sao",
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 10),
                        )
                      ],
                    ),
                    Wrap(
                      children: <Widget>[
                        _listBookTour[index].status == 0
                            ? const StatusCard(
                                status: " Chờ xác nhận",
                                color: Colors.amber,
                                icon: Icons.access_alarm)
                            : _listBookTour[index].status == 1
                                ? const StatusCard(
                                    status: " Đã đặt",
                                    color: Colors.greenAccent,
                                    icon: Icons.task_alt)
                                : const StatusCard(
                                    status: " Đã Hủy",
                                    color: Colors.redAccent,
                                    icon: Icons.cancel_outlined),
                      ],
                    ),
                    const Spacer(),
                    Wrap(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.only(bottom: 6, right: 6),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: kPrimaryColor),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.place,
                                color: Colors.white,
                              ),
                              Text(
                                _listBookTour[index].place,
                                style: const TextStyle(
                                    fontSize: 8, color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}

class StatusCard extends StatelessWidget {
  const StatusCard({
    Key? key,
    required this.status,
    required this.color,
    required this.icon,
  }) : super(key: key);

  final String status;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.only(top: 4, bottom: 8, right: 48),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: color),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          Text(
            status,
            style: const TextStyle(
                fontFamily: 'Muli', fontSize: 10, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class BookTour {}
