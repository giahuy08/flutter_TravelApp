import 'package:flutter/material.dart';
import 'components/body.dart';

class ListEnterpriseScreen extends StatelessWidget {
  static String routeName = "/listenterprise";
  const ListEnterpriseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Đối tác kinh doanh'),
      ),
      body: const Body(),
    );
  }
}
