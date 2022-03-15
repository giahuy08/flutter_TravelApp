import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/social_card.dart';
import 'package:flutter_travelapp/models/userGoogle.dart';
import 'package:flutter_travelapp/repository/authen_repository.dart';
import 'package:flutter_travelapp/screens/sign_in/components/no_account.dart';
import 'package:flutter_travelapp/screens/sign_in/components/sign_form.dart';
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
  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        // print('hello');
        // // print(user.additionalUserInfo!.profile!['given_name']);
        // print(user.additionalUserInfo!.profile);

        _auth.authStateChanges().listen((user) {
          // if (user == null) {
          //   Navigator.of(context).pushReplacementNamed("start");
          // }

          AuthenRepository()
              .loginwithGoogle(
                  user!.email.toString(), user.displayName.toString())
              .then((value) => {
                    // Future.delayed(const Duration(milliseconds: 800), () {
                    //   // Here you can write your code

                    //   setState(() {
                    //     Navigator.pushNamed(
                    //         context, LoginSuccessScreen.routeName);
                    //   });
                    // })
                    print('hello'),
                    // print(value),

                    userProvider.setUser(UserModel.fromLogin(value!)),
                    // userProvider.setUser(value),
                    Navigator.pushReplacementNamed(
                        context, LoginSuccessScreen.routeName)
                    // userProvider.setUser((value))
                  });

          // user?.getIdToken().then((t) => {print(t)});
        });
        // await Navigator.pushReplacementNamed(
        //     context, LoginSuccessScreen.routeName);
        // await Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HomePage(ava),
        //   ),
        // );
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
                SignInButton(Buttons.Google,
                    text: "Sign up with Google", onPressed: googleSignIn),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
