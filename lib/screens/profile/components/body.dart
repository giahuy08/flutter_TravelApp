import 'package:flutter/material.dart';
import 'package:flutter_travelapp/models/user.dart';
import 'package:flutter_travelapp/providers/user_provider.dart';
import 'package:flutter_travelapp/screens/bookedtour_booking/bookedtour_home_screen.dart';
import 'package:flutter_travelapp/screens/change_password/change_password_screen.dart';
import 'package:flutter_travelapp/screens/chat/chat_screen.dart';
import 'package:flutter_travelapp/screens/custom_screen/help_screen.dart';
import 'package:flutter_travelapp/screens/custom_screen/invite_friend_screen.dart';
import 'package:flutter_travelapp/screens/profile/components/edit_profile.dart';
import 'package:flutter_travelapp/screens/splash/splash_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../constants.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Tài khoản",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const EditProfilePage()))
            },
          ),

          ProfileMenu(
            text: "Đổi mật khẩu",
            icon: "assets/icons/change-password.svg",
            press: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const ChangePasswordScreen()))
            },
          ),

          ProfileMenu(
            text: "Chăm sóc khách hàng",
            icon: "assets/icons/message.svg",
            press: () => {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ChatScreen(
                  id: userProvider.user.id,
                  name: "Travel",
                  image:
                      "https://firebasestorage.googleapis.com/v0/b/travel-app-34be2.appspot.com/o/unknown.jpg?alt=media&token=3dbbbcec-60e1-419b-89b8-cedb9d7f0514",
                ),
              ))
            },
          ),
          // ProfileMenu(
          //   text: "Chuyến đi đã đặt",
          //   icon: "assets/icons/order-history.svg",
          //   press: () => {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //             const BookedTourHomeScreen()))
          //   },
          // ),
          // ProfileMenu(
          //   text: "Chia sẻ ứng dụng",
          //   icon: "assets/icons/Conversation.svg",
          //   press: () => {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) => const InviteFriend()))
          //   },
          // ),
          // ProfileMenu(
          //   text: "Hỗ trợ khách hàng",
          //   icon: "assets/icons/Question mark.svg",
          //   press: () => {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) => const HelpScreen()))
          //   },
          // ),
          ProfileMenu(
            text: "Đăng xuất",
            icon: "assets/icons/Log out.svg",
            press: () => {signOutDrawer(context)},
          ),
        ],
      ),
    );
  }
}

void signOutGoogle() async {
  GoogleSignIn googleSignIn = GoogleSignIn();
  await googleSignIn.signOut();
}

void signOutDrawer(BuildContext context) {
  showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          color: kPrimaryColor,
          height: 150.0,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Bạn muốn đăng xuất khỏi ứng dụng?',
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                        color: kWhiteColor,
                        child: const Text(
                          'Đăng xuất',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () => {
                              userProvider.setUser(null),
                              // signOutGoogle(),
                              Navigator.pushNamed(
                                  context, SplashScreen.routeName),
                            }),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: kPrimaryColor,
                        shadowColor: kWhiteColor,
                        side: const BorderSide(color: kWhiteColor),
                      ),
                      child: const Text(
                        'Hủy',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
