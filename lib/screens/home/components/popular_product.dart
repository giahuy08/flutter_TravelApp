import 'package:flutter/material.dart';

import 'package:flutter_travelapp/components/product_card.dart';
import 'package:flutter_travelapp/models/product.dart';
import 'package:flutter_travelapp/screens/details_tour/details_screen.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Phổ biến nhất", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {
                  if (demoProducts[index].isPopular) {
                    return ProductCard(
                      product: demoProducts[index],
                      press: () => Navigator.pushNamed(
                          context, DetailScreen.routeName,
                          arguments: ProductDetailsArguments(
                              product: demoProducts[index])),
                    );
                  }
                  return const SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}

class ProductDetailsArguments {
   final Product product;

  ProductDetailsArguments({required this.product});
}

