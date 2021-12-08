import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class TourImages extends StatefulWidget {
  const TourImages({
    Key? key,
    required this.tour,
  }) : super(key: key);

  final dynamic tour;

  @override
  State<TourImages> createState() => _TourImagesState();
}

class _TourImagesState extends State<TourImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(350),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(widget.tour.imagesTour[selectedImage]),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.tour.imagesTour.length,
                (index) => buildSmallPreview(index))
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(15)),
        padding: EdgeInsets.all(getProportionateScreenHeight(8)),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: selectedImage == index
                    ? kPrimaryColor
                    : Colors.transparent)),
        child: Image.network(widget.tour.imagesTour[index]),
      ),
    );
  }
}
