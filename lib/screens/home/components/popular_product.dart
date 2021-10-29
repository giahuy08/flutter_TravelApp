import 'package:flutter/material.dart';

import 'package:flutter_travelapp/components/product_card.dart';
import 'package:flutter_travelapp/models/product.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  String title = '';

  @override
  void initState() {
    super.initState();
    getListTour();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getListTour() async {
    List<TourModel> tours = await TourRepository().getListTour();
    tours.forEach((element) {
      setState(() {
        title = element.name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: title, press: () {}),
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
                    return ProductCard(product: demoProducts[index]);
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
