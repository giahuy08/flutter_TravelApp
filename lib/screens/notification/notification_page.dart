import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/default_appbar.dart';
import 'package:flutter_travelapp/components/default_backbutton.dart';
import '../../constants.dart';

class NotificationPage extends StatefulWidget {
  static String routeName = "/notificationpage";
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: 'Thông báo',
        child: DefaultBackButton(),
      ),
      body: FittedBox(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(kFixPadding),
          padding: const EdgeInsets.all(kFixPadding),
          decoration: BoxDecoration(
              color: kWhiteColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(color: kLightColor, blurRadius: 2.0)
              ]),
          child: Column(
            children: const [
              Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  style: kDarkTextStyle),
              SizedBox(height: 16.0),
              Image(image: AssetImage(logo)),
              SizedBox(height: 16.0),
              Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                  style: TextStyle(color: kLightColor)),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: Text('11/Feb/2021 04:42 PM',
                    style: TextStyle(color: kLightColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
