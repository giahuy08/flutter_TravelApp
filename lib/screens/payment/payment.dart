import 'package:flutter/material.dart';

import 'package:flutter_travelapp/components/default_appbar.dart';
import 'package:flutter_travelapp/components/default_backbutton.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/header_label.dart';
import 'package:flutter_travelapp/repository/authen_repository.dart';
import 'package:flutter_travelapp/repository/booktour_repository.dart';
import 'package:flutter_travelapp/screens/home/home_screen.dart';
import 'package:flutter_travelapp/screens/listtours/listtours_screen.dart';
import 'package:flutter_travelapp/screens/payment/paymentmethod_screen.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../size_config.dart';

class Payment extends StatefulWidget {
  final String id;
  final DateTime date;
  const Payment({
    Key? key,
    required this.id,
    required this.date,
  }) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Object? value = 0;
  void booktour(
      String idTour, String code, String type, String startDate) async {
    await BookTourRepository()
        .bookTourPayment(idTour, code, type, startDate)
        .then((value) {
      print(value);
      if (value != null) {
        Get.snackbar(
          'Payment',
          'Chuyển đến trang thanh toán',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: kPrimaryColor,
          duration: const Duration(
            milliseconds: 800,
          ),
        );
        Future.delayed(const Duration(milliseconds: 800), () {
          // Here you can write your code

          setState(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PaymentMethodScreen(
                  url: value,
                ),
              ),
            );
            //  Navigator.pushNamed(context, PaymentMethodScreen.routeName);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const DefaultAppBar(
        title: 'Payment',
        child: DefaultBackButton(),
      ),
      body: Column(
        children: [
          const HeaderLabel(
            headerText: 'Chọn phương thức thanh toán',
          ),
          Expanded(
            child: ListView.separated(
              itemCount: paymentLabels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Radio(
                    activeColor: kPrimaryColor,
                    value: index,
                    groupValue: value,
                    onChanged: (i) => setState(() => {value = i}),
                  ),
                  title: Text(
                    paymentLabels[index],
                    style: const TextStyle(color: kDarkColor),
                  ),
                  trailing: Image.asset(
                    paymentIcons[index],
                    width: 120,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
          SizedBox(
            height: 55,
            width: 360,
            child: DefaultButton(
                text: 'Thanh toán',
                press: () {
                  // print(value);

                  booktour(
                      widget.id, '', value.toString(), widget.date.toString());
                }),
          ),
          SizedBox(height: getProportionateScreenWidth(30)),
        ],
      ),
    );
  }
}
