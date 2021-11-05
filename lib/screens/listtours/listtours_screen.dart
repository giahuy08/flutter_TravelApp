import 'package:flutter/material.dart';
import 'package:flutter_travelapp/screens/listtours/components/body.dart';

class ListToursScreen extends StatelessWidget {
  static String routeName = "/listtours";
  const ListToursScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách tour'),
      ),
      body: const Body(),
    );
  }
}
