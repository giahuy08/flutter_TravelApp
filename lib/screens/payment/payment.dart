import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/default_appbar.dart';
import 'package:flutter_travelapp/components/default_backbutton.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/header_label.dart';
import 'package:flutter_travelapp/success/success.dart';

import '../../constants.dart';
import '../../size_config.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Object? value = 0;

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
              press: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Success(),
                ),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(30)),
        ],
      ),
    );
  }
}
