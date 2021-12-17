import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/custom_surfix_icon.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/form_error.dart';
import 'package:flutter_travelapp/components/text_argument.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/repository/authen_repository.dart';
import 'package:flutter_travelapp/screens/otp_signup/otp_signup_screen.dart';
import 'package:flutter_travelapp/screens/sign_in/sign_in_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';

import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignUpForm> {
  final _signUpFormKey = GlobalKey<FormState>();

  late String email;
  late String password;
  late String confirmPassword;
  late String phone;
  late String address;
  late String name;
  late bool hidePassword = true;

  final List<String> errors = [];

  void register(String email, String password, String phone, String name,
      String address) {
    AuthenRepository()
        .register(email, password, phone, name, address)
        .then((value) {
      print(value);
      if (value != null) {
        if (value == 'Email already exists') {
          addError(error: kEmailExistError);
        } else {
          removeError(error: kEmailExistError);
          Navigator.pushNamed(context, OtpSignUpScreen.routeName,
              arguments: TextArguments(text: email));
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
          // Future.delayed(const Duration(milliseconds: 800), () {
          //   // Here you can write your code

          //   setState(() {
          //      Navigator.pushNamed(context, OtpSignUpScreen.routeName,
          //             arguments: TextArguments(text: email));
          //   });
          // });
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
        key: _signUpFormKey,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildNameFormField(),
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
            SizedBox(height: getProportionateScreenHeight(10)),
            DefaultButton(
                text: "Đăng ký",
                press: () {
                  // print(email);

                  if (_signUpFormKey.currentState!.validate()) {
                    _signUpFormKey.currentState!.save();
                    // Navigator.pushNamed(context, OtpScreen.routeName);
                    // register(email, password, phone, name, address);
                    register(email, password, phone, name, address);
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

  TextFormField buildPhoneFormField() {
    return TextFormField(
        keyboardType: TextInputType.number,
        onSaved: (newValue) => phone = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPhoneNumberNullError);
          }
          phone = value;
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

  TextFormField buildNameFormField() {
    return TextFormField(
        keyboardType: TextInputType.text,
        onSaved: (newValue) => name = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kNamelNullError);
          }
          name = value;
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kNamelNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Họ và tên",
          hintText: "Nhập họ và tên người dùng",
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
          address = value;
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
          email = value;
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
