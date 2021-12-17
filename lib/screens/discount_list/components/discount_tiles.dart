import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../constants.dart';

class DiscountTiles extends StatefulWidget {
  final String title, discount, tourname;
  final Function() onTap;
  final bool enable;
  final String image;
  const DiscountTiles({
    Key? key,
    required this.title,
    required this.discount,
    required this.tourname,
    required this.onTap,
    required this.enable,
    required this.image,
  }) : super(key: key);

  @override
  State<DiscountTiles> createState() => _DiscountTilesState();
}

class _DiscountTilesState extends State<DiscountTiles> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          height: 40.h,
          width: 40.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.image), fit: BoxFit.cover))),
      title: Text(widget.tourname, style: const TextStyle(color: kDarkColor)),
      subtitle: Text(widget.title, style: const TextStyle(color: kLightColor)),
      trailing:
          Text(widget.discount, style: const TextStyle(color: kDarkColor)),
      onTap: widget.onTap,
      enabled: widget.enable,
    );
  }
}
