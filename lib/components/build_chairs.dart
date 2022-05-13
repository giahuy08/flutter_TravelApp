import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';

class BuildChairs {
  static Widget selectedChair() {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(6.0)),
    );
  }

  static Widget availableChair() {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
          border: Border.all(color: kLightColor),
          borderRadius: BorderRadius.circular(6.0)),
    );
  }

  static Widget reservedChair() {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
          color: kLightColor, borderRadius: BorderRadius.circular(6.0)),
    );
  }
}
