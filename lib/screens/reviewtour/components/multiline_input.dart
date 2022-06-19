import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/repository/review_repository.dart';
import 'package:flutter_travelapp/screens/bookedtour_booking/bookedtour_home_screen.dart';
import 'package:flutter_travelapp/screens/reviewtour/components/rounded_button.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../localization/language/languages.dart';

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
    print(idTour);
    print(star);
    print(comment);
    print(image);

    ReviewRepository()
        .createReviewTour(idTour, star, comment, image)
        .then((value) {
      print(value);
      if (value != null) {
        if (value == 'Successfully create ReviewTour') {
          Get.snackbar(
            'Review',
            Languages.of(context)!.successText,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: kPrimaryColor,
            duration: const Duration(
              milliseconds: 800,
            ),
          );
          Future.delayed(const Duration(milliseconds: 800), () {
            // Here you can write your code
            setState(() {
              Navigator.pushNamed(context, BookedTourHomeScreen.routeName);
            });
          });
        }

        if (value == 'Duplicate review tour') {
          Get.snackbar(
            'Review',
            Languages.of(context)!.duplicateReviewText,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: kPrimaryColor,
            duration: const Duration(
              milliseconds: 800,
            ),
          );
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: Languages.of(context)!.commentText,
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
                  height: 5.h,
                  width: 10.w,
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
          image != null
              ? Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover, image: FileImage(image!))),
                )
              : Container(
                  width: 10,
                  height: 10,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                Languages.of(context)!.commentText,
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
