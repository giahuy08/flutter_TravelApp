import "package:flutter/material.dart";

import 'package:flutter_travelapp/models/discount.dart';
import 'package:flutter_travelapp/repository/discount_repository.dart';
import 'package:flutter_travelapp/size_config.dart';

import 'section_title.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscountBanner> createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  List<dynamic> _listDiscount = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListTour();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getListTour() async {
    List<dynamic> discounts = await DiscountRepository().getListDiscount();
    setState(() {
      _listDiscount.addAll(discounts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Ưu đãi hấp dẫn",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                _listDiscount.length,
                (index) {
                  if (_listDiscount[index] != null) {
                    return DiscountBannerCard(
                      title: _listDiscount[index]['code'],
                      discount: _listDiscount[index]['discount'].toString(),
                      tourName: _listDiscount[index]['nameTour'].toString(),
                      press: () {},
                    );
                  }
                  return const SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              // DiscountBannerCard(
              //   title: 'Nha Trang, Đà Lạt',
              //   discount: 'Giảm giá 25%',
              //   press: () {},
              // ),
              // DiscountBannerCard(
              //   title: 'Vũng Tàu, Mũi Né',
              //   discount: 'Giảm giá 10%',
              //   press: () {},
              // ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class DiscountBannerCard extends StatelessWidget {
  const DiscountBannerCard({
    Key? key,
    required this.title,
    required this.discount,
    required this.tourName,
    required this.press,
  }) : super(key: key);

  final String title;
  //final String image;
  final String discount;
  final String tourName;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenWidth(90),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A3298),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tourName,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "-" + discount.toString() + '%',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
