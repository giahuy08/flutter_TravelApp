import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/models/booktour.dart';
import 'package:flutter_travelapp/screens/bookedtour_booking/status_card.dart';
import 'package:flutter_travelapp/screens/reviewtour/reviewtour_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'bookedtour_app_theme.dart';

class BookedTourListView extends StatelessWidget {
  const BookedTourListView(
      {Key? key,
      this.bookedTourData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final BookTourModel? bookedTourData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "en_US");
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.network(
                                bookedTourData!.imagesTour[0],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: BookedTourAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, top: 8, bottom: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            bookedTourData!.name,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                bookedTourData!.place,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              const Icon(
                                                FontAwesomeIcons.mapMarkerAlt,
                                                size: 12,
                                                color: kPrimaryColor,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                DateFormat('yyyy-MM-dd')
                                                    .format(bookedTourData!
                                                        .startDate!)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              const Icon(
                                                FontAwesomeIcons.calendarCheck,
                                                size: 12,
                                                color: kPrimaryColor,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Row(
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        ReviewScreen.routeName,
                                                        arguments:
                                                            TourDetailsArguments(
                                                                object:
                                                                    bookedTourData!));
                                                  },
                                                  child: RatingBar(
                                                    ignoreGestures: true,
                                                    initialRating:
                                                        bookedTourData!.star!,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 24,
                                                    ratingWidget: RatingWidget(
                                                      full: const Icon(
                                                        Icons.star_rate_rounded,
                                                        color: kPrimaryColor,
                                                      ),
                                                      half: const Icon(
                                                        Icons.star_half_rounded,
                                                        color: kPrimaryColor,
                                                      ),
                                                      empty: const Icon(
                                                        Icons
                                                            .star_border_rounded,
                                                        color: kPrimaryColor,
                                                      ),
                                                    ),
                                                    itemPadding:
                                                        EdgeInsets.zero,
                                                    onRatingUpdate: (x) {},
                                                  ),
                                                ),
                                                Text(
                                                  ' ${bookedTourData!.star!.toStringAsFixed(1)} sao',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        bookedTourData!.payment! >
                                                bookedTourData!.finalpayment!
                                            ? Column(
                                                children: [
                                                  Text(
                                                    oCcy.format(bookedTourData!
                                                        .payment),
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 20,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),
                                                  Text(
                                                    oCcy.format(bookedTourData!
                                                        .finalpayment),
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                oCcy.format(bookedTourData!
                                                    .finalpayment),
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                ),
                                              ),
                                        Text(
                                          'VNĐ /tour',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.grey.withOpacity(0.8)),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            bookedTourData!.status == 0
                                                ? const StatusCard(
                                                    status: " CHỜ",
                                                    color: kPrimaryColor,
                                                    icon: Icons.access_alarm)
                                                : bookedTourData!.status == 1
                                                    ? const StatusCard(
                                                        status: " ĐÃ ĐẶT",
                                                        color: kPrimaryColor,
                                                        icon: Icons.task_alt)
                                                    : const StatusCard(
                                                        status: " HỦY",
                                                        color: kPrimaryColor,
                                                        icon: Icons
                                                            .cancel_outlined),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
