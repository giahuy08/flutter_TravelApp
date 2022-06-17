import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:flutter_travelapp/size_config.dart';
import 'package:intl/intl.dart';

class DiscountListItem extends StatelessWidget {
  final String code;
  final int discount;
  final String endDiscount;
  final bool selected;
  final Function() onTap;

  const DiscountListItem({
    Key? key,
    required this.onTap,
    this.selected = false,
    required this.code,
    required this.discount,
    required this.endDiscount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: kLightColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/tag.svg",
              color: kPrimaryColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      code,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(14),
                          color: kTextColor,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '-' + discount.toString() + '%',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: kPrimaryColor,
                          ),
                        ),
                        Text(
                          Languages.of(context)!.endText +
                              ': ' +
                              DateFormat('yyyy-MM-dd')
                                  .format(DateTime.parse(endDiscount))
                                  .toString(),
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check,
                color: kPrimaryColor,
              )
          ],
        ),
      ),
    );
  }
}
