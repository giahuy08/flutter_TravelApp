import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/custom_surfix_icon.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/form_error.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/screens/otp/otp_screen.dart';

import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;
  late String confirmPassword;
  late String phone;
  late String address;

  final List<String> errors = [];
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

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildConfirmPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPhoneFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildAddressFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            FormError(errors: errors),
            DefaultButton(
                text: "Đăng ký",
                press: () {
                  // Navigator.pushNamed(context, OtpScreen.routeName);
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, OtpScreen.routeName);
                  }
                })
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
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffix(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
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
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffix(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
        keyboardType: TextInputType.number,
        onSaved: (newValue) => phone = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPhoneNumberNullError);
          }

          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPhoneNumberNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Số điện thoại",
          hintText: "Nhập số điện thoại",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
        keyboardType: TextInputType.text,
        onSaved: (newValue) => address = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }

          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kAddressNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Địa chỉ",
          hintText: "Nhập địa chỉ",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          } else if (emailValidatorRegExp.hasMatch(value)) {
            removeError(error: kInvalidEmailError);
          }
          password = value;
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            addError(error: kInvalidEmailError);

            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Email",
          hintText: "Nhập Email",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffix(
            svgIcon: "assets/icons/Mail.svg",
          ),
        ));
  }
}
