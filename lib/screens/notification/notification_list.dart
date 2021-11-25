import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/default_appbar.dart';
import 'package:flutter_travelapp/components/default_backbutton.dart';

import '../../constants.dart';
import 'components/notification_tiles.dart';
import 'notification_page.dart';

class NotificationList extends StatefulWidget {
  static String routeName = "/notificationlist";
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const DefaultAppBar(
        title: 'Notifications',
        child: DefaultBackButton(),
      ),
      body: ListView.separated(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 12,
          itemBuilder: (context, index) {
            return NotificationTiles(
              title: 'TRAVEL',
              subtitle: 'Thanks for download TRAVEL app.',
              enable: true,
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const NotificationPage())),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          }),
    );
  }
}
