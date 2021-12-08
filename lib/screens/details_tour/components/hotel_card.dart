import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({
    Key? key,
    this.width = 250,
    this.height = 240,
    this.aspectRetio = 2,
    required this.product,
    required this.press,
  }) : super(key: key);

  final double width, height, aspectRetio;
  final dynamic product;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(200),
          height: getProportionateScreenWidth(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: aspectRetio,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(
                    product.imagesTour[0],
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
