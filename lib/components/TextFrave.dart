import 'package:flutter/material.dart';
import 'package:flutter_travelapp/size_config.dart';

class TextFrave extends StatelessWidget{

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextOverflow textOverflow;
  final int maxLines;
  final TextAlign textAlign;

  const TextFrave({
      required this.text,
      this.fontSize = 18,
      this.fontWeight = FontWeight.normal,
      this.color = Colors.black,
      this.textOverflow = TextOverflow.visible,
      this.maxLines = 1,
      this.textAlign = TextAlign.left
  });

  @override
  Widget build(BuildContext context) {
    
    return Text(
      text,
      style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
     );
  }
}