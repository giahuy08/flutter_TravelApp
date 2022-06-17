import 'package:flutter/material.dart';
import 'package:flutter_travelapp/size_config.dart';

const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kDarkColor = Color(0xFF303030);
const kAccentColor = Color(0xFFF1F1F1);
const kPrimaryColor = Color(0xFFF1786A);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kFixPadding = 16.0;
const kRadius = 0.0;

const kAnimationDuration = Duration(milliseconds: 200);
const kLessPadding = 10.0;
const kDefaultPadding = 18.0;

const kDarkTextStyle = TextStyle(
  fontSize: 20.0,
  color: kDarkColor,
);
const kSubTextStyle = TextStyle(
  fontSize: 18.0,
  color: kLightColor,
);
const kSmallDivider = Divider(
  color: kAccentColor,
  thickness: 5.0,
);
final paymentLabels = [
  'Cash',
  'PayPal',
  'VNPay',
];

final paymentIcons = [
  'assets/images/tour.png',
  'assets/images/paypal.png',
  'assets/images/vnpay.png',
];

// Assets
const String logo = 'assets/images/airline.png';
const String success = 'assets/images/success.gif';
// Heading

final headingStyle = TextStyle(
    fontSize: getProportionateScreenWidth(28),
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.5);
// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Vui lòng nhập email";
const String kInvalidEmailError = "Email không hợp lệ";
const String kPassNullError = "Vui lòng nhập mật khẩu";
const String kShortPassError = "Mật khẩu quá ngắn";
const String kMatchPassError = "Mật khẩu không khớp";
const String kNamelNullError = "Vui lòng nhập tên";
const String kPhoneNumberNullError = "Vui lòng nhập số điện thoại";
const String kAddressNullError = "Vui lòng nhập địa chỉ";
const String kLoginFail = "Email hoặc mật khẩu không hợp lệ";
const String kEmailExistError = "Email đã tồn tại";
const String kChangePasswordFail = "Mật khẩu hiện tại không trùng khớp";
const String kEditProfileFail = "Thông tin cập nhật không hợp lệ";
const String kEmailDontExistError = "Email không tồn tại";
const String kOtpValidError = "Mã OTP không tồn tại";
const String kOtpError = "Điền đầy đủ OTP";

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
