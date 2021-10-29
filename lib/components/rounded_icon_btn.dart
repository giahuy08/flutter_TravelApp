import 'package:flutter/material.dart';

class RoundedIconBtn extends StatelessWidget {
  const RoundedIconBtn({
    Key? key,
    required this.iconData,
    required this.press,
  }) : super(key: key);

  final IconData iconData;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextButton(
        onPressed: press,
        child: Icon(
          iconData,
          color: Colors.black,
        ),
        style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.only(left: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
      ),
    );
  }
}
