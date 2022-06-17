import 'package:flutter/material.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:flutter_travelapp/screens/change_password/components/change_form.dart';
import 'package:flutter_travelapp/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Text(
              //   "Đổi mật khẩu",
              //   style: headingStyle,
              // ),
              Image.asset('assets/images/airline.png',
                  height: getProportionateScreenHeight(80)),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
               Text(Languages.of(context)!.enterFullInfoText),
              const SizedBox(
                  // height: SizeConfig.screenHeight * 0.08,
                  ),
              const ChangeForm(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.06,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
