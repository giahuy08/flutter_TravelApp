import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/custom_surfix_icon.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/form_error.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:flutter_travelapp/repository/user_repository.dart';
import 'package:flutter_travelapp/screens/navigation_bar/bottom_nav_bar.dart';
import 'package:get/get.dart';

import '../../../size_config.dart';

class ChangeForm extends StatefulWidget {
  const ChangeForm({Key? key}) : super(key: key);

  @override
  _ChangeFormState createState() => _ChangeFormState();
}

class _ChangeFormState extends State<ChangeForm> {
  final _changeFormKey = GlobalKey<FormState>();

  late String oldPassword;
  late String newPassword;
  late String confirmNewPassword;

  final List<String> errors = [];

  void changePassword(String oldPassword, String newPassword) {
    UserRepository().changePassword(oldPassword, newPassword).then((value) {
      print(value);
      if (value != null) {
        if (value == 'Wrong PassWord Old') {
          addError(error: kChangePasswordFail);
        } else {
          removeError(error: kChangePasswordFail);
          Get.snackbar(
             Languages.of(context)!.changePasswordText,
            Languages.of(context)!.successText,
            snackPosition: SnackPosition.TOP,
            colorText: kPrimaryLightColor,
            backgroundColor: kPrimaryColor,
            duration: const Duration(
              milliseconds: 800,
            ),
          );
          Future.delayed(const Duration(milliseconds: 800), () {
            // Here you can write your code

            setState(() {
              Navigator.pushNamed(context, BottomNavBar.routeName);
            });
          });
        }
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _changeFormKey,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            buildOldPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildNewPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildConfirmNewPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            FormError(errors: errors),
            DefaultButton(
                text: Languages.of(context)!.changePasswordText,
                press: () {
                  // print(email);
                  // Navigator.pushNamed(context, OtpScreen.routeName);
                  if (_changeFormKey.currentState!.validate()) {
                    _changeFormKey.currentState!.save();
                    // Navigator.pushNamed(context, OtpScreen.routeName);
                    // register(email, password, phone, name, address);
                    //register(email, password, phone, name, address);
                    changePassword(oldPassword, newPassword);
                  }
                })
          ],
        ));
  }

  TextFormField buildConfirmNewPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmNewPassword = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.isNotEmpty && newPassword.compareTo(value) == 0) {
          removeError(error: kMatchPassError);
        }
        confirmNewPassword = value;

        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((newPassword != confirmNewPassword)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: Languages.of(context)!.reEnterNewPassTextDes,
        hintText: Languages.of(context)!.reEnterNewPassTextForm,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffix(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildNewPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => newPassword = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.isNotEmpty && value.length >= 8) {
          removeError(error: kShortPassError);
        }
        newPassword = value;
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
        labelText: Languages.of(context)!.newPasswordDes,
        hintText: Languages.of(context)!.newPasswordForm,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffix(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildOldPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => oldPassword = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.isNotEmpty && value.length >= 8) {
          removeError(error: kShortPassError);
        }
        oldPassword = value;
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
        labelText: Languages.of(context)!.oldPasswordDes,
        hintText: Languages.of(context)!.oldPasswordForm,

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffix(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
