import "package:flutter/material.dart";
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:flutter_travelapp/repository/enterprise_repository.dart';
import 'package:flutter_travelapp/screens/home/components/section_title.dart';
import 'package:flutter_travelapp/screens/list_enterprise/listenterprise_screen.dart';
import 'package:flutter_travelapp/size_config.dart';
import 'package:sizer/sizer.dart';

class HotelTableBanner extends StatefulWidget {
  const HotelTableBanner({
    Key? key,
    required this.idEnterprise,
  }) : super(key: key);
  final String idEnterprise;

  @override
  State<HotelTableBanner> createState() => _HotelTableBannerState();
}

class _HotelTableBannerState extends State<HotelTableBanner> {
  List<dynamic> _listHotelTable = [];

  @override
  void initState() {
    super.initState();
    getListDiscount();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getListDiscount() async {
    List<dynamic> listHotel =
        await EnterpriseRepository().getListRoom(widget.idEnterprise);
    List<dynamic> listTable =
        await EnterpriseRepository().getListTable(widget.idEnterprise);

    setState(() {
      _listHotelTable.addAll(listHotel);
      _listHotelTable.addAll(listTable);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _listHotelTable.isEmpty
        ? Column(
            children: [
              SizedBox(height: getProportionateScreenWidth(20)),
              Image.asset(
                "assets/images/airline.png",
                width: 50.h,
                height: 15.h,
              ),
              Text(
                Languages.of(context)!.dontUpdateServiceText,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20.0,
                ),
              ),
            ],
          )
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(
                  title: Languages.of(context)!.serviceText,
                  press: () => Navigator.pushNamed(
                      context, ListEnterpriseScreen.routeName),
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      _listHotelTable.length,
                      (index) {
                        if (_listHotelTable[index] != null) {
                          return BannerCard(
                            name: _listHotelTable[index]['name'],
                            bed: _listHotelTable[index]['bed'],
                            detail: _listHotelTable[index]['detail'].toString(),
                            press: () => {},
                          );
                        }
                        return const SizedBox
                            .shrink(); // here by default width and height is 0
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                ),
              ),
            ],
          );
  }
}

class BannerCard extends StatelessWidget {
  const BannerCard({
    Key? key,
    required this.name,
    required this.bed,
    required this.detail,
    required this.press,
  }) : super(key: key);

  final dynamic bed;
  //final String image;
  final String name;
  final String detail;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(165),
          height: getProportionateScreenWidth(80),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kPrimaryColor,
                      width: 2.sp,
                    ),
                    color: Colors.transparent,
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
                        detail,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color: kPrimaryColor,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: kPrimaryColor,
                            ),
                          ),
                          bed == null
                              ? const Icon(
                                  Icons.restaurant,
                                  color: kPrimaryColor,
                                )
                              : const Icon(
                                  Icons.hotel,
                                  color: kPrimaryColor,
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
