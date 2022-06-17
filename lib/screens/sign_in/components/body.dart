import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/google_btn.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/repository/authen_repository.dart';
import 'package:flutter_travelapp/screens/sign_in/components/no_account.dart';
import 'package:flutter_travelapp/screens/sign_in/components/sign_form.dart';
import 'package:flutter_travelapp/size_config.dart';
import 'package:fswitch/fswitch.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_travelapp/providers/user_provider.dart';
import '../../../localization/language/languages.dart';
import '../../../localization/locale_constant.dart';
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

  bool status = false;
  @override
  Widget build(BuildContext context) => SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: FSwitch(
                        width: 65.0,
                        openColor: kPrimaryColor,
                        height: 35.538,
                        open: status,
                        onChanged: (v) {
                          status = v;

                          if (status == true) {
                            changeLanguage(context, "en");
                          } else {
                            changeLanguage(context, "vi");
                          }
                        },
                        closeChild: const Text(
                          "VN",
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                        openChild: const Text(
                          "ENG",
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    Languages.of(context)!.appName,
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
                  Text(
                    Languages.of(context)!.loginWarn,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.08,
                  ),
                  const SignForm(),
                  const NoAccountText(),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Text(
                    Languages.of(context)!.orContinueText,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  GoogleBtn(onPressed: googleSignIn)
                ],
              ),
            ),
          ),
        ),
      );
}
