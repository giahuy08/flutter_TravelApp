import 'package:flutter/material.dart';

class Product {
  final int id;
  final String idEnterprise;
  final String idVehicle;
  final String name, detail;
  final String place;
  final List<String> imagesTour;
  final List<Color> colors;
  final double rating, payment;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    this.idEnterprise = "",
    this.idVehicle = "",
    required this.imagesTour,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.name,
    required this.place,
    required this.payment,
    required this.detail,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    imagesTour: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    name: "Du Lịch Nha Trang, Đà Lạt",
    place: "Nha Trang, Đà Lạt",
    payment: 64.99,
    detail: detail,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    imagesTour: [
      "assets/images/Image Popular Product 2.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    name: "Du lịch Vũng Tàu, Mũi Né",
    place: "Vũng Tàu, Mũi Né",
    payment: 50.5,
    detail: detail,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: 3,
    imagesTour: [
      "assets/images/glap.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    name: "Du lịch Vịnh Hạ Long",
    place: "Quảng Ninh",
    payment: 36.55,
    detail: detail,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    imagesTour: [
      "assets/images/wireless headset.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    name: "Du lịch Phố Cổ Hội An",
    place: "Hội An",
    payment: 20.20,
    detail: detail,
    rating: 4.1,
    isFavourite: true,
  ),
];

const String detail =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";


