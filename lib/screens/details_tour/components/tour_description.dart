import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/screens/details_tour/components/hotel_tour.dart';
import 'package:flutter_travelapp/screens/details_tour/components/review_tour.dart';
import 'package:flutter_travelapp/screens/details_tour/components/tour_images.dart';
import 'package:flutter_travelapp/screens/details_tour/components/top_rounded_container.dart';
import 'package:flutter_travelapp/screens/payment/payment.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class TourDescription extends StatefulWidget {
  const TourDescription({
    Key? key,
    required this.tour,
    required this.pressOnSeeMore,
  }) : super(key: key);

  final dynamic tour;
  final GestureTapCallback pressOnSeeMore;

  @override
  State<TourDescription> createState() => _TourDescriptionState();
}

class _TourDescriptionState extends State<TourDescription> {
  DateTime selectedDate = DateTime.now();
  dynamic _enterprise;


 

  void selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.input,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "en_US");

    return SingleChildScrollView(
      child: Column(
        children: [
          TourImages(tour: widget.tour),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Text(
                      widget.tour.name,
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
                    widget.tour.detail,
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
          ReviewTour(tour: widget.tour),
          kSmallDivider,
          TopRoundedContainer(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: selectDate,
                    icon:
                        Icon(Icons.date_range), //icon data for elevated button
                    label: const Text("Chọn ngày đi"), //label text
                    style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor //elevated btton background color
                        ),
                  ),
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(oCcy.format(widget.tour.payment),
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
                            width: 150,
                            child: DefaultButton(
                              text: 'Đặt ngay',
                              press: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => Payment(
                                          id: widget.tour.id,
                                          date: selectedDate))),
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
