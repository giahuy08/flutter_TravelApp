import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/review_ui.dart';
import 'package:flutter_travelapp/components/sticky_label.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:flutter_travelapp/models/reviewtour.dart';
import 'package:flutter_travelapp/repository/review_repository.dart';
import 'package:flutter_travelapp/screens/list_reviews/list_reviews.dart';
import 'package:intl/intl.dart';

class ReviewTour extends StatefulWidget {
  final dynamic tour;
  const ReviewTour({Key? key, required this.tour}) : super(key: key);

  @override
  _ReviewTourState createState() => _ReviewTourState();
}

class _ReviewTourState extends State<ReviewTour>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isMore = false;
  List<dynamic> _listReview = [];
  late String idTour;

  initialController() {
    _listReview = [];
  }

  @override
  void initState() {
    super.initState();
    idTour = widget.tour.id;
    getListReview();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void getListReview() async {
    List<ReviewTourModel> reviews =
        await ReviewRepository().getListReview(idTour);
    setState(() {
      _listReview.addAll(reviews);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _listReview.isNotEmpty
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StickyLabel(
                    text: Languages.of(context)!.commentText,
                    textColor: kPrimaryColor,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ListReviews(
                            reviewTour: _listReview, tour: widget.tour),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: kDefaultPadding),
                      child: StickyLabel(
                          text: Languages.of(context)!.seeMoreText,
                          textColor: kPrimaryColor),
                    ),
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ReviewUI(
                    image: _listReview[index].avatarUser,
                    name: _listReview[index].nameUser,
                    date: DateFormat('yyyy-MM-dd – kk:mm')
                        .format(_listReview[index].createdAt)
                        .toString(),
                    comment: _listReview[index].comment,
                    rating: _listReview[index].star,
                    onPressed: () => print("More Action $index"),
                    onTap: () => setState(() {
                      isMore = !isMore;
                    }),
                    isLess: isMore,
                    reviewImages: _listReview[index].imagesReview,
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 2.0,
                    color: kAccentColor,
                  );
                },
              ),
            ],
          )
        : Column(
            children: [
              Image.asset(
                "assets/images/emptyChat.png",
                width: 160,
                height: 160,
              ),
              Text(
                Languages.of(context)!.donthaveCommentText,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20.0,
                ),
              ),
            ],
          );
  }
}
