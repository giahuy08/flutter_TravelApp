import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/social_card.dart';
import 'package:flutter_travelapp/screens/sign_in/components/no_account.dart';
import 'package:flutter_travelapp/screens/sign_in/components/sign_form.dart';
import 'package:flutter_travelapp/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold),
                ),
                Image.asset('assets/images/airline.png',
                    height: getProportionateScreenHeight(80)),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                const Text(
                  "Đăng nhập với email và password ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                const SignForm(),
                
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    SocialCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                const NoAccountText()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
