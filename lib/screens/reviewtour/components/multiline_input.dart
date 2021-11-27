import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/repository/review_repository.dart';
import 'package:flutter_travelapp/screens/list_booked_tours/listbooked_screen.dart';
import 'package:flutter_travelapp/screens/reviewtour/components/rounded_button.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:image_picker/image_picker.dart';

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
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void review(String idTour, String star, String comment, File? image) {
    ReviewRepository()
        .createReviewTour(idTour, star, comment, image)
        .then((value) {
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
      child: Column(
        children: [
          Stack(
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
                      primary: Colors.red,
                      backgroundColor: const Color(0xFFF5F6F9),
                    ),
                    onPressed: () => pickImage(ImageSource.gallery),
                    child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Nhận xét",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const SizedBox(width: kDefaultPadding),
              RoundedButton(
                icon: const Icon(Icons.arrow_forward),
                iconColor: Colors.white,
                bgColor: kPrimaryColor,
                tap: () {
                  review(widget.idTour, widget.star.toString(), comment, image);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
