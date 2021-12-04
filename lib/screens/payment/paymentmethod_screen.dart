import "package:flutter/material.dart";
import 'package:flutter_travelapp/screens/success/success.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String url;

  const PaymentMethodScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Thanh toán"),
        ),
        body: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.url,
            onPageFinished: (url) {
              print("linkurl");
              print(url);
              if (url.toLowerCase().startsWith(
                  'https://fe-travelapp.vercel.app/booktour/payment'
                      .toLowerCase())) {
                // pickAddressController.disposeFormInput();
                // getSnackBar = GetSnackBar(
                //   title: 'Thanh toán thành công!',
                //   subTitle: 'Hãy theo dõi quá trình vận đơn',
                // );
                // Get.offAllNamed(Routes.ROOT);
                // getSnackBar.show();
                Navigator.pushNamed(context, Success.routeName);
              }
            }));
  }
}
