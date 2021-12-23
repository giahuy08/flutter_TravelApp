import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_travelapp/components/custom_surfix_icon.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/form_error.dart';
import 'package:flutter_travelapp/repository/authen_repository.dart';
import 'package:flutter_travelapp/screens/sign_in/sign_in_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class OtpForm extends StatefulWidget {
  final String email;
  const OtpForm({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  late String otp = '';
  String code1 = '';
  String code2 = '';
  String code3 = '';
  String code4 = '';

  List<String> errors = [];
  late String password;
  late String confirmPassword;
  late bool hidePassword = true;
  late String emailAddress = widget.email;
  final _otpFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    otp = '';

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

  void nextField({required String value, required FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  void forgotPassword(String otp, String email, String password) async {
    await AuthenRepository().resetpassword(otp, email, password).then((value) {
      if (value != null) {
        if (value == 'OTP invalid') {
          addError(error: kOtpValidError);
        }
        if (value == 'Reset Password success') {
          removeError(error: kOtpValidError);
          Get.snackbar(
            'Otp',
            'Cập nhật mật khẩu thành công',
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
              Navigator.pushNamed(context, SignInScreen.routeName);
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _otpFormKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(60),
                  child: TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 24),
                    decoration: otpInputDecoration,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin2FocusNode);
                      code1 = value;
                      // otp = otp + value;
                    },
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(60),
                  child: TextFormField(
                    focusNode: pin2FocusNode,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 24),
                    decoration: otpInputDecoration,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin3FocusNode);
                      code2 = value;
                      // otp = otp + value;
                    },
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(60),
                  child: TextFormField(
                    focusNode: pin3FocusNode,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 24),
                    decoration: otpInputDecoration,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin4FocusNode);
                      code3 = value;
                      // otp = otp + value;
                    },
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(60),
                  child: TextFormField(
                    focusNode: pin4FocusNode,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 24),
                    decoration: otpInputDecoration,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      pin4FocusNode.unfocus();
                      code4 = value;
                      // otp = otp + value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            buildPasswordFormField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            buildConfirmPasswordFormField(),
            SizedBox(height: SizeConfig.screenHeight * 0.05),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(20)),
            DefaultButton(
              text: "Gửi",
              press: () {
                otp = code1 + code2 + code3 + code4;
                print(otp);
                if (otp.length == 4) {
                  removeError(error: kOtpError);
                  if (_otpFormKey.currentState!.validate()) {
                    _otpFormKey.currentState!.save();

                    forgotPassword(otp, emailAddress, password);
                  }
                } else {
                  addError(error: kOtpError);
                }
              },
            )
          ],
        ));
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmPassword = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.isNotEmpty && password.compareTo(value) == 0) {
          removeError(error: kMatchPassError);
        }
        confirmPassword = value;

        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != confirmPassword)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Xác nhận mật khẩu",
        hintText: "Nhập lại mật khẩu",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffix(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: hidePassword,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.isNotEmpty && value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        hintText: "Nhập mật khẩu",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: hidePassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                icon: const Icon(Icons.visibility),
              )
            : IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                icon: const Icon(Icons.visibility_off),
              ),
      ),
    );
  }
}
