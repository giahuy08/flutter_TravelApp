import 'package:flutter/material.dart';
import 'package:flutter_travelapp/models/product.dart';
import 'package:flutter_travelapp/screens/details_tour/components/product_description.dart';

class Body extends StatelessWidget {
  final Product product;
  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductDescription(product: product, pressOnSeeMore: () {  },);
  }
}
