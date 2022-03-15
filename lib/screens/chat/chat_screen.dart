import 'package:flutter/material.dart';
import '../chat/components/body.dart';
class ChatScreen extends StatelessWidget {
  static String routeName = "/chat";
  const ChatScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
 return Scaffold(
      appBar: AppBar(
        title: const Text("Đổi mật khẩu"),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}