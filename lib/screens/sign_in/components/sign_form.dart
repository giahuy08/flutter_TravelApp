import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/form_error.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/models/user.dart';
import 'package:flutter_travelapp/providers/user_provider.dart';
import 'package:flutter_travelapp/repository/authen_repository.dart';
import 'package:flutter_travelapp/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter_travelapp/screens/login_success/login_success_screen.dart';
import 'package:get/get.dart';
import '../../../localization/language/languages.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _signFormKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;
  late bool hidePassword = true;
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
        removeError(error: Languages.of(context)!.kLoginFail);
        Get.snackbar(
          'Login',
          Languages.of(context)!.successText,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: kPrimaryColor,
          duration: const Duration(
            milliseconds: 800,
          ),
        );
        userProvider.setUser(UserModel.fromLogin(value));
        Future.delayed(const Duration(milliseconds: 800), () {
          // Here you can write your code

          setState(() {
            Navigator.pushNamed(context, LoginSuccessScreen.routeName);
          });
        });

        print(UserModel.fromLogin(value));
      } else {
        addError(error: Languages.of(context)!.kLoginFail);
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
        key: _signFormKey,
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
              Text(Languages.of(context)!.saveInfo),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  Languages.of(context)!.forgotPassText,
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
              text: Languages.of(context)!.loginText,
              press: () {
                if (_signFormKey.currentState!.validate()) {
                  _signFormKey.currentState!.save();

                  signIn(email, password);
                }
              })
        ]));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: hidePassword,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Languages.of(context)!.kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: Languages.of(context)!.kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Languages.of(context)!.kPassNullError);
          // print(kPassNullError);
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
            suffixIcon: Icon(Icons.mail_outline_outlined)));
  }
}
