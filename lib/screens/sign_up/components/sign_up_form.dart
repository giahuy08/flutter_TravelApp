import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/custom_surfix_icon.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/form_error.dart';
import 'package:flutter_travelapp/components/text_argument.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/repository/authen_repository.dart';
import 'package:flutter_travelapp/screens/otp_signup/otp_signup_screen.dart';
import 'package:flutter_travelapp/size_config.dart';

import '../../../localization/language/languages.dart';

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
          addError(error: Languages.of(context)!.kEmailExistError);
        } else {
          removeError(error: Languages.of(context)!.kEmailExistError);
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
                text: Languages.of(context)!.registerText,
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
          removeError(error: Languages.of(context)!.kPassNullError);
        }
        if (value.isNotEmpty && password.compareTo(value) == 0) {
          removeError(error: Languages.of(context)!.kMatchPassError);
        }
        confirmPassword = value;

        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Languages.of(context)!.kPassNullError);
          return "";
        } else if ((password != confirmPassword)) {
          addError(error: Languages.of(context)!.kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: Languages.of(context)!.confirmPassDesText,
        hintText: Languages.of(context)!.confirmPassFormText,
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
          removeError(error: Languages.of(context)!.kPassNullError);
        }
        if (value.isNotEmpty && value.length >= 8) {
          removeError(error: Languages.of(context)!.kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Languages.of(context)!.kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: Languages.of(context)!.kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: Languages.of(context)!.passDesc,
        hintText: Languages.of(context)!.passForm,
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
            removeError(error: Languages.of(context)!.kPhoneNumberNullError);
          }
          phone = value;
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: Languages.of(context)!.kPhoneNumberNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: Languages.of(context)!.phoneDescText,
          hintText: Languages.of(context)!.phoneFormText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField buildNameFormField() {
    return TextFormField(
        keyboardType: TextInputType.text,
        onSaved: (newValue) => name = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: Languages.of(context)!.kNamelNullError);
          }
          name = value;
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: Languages.of(context)!.kNamelNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: Languages.of(context)!.fullnameDescText,
          hintText: Languages.of(context)!.fullnameFormText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
        keyboardType: TextInputType.text,
        onSaved: (newValue) => address = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: Languages.of(context)!.kAddressNullError);
          }
          address = value;
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: Languages.of(context)!.kAddressNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: Languages.of(context)!.addressDescText,
          hintText: Languages.of(context)!.addressFormText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: Languages.of(context)!.kEmailNullError);
          } else if (emailValidatorRegExp.hasMatch(value)) {
            removeError(error: Languages.of(context)!.kInvalidEmailError);
          }
          email = value;
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: Languages.of(context)!.kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            addError(error: Languages.of(context)!.kInvalidEmailError);

            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: Languages.of(context)!.emailDesc,
          hintText: Languages.of(context)!.emailForm,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffix(
            svgIcon: "assets/icons/Mail.svg",
          ),
        ));
  }
}
