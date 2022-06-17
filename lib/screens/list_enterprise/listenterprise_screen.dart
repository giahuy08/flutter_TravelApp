import 'package:flutter/material.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'components/body.dart';

class ListEnterpriseScreen extends StatelessWidget {
  static String routeName = "/listenterprise";
  const ListEnterpriseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(Languages.of(context)!.partnerText),
      ),
      body: const Body(),
    );
  }
}
