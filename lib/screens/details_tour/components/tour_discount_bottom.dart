import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/screens/details_tour/components/discount_list.dart';
import 'package:sizer/sizer.dart';

class TourDiscountBottom extends StatefulWidget {
  const TourDiscountBottom({Key? key, required this.idTour}) : super(key: key);
  final String idTour;

  @override
  State<TourDiscountBottom> createState() => _TourDiscountBottomState();
}

class _TourDiscountBottomState extends State<TourDiscountBottom> {
  void close(context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, discount);
    }
  }

  late String discount = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(28.0),
        child: Wrap(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 10.h,
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    child: const Icon(
                      Icons.highlight_off,
                      color: kPrimaryColor,
                    ),
                    onTap: () {
                      close(context);
                    },
                  ),
                ),
                const Text(
                  'Chọn mã giảm giá',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: kPrimaryColor),
                ),
              ],
            ),
            DiscountList(
              onSelect: (selected) => discount = selected,
              idTour: widget.idTour,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: DefaultButton(
                text: 'Chọn mã',
                press: () {
                  close(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
