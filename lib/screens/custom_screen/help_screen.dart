import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:sizer/sizer.dart';
import 'app_theme.dart';

class HelpScreen extends StatefulWidget {
  static String routeName = "/help";
  const HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  get kPrimaryColor => null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: kPrimaryColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        color: AppTheme.nearlyWhite,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: AppTheme.nearlyWhite,
            body: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: 16,
                      right: 16),
                  child: Image.asset('assets/images/helpImage.png'),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: const Text(
                    'Chúng tôi có thể giúp gì cho bạn?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: const Text(
                    'Nếu bạn gặp bất kỳ vấn đề gì\ntrong quá trình tãi nghiệm. Chúng tôi luôn sẵn lòng hỗ trợ bạn\nhãy liên hệ với chúng tôi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        width: 50.w,
                        height: 6.h,
                        child: DefaultButton(
                          text: "Liên hệ",
                          press: () {},
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
