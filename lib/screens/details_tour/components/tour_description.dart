import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/models/enterprise.dart';
import 'package:flutter_travelapp/models/vehicle.dart';
import 'package:flutter_travelapp/repository/enterprise_repository.dart';
import 'package:flutter_travelapp/repository/vehicle_repository.dart';
import 'package:flutter_travelapp/screens/bookedtour_booking/bookedtour_app_theme.dart';
import 'package:flutter_travelapp/screens/details_tour/components/hotel_table_banner.dart';
import 'package:flutter_travelapp/screens/details_tour/components/list_tour_more.dart';
import 'package:flutter_travelapp/screens/details_tour/components/review_tour.dart';
import 'package:flutter_travelapp/screens/details_tour/components/tour_images.dart';
import 'package:flutter_travelapp/screens/details_tour/components/top_rounded_container.dart';
import 'package:flutter_travelapp/screens/payment/payment.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

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
            height: 95.h,
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
                    width: 15.w,
                    decoration: BoxDecoration(
                        color: (widget.tour.star > 3)
                            ? const Color(0xFFFFE6E6)
                            : const Color(0xFFF5F6F9),
                        //color: const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(50)),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      color: (widget.tour.star > 3)
                          ? const Color(0xFFFF4848)
                          : const Color(0xFFDBDEE4),
                      //color: const Color(0xFFDBDEE4),
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
                nameEnterprise == ""
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
                            horizontal: 20, vertical: 5),
                        child: _buildItemEnterprise(context),
                      ),
                nameVehicle == ""
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
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                              width: MediaQuery.of(context).size.width * .48,
                              padding: EdgeInsets.all(
                                  getProportionateScreenHeight(10.sp)),
                              decoration: BoxDecoration(
                                  color: BookedTourAppTheme.buildLightTheme()
                                      .backgroundColor,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        spreadRadius: 1)
                                  ]),
                              child: Column(
                                children: [
                                  Hero(
                                      tag: itemVehicle.name,
                                      child: Image.network(
                                          itemVehicle.imagesVehicle[0])),
                                  Text(
                                    itemVehicle.vehicleNumber,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    itemVehicle.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    maxLines: 1,
                                  ),
                                ],
                              )),
                        ),
                      ),
                HotelTableBanner(
                  idEnterprise: widget.tour.idEnterprise,
                ),
              ],
            ),
          ),
          const ListTourMore(),
          SizedBox(height: getProportionateScreenWidth(20)),
          kSmallDivider,
          ReviewTour(tour: widget.tour),
          kSmallDivider,
          TopRoundedContainer(
            color: Colors.white,
            height: 45.h,
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: selectDate,
                    icon: const Icon(
                        Icons.date_range), //icon data for elevated button
                    label: const Text("Chọn ngày khởi hành"), //label text
                    style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor //elevated btton background color
                        ),
                  ),
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: buildCodeFormField(),
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
                                          codediscount: discount,
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

  Widget _buildItemEnterprise(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          padding: EdgeInsets.all(getProportionateScreenHeight(12)),
          height: 20.h,
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(itemEnterprise.logo),
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
                            child: Icon(
                              Icons.work_outline,
                              color: Colors.white,
                              size: 10.sp,
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
                height: 15.h,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.group,
                          size: 14,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          itemEnterprise.name,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ],
                    ),
                    Text(
                      itemEnterprise.detail,
                      style: const TextStyle(
                          fontFamily: 'Muli',
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                    const Spacer(),
                    Wrap(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.only(bottom: 6, right: 6),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: kPrimaryColor),
                          child: itemEnterprise.type == 0
                              ? const StatusCard(
                                  status: " ENTERPRISE",
                                  color: kPrimaryColor,
                                  icon: Icons.business)
                              : itemEnterprise.type == 1
                                  ? const StatusCard(
                                      status: " HOTEL",
                                      color: kPrimaryColor,
                                      icon: Icons.hotel)
                                  : const StatusCard(
                                      status: " RESTAURANT",
                                      color: kPrimaryColor,
                                      icon: Icons.restaurant),
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

  TextFormField buildCodeFormField() {
    return TextFormField(
        style: const TextStyle(fontSize: 15),
        textCapitalization: TextCapitalization.characters,
        keyboardType: TextInputType.text,
        onSaved: (newValue) => discount = newValue!,
        onChanged: (value) {
          discount = value;
          return;
        },
        decoration: InputDecoration(
            hintText: "Mã giảm giá",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.wallet_giftcard),
              color: kPrimaryColor,
            )));
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
