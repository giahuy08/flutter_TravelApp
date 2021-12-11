import 'package:flutter/widgets.dart';
import 'package:flutter_travelapp/screens/bookedtour_booking/bookedtour_home_screen.dart';
import 'package:flutter_travelapp/screens/details_tour/details_screen.dart';
import 'package:flutter_travelapp/screens/discount_list/discount_list.dart';
import 'package:flutter_travelapp/screens/error/error_screen.dart';
import 'package:flutter_travelapp/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter_travelapp/screens/google_map/google_map_screen.dart';
import 'package:flutter_travelapp/screens/home/home_screen.dart';
import 'package:flutter_travelapp/screens/list_enterprise/listenterprise_screen.dart';
import 'package:flutter_travelapp/screens/list_vehicle/cars_overview.dart';
import 'package:flutter_travelapp/screens/listtours/listtours_screen.dart';
import 'package:flutter_travelapp/screens/login_success/login_success_screen.dart';
import 'package:flutter_travelapp/screens/navigation_bar/main_screen.dart';
import 'package:flutter_travelapp/screens/notification/notification_list.dart';
import 'package:flutter_travelapp/screens/notification/notification_page.dart';
import 'package:flutter_travelapp/screens/otp/otp_screen.dart';
import 'package:flutter_travelapp/screens/profile/profile_screen.dart';
import 'package:flutter_travelapp/screens/reviewtour/reviewtour_screen.dart';
import 'package:flutter_travelapp/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_travelapp/screens/sign_up/sign_up_screen.dart';
import 'package:flutter_travelapp/screens/splash/splash_screen.dart';
import 'package:flutter_travelapp/screens/success/success.dart';

// All route
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  ReviewScreen.routeName: (context) => const ReviewScreen(),
  MainScreen.routeName: (context) => const MainScreen(),
  DetailScreen.routeName: (context) => const DetailScreen(),
  ListToursScreen.routeName: (context) => const ListToursScreen(),
  ErrorScreen.routeName: (context) => const ErrorScreen(),
  NotificationList.routeName: (context) => const NotificationList(),
  NotificationPage.routeName: (context) => const NotificationPage(),
  DiscountList.routeName: (context) => const DiscountList(),
  Success.routeName: (context) => const Success(),
  BookedTourHomeScreen.routeName: (context) => const BookedTourHomeScreen(),
  ListEnterpriseScreen.routeName: (context) => const ListEnterpriseScreen(),
  CarsOverviewScreen.routeName: (context) => const CarsOverviewScreen(),
  // PaymentMethodScreen.routeName: (context) => const PaymentMethodScreen(),
  MapSample.routeName: (context) => const MapSample(),
};
