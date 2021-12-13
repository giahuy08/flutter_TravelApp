import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/social_card.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/screens/sign_up/components/sign_up_form.dart';
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
              Text(
                "Đăng ký tài khoản",
                style: headingStyle,
              ),
              const Text("Đăng ký thông tin"),
              const SizedBox(
                  // height: SizeConfig.screenHeight * 0.08,
                  ),
              const SignUpForm(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.06,
              ),
              // const Text('Hoặc tiếp tục với'),
              // SizedBox(
              //   height: getProportionateScreenHeight(20),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SocialCard(
              //       icon: "assets/icons/google-icon.svg",
              //       press: () {},
              //     ),
              //     SocialCard(
              //       icon: "assets/icons/facebook-2.svg",
              //       press: () {},
              //     ),
              //   ],
              // ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
