import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/default_button.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

  void nextField({required String value, required FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(60),
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 24),
                decoration: otpInputDecoration,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  nextField(value: value, focusNode: pin2FocusNode);
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(60),
              child: TextFormField(
                focusNode: pin2FocusNode,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 24),
                decoration: otpInputDecoration,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  nextField(value: value, focusNode: pin3FocusNode);
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(60),
              child: TextFormField(
                focusNode: pin3FocusNode,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 24),
                decoration: otpInputDecoration,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  nextField(value: value, focusNode: pin4FocusNode);
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(60),
              child: TextFormField(
                focusNode: pin4FocusNode,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 24),
                decoration: otpInputDecoration,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  pin4FocusNode.unfocus();
                },
              ),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.15),
        DefaultButton(
          text: "Gửi",
          press: () {},
        )
      ],
    ));
  }
}
