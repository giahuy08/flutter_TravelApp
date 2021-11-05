import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/custom_surfix_icon.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/form_error.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/models/user.dart';
import 'package:flutter_travelapp/repository/authen_repository.dart';
import 'package:flutter_travelapp/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter_travelapp/screens/listtours/listtours_screen.dart';
import 'package:flutter_travelapp/screens/login_success/login_success_screen.dart';
import 'package:get/get.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;
  final List<String> errors = [];
  void signIn(String email, String pass) async {
    // SharedPreferences sharedReferences = await SharedPreferences.getInstance();
    // Map data = {'email': email, 'password': pass};
    // dynamic jsonResponse;

    // var response = await http
    //     .post(Uri.parse("http://192.168.1.12:3000/user/login"), body: data);
    // if (response.statusCode == 200) {
    //   jsonResponse = json.decode(response.body);
    // }

    // if (jsonResponse != null) {
    //   sharedReferences.setString("token", jsonResponse['data']['token']);
    //   Navigator.pushNamed(context, LoginSuccessScreen.routeName);
    // } else {
    //   // ignore: avoid_print
    //   print(response.body);
    // }

    AuthenRepository().login(email, pass).then((value) {
      if (value != null) {
        removeError(error: kLoginFail);
        Get.snackbar(
          'Login',
          'Đăng nhập thành công',
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
            Navigator.pushNamed(context, LoginSuccessScreen.routeName);
          });
        });

        print(User.fromLogin(value));
      } else {
        addError(error: kLoginFail);
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
        key: _formKey,
        child: Column(children: [
          buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Row(
            children: [
              Checkbox(
                  activeColor: kPrimaryColor,
                  value: remember,
                  onChanged: (value) {
                    setState(() {
                      remember = value!;
                    });
                  }),
              const Text("Remmber me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          DefaultButton(
              text: "Đăng nhập",
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  signIn(email, password);
                }
              })
        ]));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        obscureText: true,
        onSaved: (newValue) => password = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.length >= 8) {
            removeError(error: kShortPassError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPassNullError);
            // print(kPassNullError);
            return "";
          } else if (value.length < 8) {
            addError(error: kShortPassError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Password",
          hintText: "Nhập Password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffix(
            svgIcon: "assets/icons/Lock.svg",
          ),
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
