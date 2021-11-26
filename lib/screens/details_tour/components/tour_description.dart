import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/screens/details_tour/components/hotel_tour.dart';
import 'package:flutter_travelapp/screens/details_tour/components/review_tour.dart';
import 'package:flutter_travelapp/screens/details_tour/components/tour_images.dart';
import 'package:flutter_travelapp/screens/details_tour/components/top_rounded_container.dart';
import 'package:flutter_travelapp/screens/payment/payment.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class TourDescription extends StatelessWidget {
  const TourDescription({
    Key? key,
    required this.tour,
    required this.pressOnSeeMore,
  }) : super(key: key);

  final dynamic tour;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "en_US");
    return SingleChildScrollView(
      child: Column(
        children: [
          TourImages(tour: tour),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Text(
                      tour.name,
                      style: Theme.of(context).textTheme.headline6,
                    )),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: 64,
                    decoration: BoxDecoration(
                        // color: tour.isFavourite
                        //     ? const Color(0xFFFFE6E6)
                        //     : const Color(0xFFF5F6F9),
                        color: const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(50)),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      // color: tour.isFavourite
                      //     ? const Color(0xFFFF4848)
                      //     : const Color(0xFFDBDEE4),
                      color: const Color(0xFFDBDEE4),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(64)),
                  child: Text(
                    tour.detail,
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: getProportionateScreenWidth(20)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: DefaultButton(text: "Xem chi tiết", press: () {}),
                ),
              ],
            ),
          ),
          const HotelTour(),
          SizedBox(height: getProportionateScreenWidth(20)),
          kSmallDivider,
          ReviewTour(tour: tour),
          kSmallDivider,
          TopRoundedContainer(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                children: [
                  const Text('Cổng thanh toán'),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: SvgPicture.asset(
                        "assets/images/paypal.svg",
                        height: 40,
                        width: 40,
                      ),
                      title: Text(
                        "PAYPAL",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/images/vnpay_qr.png",
                        height: 40,
                        width: 40,
                      ),
                      title: Text(
                        "VNPAY",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(oCcy.format(tour.payment),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            const Text(
                              'VNĐ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                            height: 55,
                            width: 170,
                            child: DefaultButton(
                              text: 'Đặt ngay',
                              press: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => Payment())),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
