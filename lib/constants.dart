import 'package:flutter/material.dart';
import 'package:flutter_travelapp/size_config.dart';

const kPrimaryColor = Color(0xFFF1786a);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

const kDefaultPadding = 18.0;

// Heading

final headingStyle = TextStyle(
    fontSize: getProportionateScreenWidth(28),
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.5);
// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kLoginFail = "Email or Password dont match";
const String kEmailExistError = "Email already exists";
const String kChangePasswordFail = "Mật khẩu hiện tại không trùng khớp";
<<<<<<< HEAD
const String kEditProfileFail = "Thông tin cập nhật không hợp lệ";
=======
const String kEmailDontExistError = "Email không tồn tại";
const String kOtpValidError = "Mã OTP không tồn tại";
const String kOtpError = "Điền đầy đủ OTP";


>>>>>>> 2c17403a7ea701b136b029bfd35fee70bc7e1200

final otpInputDecoration = InputDecoration(
    contentPadding:
        EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
    enabledBorder: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
    border: outlineInputBorder());

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: kTextColor));
}
