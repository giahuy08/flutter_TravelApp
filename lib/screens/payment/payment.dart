import 'package:flutter/material.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:get/get.dart';

import 'package:flutter_travelapp/components/default_appbar.dart';
import 'package:flutter_travelapp/components/default_backbutton.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/header_label.dart';
import 'package:flutter_travelapp/repository/booktour_repository.dart';
import 'package:flutter_travelapp/screens/bookedtour_booking/bookedtour_home_screen.dart';
import 'package:flutter_travelapp/screens/payment/paymentmethod_screen.dart';

import '../../constants.dart';
import '../../size_config.dart';

class Payment extends StatefulWidget {
  final String id;
  final String codediscount;
  final DateTime date;
  const Payment({
    Key? key,
    required this.id,
    required this.codediscount,
    required this.date,
  }) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  void initState() {
    super.initState();
    print(widget.codediscount);
    print(widget.date);
  }

  Object? value = 0;
  void booktour(
      String idTour, String code, String type, String startDate) async {
    if (value == 0) {
      await BookTourRepository()
          .bookTour(idTour, code, startDate)
          .then((value) {
        print(value);
        if (value == "The tour is already booked") {
          Get.snackbar(
            'Warning',
            'Tour đã được đặt',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green,
            duration: const Duration(
              milliseconds: 800,
            ),
          );
        } else {
          Get.snackbar(
            'Success',
            'Đặt tour thành công',
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
              Navigator.pushNamed(context, BookedTourHomeScreen.routeName
                  //  Navigator.pushNamed(context, PaymentMethodScreen.routeName);
                  );
            });
          });
        }
      });
    } else {
      await BookTourRepository()
          .bookTourPayment(idTour, code, type, startDate)
          .then((value) {
        if (value == 'Code Discount doesn\'t exist') {
          Get.snackbar(
            'Warning',
            'Mã giảm giá không hợp lệ',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green,
            duration: const Duration(
              milliseconds: 800,
            ),
          );
        } else {
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
        }
      });
    }
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
          HeaderLabel(
            headerText: Languages.of(context)!.typeofPaymentText,
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
                text: Languages.of(context)!.paymentText,
                press: () {
                  booktour(widget.id, widget.codediscount, value.toString(),
                      widget.date.toString());
                }),
          ),
          SizedBox(height: getProportionateScreenWidth(30)),
        ],
      ),
    );
  }
}
