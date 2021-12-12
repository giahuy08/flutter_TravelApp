import 'package:flutter/material.dart';
import 'package:flutter_travelapp/size_config.dart';
import 'package:sizer/sizer.dart';

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
    required this.height,
  }) : super(key: key);

  final Color color;
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: getProportionateScreenHeight(20)),
      padding: EdgeInsets.only(top: getProportionateScreenHeight(20)),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: child,
    );
  }
}
