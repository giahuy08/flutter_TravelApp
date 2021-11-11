import 'package:flutter/material.dart';
import 'package:flutter_travelapp/screens/change_password/components/body.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trở về"),
      ),
      body: const Body(),
    );
  }
}
