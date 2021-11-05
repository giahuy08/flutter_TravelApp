import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/screens/details_tour/components/body.dart';
import 'package:flutter_travelapp/screens/details_tour/components/custom_app_bar.dart';
import 'package:flutter_travelapp/screens/home/components/popular_product.dart';

class DetailScreen extends StatelessWidget {
  static String routeName = "/details";
  const DetailScreen({Key? key, product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Truyền data qua route
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: CustomAppBar(
        rating: arguments.tour.star,
      ),
      body: Body(
        tour: arguments.tour,
      ),
    );
  }
}
