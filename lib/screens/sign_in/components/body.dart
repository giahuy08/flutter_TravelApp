import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travelapp/components/social_card.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/models/userGoogle.dart';
import 'package:flutter_travelapp/repository/authen_repository.dart';
import 'package:flutter_travelapp/screens/sign_in/components/no_account.dart';
import 'package:flutter_travelapp/screens/sign_in/components/sign_form.dart';
import 'package:flutter_travelapp/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_travelapp/size_config.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_travelapp/providers/user_provider.dart';
import '../../login_success/login_success_screen.dart';
import 'package:flutter_travelapp/models/user.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String token;
  final FacebookLogin facebookSignIn = new FacebookLogin();

  // Future fbSignIn() async {
  //   // facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;
  //   final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final FacebookAccessToken accessToken = result.accessToken;
  //       final snackbar =
  //           SnackBar(content: Text("Đăng nhập bằng Facebook thành công!"));
  //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (builder) => const SignInScreen()),
  //           (route) => false);
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       final snackbar = SnackBar(content: Text("Yêu cầu đã được hủy!"));
  //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //       break;
  //     case FacebookLoginStatus.error:
  //       final snackbar = SnackBar(content: Text("Không thể đăng nhập!"));
  //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //       break;
  //   }
  // }

  Future<UserCredential> googleSignIn() async {
    //  await FirebaseAuth.instance.signOut();

    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final googleUser = GoogleSignIn().currentUser ??
        await GoogleSignIn(
          scopes: [
            'email',
            'https://www.googleapis.com/auth/userinfo.profile',
          ],
        ).signIn();

    if (GoogleSignIn().currentUser != null) {
      await _auth.signOut();
    }
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        _auth.authStateChanges().listen((user) {
          // if (user == null) {
          //   Navigator.of(context).pushReplacementNamed("start");
          // }

          AuthenRepository()
              .loginwithGoogle(
                  user!.email.toString(), user.displayName.toString())
              .then((value) => {
                    userProvider.setUser(UserModel.fromLogin(value!)),
                    Navigator.pushReplacementNamed(
                        context, LoginSuccessScreen.routeName)
                  });

          // user?.getIdToken().then((t) => {print(t)});
        });

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Text(
                  "Xin Chào!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold),
                ),
                Image.asset('assets/images/airline.png',
                    height: getProportionateScreenHeight(80)),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                const Text(
                  "Đăng nhập với email và mật khẩu của bạn ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                const SignForm(),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                const NoAccountText(),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                const Text('Hoặc tiếp tục với'),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                InkWell(
                  onTap: googleSignIn,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 60,
                    child: Card(
                      color: const Color(0xFFF5F6F9),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/google-icon.svg',
                            height: 26,
                            width: 26,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Đăng nhập với Google',
                            style: TextStyle(color: kTextColor, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SocialCard(
                //         icon: 'assets/icons/google-icon.svg',
                //         press: googleSignIn),
                //     SocialCard(
                //         icon: 'assets/icons/facebook-2.svg', press: fbSignIn),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
