import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelapp/models/product.dart';
import 'package:flutter_travelapp/screens/details_tour/components/product_images.dart';
import 'package:flutter_travelapp/screens/details_tour/components/top_rounded_container.dart';

import '../../../constants.dart';
import '../../../size_config.dart';


class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product, required this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    product.name,
                    style: Theme.of(context).textTheme.headline6,
                  )),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 64,
                  decoration: BoxDecoration(
                      color: product.isFavourite
                          ? const Color(0xFFFFE6E6)
                          : const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(50)),
                  child: SvgPicture.asset(
                    "assets/icons/Heart Icon_2.svg",
                    color: product.isFavourite
                        ? const Color(0xFFFF4848)
                        : const Color(0xFFDBDEE4),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(20),
                    right: getProportionateScreenWidth(64)),
                child: Text(
                  product.detail,
                  maxLines: 3,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20), vertical: 10),
                child: GestureDetector(
                  onTap: pressOnSeeMore,
                  child: Row(
                    children: const [
                      Text(
                        "Xem chi tiết",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: kPrimaryColor,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
