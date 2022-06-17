import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import 'app_theme.dart';

class FeedbackScreen extends StatefulWidget {
  static String routeName = "/feedback";
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                        left: 16,
                        right: 16),
                    child: Image.asset('assets/images/feedbackImage.png'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'Phản hồi của bạn',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: const Text(
                      'Hãy cho chúng tôi những nhận xét để cải thiện',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  _buildComposer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Center(
                      child: SizedBox(
                        width: 50.w,
                        height: 6.h,
                        child: DefaultButton(
                          text: Languages.of(context)!.sendText,
                          press: () {},
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComposer() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                offset: const Offset(0.0, 15.0),
                color: kTextColor.withAlpha(20),
              ),
            ]),
        child: TextField(
          onChanged: (value) {},
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          maxLines: 2,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Nhận xét của bạn",
            hintStyle: TextStyle(
              color: kSecondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
