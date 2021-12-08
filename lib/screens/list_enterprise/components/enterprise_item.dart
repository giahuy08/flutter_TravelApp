import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/models/enterprise.dart';
import 'package:flutter_travelapp/repository/enterprise_repository.dart';
import 'package:sizer/sizer.dart';

import '../../../size_config.dart';
import 'package:intl/intl.dart';

class EnterpriseItem extends StatefulWidget {
  const EnterpriseItem({Key? key}) : super(key: key);

  @override
  _EnterpriseItemState createState() => _EnterpriseItemState();
}

class _EnterpriseItemState extends State<EnterpriseItem> {
  List<EnterpriseModel> _listEnterprise = [];
  final oCcy = NumberFormat("#,##0", "en_US");

  //get kPrimaryColor => null;

  initialController() {
    _listEnterprise = [];
  }

  @override
  void initState() {
    super.initState();
    getListEnterprise();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getListEnterprise() async {
    List<EnterpriseModel> listenterprise =
        await EnterpriseRepository().getListEnterprise();
    setState(() {
      _listEnterprise.addAll(listenterprise);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _listEnterprise.isEmpty
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
                    itemCount: _listEnterprise.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: _buildItem(context, index),
                        onTap: () {},
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
          height: getProportionateScreenHeight(25.h),
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(_listEnterprise[index].logo),
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
                height: 20.h,
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
                          size: 20,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          _listEnterprise[index].name,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ],
                    ),
                    Text(
                      _listEnterprise[index].detail,
                      style: const TextStyle(
                          fontFamily: 'Muli',
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
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
                          child: _listEnterprise[index].type == 0
                              ? const StatusCard(
                                  status: " ENTERPRISE",
                                  color: kPrimaryColor,
                                  icon: Icons.business)
                              : _listEnterprise[index].type == 1
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

class BookTour {}
