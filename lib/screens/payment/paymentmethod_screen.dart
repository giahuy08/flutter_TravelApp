import "package:flutter/material.dart";
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
            initialUrl: widget.url));
  }
}
