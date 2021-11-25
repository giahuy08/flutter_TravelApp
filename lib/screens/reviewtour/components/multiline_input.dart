import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/repository/review_repository.dart';
import 'package:flutter_travelapp/screens/list_booked_tours/listbooked_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';

class MultilineInput extends StatefulWidget {
  final String idTour;
  final double star;
  const MultilineInput({
    Key? key,
    required this.idTour,
    required this.star,
  }) : super(key: key);

  @override
  State<MultilineInput> createState() => _MultilineInputState();
}

class _MultilineInputState extends State<MultilineInput> {
  late String comment = "";
  void review(String idTour, String star, String comment) {
    ReviewRepository().createReviewTour(idTour, star, comment).then((value) {
      print(value);
      if (value != null) {
        if (value == 'Successfully create ReviewTour') {
          Get.snackbar(
            'Review',
            'Đăng nhận xét thành công',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.green,
            backgroundColor: kPrimaryColor,
            duration: const Duration(
              milliseconds: 800,
            ),
          );
          Future.delayed(const Duration(milliseconds: 800), () {
            // Here you can write your code
            setState(() {
              Navigator.pushNamed(context, ListBookedTourScreen.routeName);
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(0.0, 15.0),
                    color: kTextColor.withAlpha(20),
                  ),
                ]),
            child: TextField(
              onChanged: (value) {
                comment = value;
              },
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Nhận xét của bạn",
                hintStyle: TextStyle(
                  color: kSecondaryColor,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  print(widget.idTour);
                  print(widget.star.toString());
                  print(comment);
                  review(widget.idTour, widget.star.toString(), comment);
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
