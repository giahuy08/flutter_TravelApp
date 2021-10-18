import 'package:flutter/widgets.dart';
import 'package:flutter_travelapp/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter_travelapp/screens/home/home_screen.dart';
import 'package:flutter_travelapp/screens/login_success/login_success_screen.dart';
import 'package:flutter_travelapp/screens/navigation_bar/main_screen.dart';
import 'package:flutter_travelapp/screens/otp/otp_screen.dart';
import 'package:flutter_travelapp/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_travelapp/screens/sign_up/sign_up_screen.dart';
import 'package:flutter_travelapp/screens/splash/splash_screen.dart';

// All route
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  MainScreen.routeName: (context) => const MainScreen(),
};