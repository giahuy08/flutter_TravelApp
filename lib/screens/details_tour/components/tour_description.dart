import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/models/enterprise.dart';
import 'package:flutter_travelapp/models/vehicle.dart';
import 'package:flutter_travelapp/repository/enterprise_repository.dart';
import 'package:flutter_travelapp/repository/vehicle_repository.dart';
import 'package:flutter_travelapp/screens/details_tour/components/hotel_table_banner.dart';
import 'package:flutter_travelapp/screens/details_tour/components/list_tour_more.dart';
import 'package:flutter_travelapp/screens/details_tour/components/review_tour.dart';
import 'package:flutter_travelapp/screens/details_tour/components/tour_images.dart';
import 'package:flutter_travelapp/screens/details_tour/components/top_rounded_container.dart';
import 'package:flutter_travelapp/screens/itinerary_pdf/itinerary_screen.dart';
import 'package:flutter_travelapp/screens/schedule_tour/seats_grid_page.dart';
import 'package:flutter_travelapp/size_config.dart';
import 'package:sizer/sizer.dart';

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
  dynamic itemEnterprise;
  String nameEnterprise = "";
  dynamic itemVehicle;
  String nameVehicle = "";
  DateTime selectedDate = DateTime.now();
  late String discount = '';
  final List<String> errors = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getData() async {
    dynamic enterprise =
        await EnterpriseRepository().getOneEnterprise(widget.tour.idEnterprise);
    dynamic vehicle =
        await VehicleRepository().getOneVehicle(widget.tour.idVehicles[0]);
    setState(() {
      itemEnterprise = EnterpriseModel.fromMap(enterprise);
      itemVehicle = VehicleModel.fromMap(vehicle);
      nameEnterprise = itemEnterprise.name;
      nameVehicle = itemVehicle.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TourImages(tour: widget.tour),
          TopRoundedContainer(
            color: Colors.white,
            height: 90.h,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenWidth(10)),
                  child: Text(
                    widget.tour.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(5)),
                  child: Row(
                    children: [
                      const Icon(Icons.place_outlined),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('Điểm xuất phát: '),
                      Text(
                        widget.tour.startingplace,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(5)),
                  child: Row(
                    children: [
                      const Icon(Icons.place_rounded),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('Điểm đến: '),
                      Text(
                        widget.tour.place,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 15.w,
                    decoration: BoxDecoration(
                        color: (widget.tour.star > 3)
                            ? const Color(0xFFFFE6E6)
                            : const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(50)),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      color: (widget.tour.star > 3)
                          ? const Color(0xFFFF4848)
                          : const Color(0xFFDBDEE4),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(20),
                        right: getProportionateScreenWidth(64)),
                    child: Text(
                      widget.tour.detail,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    )),
                SizedBox(height: getProportionateScreenWidth(20)),
                nameVehicle == "" || nameEnterprise == "" || itemVehicle == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 10.h),
                          const SpinKitSpinningLines(
                            color: Colors.red,
                          )
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ServiceCard(
                                  image: itemVehicle.imagesVehicle[0],
                                  text: itemVehicle.vehicleNumber,
                                  color: const Color(0xfff3c7fff),
                                  subText: itemVehicle.name,
                                ),
                                ServiceCard(
                                  image: itemEnterprise.logo,
                                  text: itemEnterprise.name,
                                  color: const Color(0xfffffa13a),
                                  subText: 'ENTERPRISE',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                HotelTableBanner(
                  idEnterprise: widget.tour.idEnterprise,
                ),
              ],
            ),
          ),
          SizedBox(
              height: 6.h,
              width: MediaQuery.of(context).size.width - 45,
              child: DefaultButton(
                text: 'Xem lịch trình',
                press: () => {
                  Navigator.pushNamed(context, ItineraryScreen.routeName,
                      arguments: TourDetailsArguments(object: widget.tour)),
                },
              )),
          kSmallDivider,
          const ListTourMore(),
          SizedBox(height: getProportionateScreenWidth(20)),
          kSmallDivider,
          ReviewTour(tour: widget.tour),
          kSmallDivider,
          SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width - 20,
              child: DefaultButton(
                text: 'Đặt ngay',
                press: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SeatsGridPage(tour: widget.tour))),
              )),
          kSmallDivider,
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    Key? key,
    required this.text,
    required this.image,
    required this.color,
    this.subText = '',
  }) : super(key: key);

  final String text;
  final String subText;

  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width / 2 - 30,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10),
            width: getProportionateScreenWidth(70),
            height: getProportionateScreenWidth(60),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage(image)),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 10, spreadRadius: 1)
                ]),
          ),
          Positioned(
            bottom: 10,
            left: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    text,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(13),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subText,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
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
      height: 2.h,
      margin: const EdgeInsets.only(top: 4, bottom: 8, right: 48),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: color),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            status,
            style: const TextStyle(
                fontFamily: 'Muli', fontSize: 10, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
