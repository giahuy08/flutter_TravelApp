import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/models/product.dart';
import 'package:flutter_travelapp/screens/details_tour/components/product_images.dart';
import 'package:flutter_travelapp/screens/details_tour/components/top_rounded_container.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    required this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                      horizontal: getProportionateScreenWidth(20),
                      vertical: 10),
                  child: GestureDetector(
                    onTap: pressOnSeeMore,
                    child: Row(
                      children: const [
                        Text(
                          "Xem chi tiết",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600),
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
                ),
              ],
            ),
          ),
          TopRoundedContainer(
            color: const Color(0xFFF5F6F9),
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: SvgPicture.asset(
                        "assets/images/paypal.svg",
                        height: 40,
                        width: 40,
                      ),
                      title: Text(
                        "PAYPAL",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/images/vnpay_qr.png",
                        height: 40,
                        width: 40,
                      ),
                      title: Text(
                        "VNPAY",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.15,
                right: SizeConfig.screenWidth * 0.15,
                top: getProportionateScreenWidth(15),
                bottom: getProportionateScreenWidth(40)),
            child: DefaultButton(text: "Checkout", press: () {}),
          )
        ],
      ),
    );
  }
}
