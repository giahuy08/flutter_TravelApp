import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/custom_surfix_icon.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/form_error.dart';
import 'package:flutter_travelapp/components/text_argument.dart';
import 'package:flutter_travelapp/repository/authen_repository.dart';
import 'package:flutter_travelapp/screens/otp/otp_screen.dart';
import 'package:flutter_travelapp/screens/sign_in/components/no_account.dart';

import '../../../constants.dart';
import '../../../localization/language/languages.dart';
import '../../../size_config.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key? key}) : super(key: key);

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _forgotFormKey = GlobalKey<FormState>();
  List<String> errors = [];
  late String email = '';
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void forgotPassword(String email) async {
    await AuthenRepository().forgotpassword(email).then((value) {
      if (value != null) {
        if (value == 'Do not email') {
          addError(error: Languages.of(context)!.kEmailDontExistError);
        }
        if (value == 'Send Email Success') {
          removeError(error: Languages.of(context)!.kEmailDontExistError);
          // Get.snackbar(
          //   'Login',
          //   'Đăng ký thành công',
          //   snackPosition: SnackPosition.TOP,
          //   colorText: Colors.green,
          //   backgroundColor: kPrimaryColor,
          //   duration: const Duration(
          //     milliseconds: 800,
          //   ),
          // );

          Navigator.pushNamed(context, OtpScreen.routeName,
              arguments: TextArguments(text: email));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _forgotFormKey,
      child: Column(
        children: [
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) => email = newValue!,
              onChanged: (value) {
                if (value.isNotEmpty && errors.contains(Languages.of(context)!.kEmailNullError)) {
                  setState(() {
                    errors.remove(Languages.of(context)!.kEmailNullError);
                  });
                } else if (emailValidatorRegExp.hasMatch(value) &&
                    errors.contains(Languages.of(context)!.kInvalidEmailError)) {
                  setState(() {
                    errors.remove(Languages.of(context)!.kInvalidEmailError);
                  });
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty && !errors.contains(Languages.of(context)!.kEmailNullError)) {
                  setState(() {
                    errors.add(Languages.of(context)!.kEmailNullError);
                  });
                }
                if (!emailValidatorRegExp.hasMatch(value) &&
                    !errors.contains(Languages.of(context)!.kInvalidEmailError)) {
                  setState(() {
                    errors.add(Languages.of(context)!.kInvalidEmailError);
                  });
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: Languages.of(context)!.emailDesc,
                hintText: Languages.of(context)!.addressFormText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: const CustomSurffix(
                  svgIcon: "assets/icons/Mail.svg",
                ),
              )),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
              text: Languages.of(context)!.sendText,
              press: () {
                if (_forgotFormKey.currentState!.validate()) {
                  // Navigator.pushNamed(context, OtpScreen.routeName);
                  _forgotFormKey.currentState!.save();
                  if (email != '') {
                    forgotPassword(email);
                  }
                }
              }),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          const NoAccountText()
        ],
      ),
    );
  }
}
