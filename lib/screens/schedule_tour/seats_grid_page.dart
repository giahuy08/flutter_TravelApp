import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/sub_title.dart';
import 'package:flutter_travelapp/components/text_argument.dart';
import 'package:flutter_travelapp/models/seat_model.dart';
import 'package:flutter_travelapp/repository/booktour_repository.dart';
import 'package:flutter_travelapp/screens/payment/payment.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter_travelapp/components/default_button.dart';
import 'package:flutter_travelapp/components/text_frave.dart';
import 'package:flutter_travelapp/constants.dart';

import 'package:flutter_travelapp/screens/details_tour/components/top_rounded_container.dart';
import 'package:flutter_travelapp/screens/schedule_tour/widgets/tour_discount_bottom.dart';

import '../../localization/language/languages.dart';

class SeatsGridPage extends StatefulWidget {
  const SeatsGridPage({
    Key? key,
    required this.tour,
  }) : super(key: key);

  final dynamic tour;
  @override
  _SeatsGridPageState createState() => _SeatsGridPageState();
}

class _SeatsGridPageState extends State<SeatsGridPage> {
  late int? seatSelected = 0;
  int? dateSelectedIndex = 0;
  late DateTime selectedDate = DateTime.now();
  late int seatFree = 0;
  late int seatFull = 0;
  late String discount = '';
  List<DateTime> listDateSelected = [];
  List<dynamic> listSchedules = [];
  late List<Map<String, bool>> seats = [];
  @override
  void initState() {
    super.initState();
    getSheduleOfTour();
    handleSeats();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // DateTime selectedDate = DateTime.now();
  final oCcy = NumberFormat("#,##0", "en_US");

  // void selectDate() async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialEntryMode: DatePickerEntryMode.input,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2025),
  //   );

  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  // List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  //   List<DateTime> days = [];
  //   for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
  //     days.add(startDate.add(Duration(days: i)));
  //   }
  //   return days;
  // }

  void getSheduleOfTour() async {
    listSchedules = await BookTourRepository().getSheduleOfTour(widget.tour.id);
    // setState(() {
    //   listDateSelected = getDaysInBetween(
    //       DateTime.parse(listSchedules[0]['startDate']),
    //       DateTime.parse(listSchedules[0]['endDate']));
    // });

    setState(() {
      selectedDate = DateTime.parse(listSchedules[0]['startDate']);
      seatFree = listSchedules[0]['slot'] - listSchedules[0]['booked'].length;
      seatFull = listSchedules[0]['booked'].length;
    });
    handleSeats();
  }

  void getSeatBySchedule(int slot, int booked) {
    setState(() {
      seatFree = slot - booked;
      seatFull = booked;
    });
    handleSeats();
  }

  void handleSeats() {
    print(seats.length);
    seats.clear();
    for (int i = 0; i < seatFull; i++) {
      seats.add({"available": true});
    }
    for (int i = 0; i < seatFree; i++) {
      seats.add({"available": false});
    }
    setState(() {
      seatSelected = seatFull;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Container(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 * 0.7,
                      child: Text(
                        '${widget.tour.name}',
                        maxLines: 2,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Languages.of(context)!.freeSeatText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    listSchedules != []
                        ? Text(
                            '$seatFree',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          )
                        : const Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              listSchedules != []
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listSchedules.length,
                          itemBuilder: (_, i) => _ItemDate(
                              DateTime.parse(listSchedules[i]['startDate']),
                              i,
                              listSchedules[i]['slot'],
                              listSchedules[i]['booked'].length)))
                  : const SubTitle(
                      subTitleText: 'chưa có thông tin lịch trình'),
              DelayedDisplay(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  margin: const EdgeInsets.fromLTRB(64, 16, 64, 16),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const Spacer(),
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border:
                                  Border.all(color: kPrimaryColor, width: 2),
                            ),
                          ),
                          const Spacer(flex: 2),
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border:
                                  Border.all(color: kPrimaryColor, width: 2),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          border: Border.all(color: kPrimaryColor, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            children: seats
                                .asMap()
                                .map((index, element) {
                                  return MapEntry(
                                    index,
                                    Container(
                                      margin: const EdgeInsets.all(16),
                                      child: Image.asset(
                                        seatSelected == index
                                            ? 'assets/images/seats/seat_3.png'
                                            : element["available"]!
                                                ? 'assets/images/seats/seat_3_2.png'
                                                : 'assets/images/seats/seat_2.png',
                                        width: 28,
                                      ),
                                    ),
                                  );
                                })
                                .values
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/seats/seat_2.png',
                      width: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      Languages.of(context)!.freeText,
                      style: TextStyle(
                        color: kLightColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Image.asset(
                      'assets/images/seats/seat_3_2.png',
                      width: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      Languages.of(context)!.bookedText,
                      style: TextStyle(
                        color: kLightColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Image.asset(
                      'assets/images/seats/seat_3.png',
                      width: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      Languages.of(context)!.bookedSeatText,
                      style: TextStyle(
                        color: kLightColor,
                      ),
                    ),
                  ],
                ),
              ),
              DelayedDisplay(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return kLightColor;
                          return kPrimaryColor;
                        },
                      ),
                    ),
                    child: Column(
                      children: [
                        TopRoundedContainer(
                          color: Colors.white,
                          height: 45.h,
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Column(
                              children: [
                                // ElevatedButton.icon(
                                //   onPressed: selectDate,
                                //   icon: const Icon(Icons
                                //       .date_range), //icon data for elevated button
                                //   label: const Text(
                                //       "Chọn ngày khởi hành"), //label text
                                //   style: ElevatedButton.styleFrom(
                                //       primary:
                                //           kPrimaryColor //elevated btton background color
                                //       ),
                                // ),
                                Text(
                                  "${selectedDate.toLocal()}".split(' ')[0],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: buildCodeFormField(),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(oCcy.format(widget.tour.payment),
                                              style: const TextStyle(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          const Text(
                                            'VNĐ',
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                          height: 55,
                                          width: 150,
                                          child: DefaultButton(
                                            text: Languages.of(context)!
                                                .bookNowText,
                                            press: () => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        Payment(
                                                            id: widget.tour.id,
                                                            codediscount:
                                                                discount,
                                                            date:
                                                                selectedDate))),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                          child: Text(
                            Languages.of(context)!.goToPaymentText,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildCodeFormField() {
    return TextFormField(
        style: const TextStyle(fontSize: 15),
        textCapitalization: TextCapitalization.characters,
        keyboardType: TextInputType.text,
        controller: TextEditingController(text: discount),
        decoration: InputDecoration(
            hintText:Languages.of(context)!.discountText ,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: IconButton(
              onPressed: () {
                print(widget.tour.id);
                _settingModalBottomSheet(context, widget.tour.id);
              },
              icon: const Icon(Icons.wallet_giftcard),
              color: kPrimaryColor,
            )));
  }

  _settingModalBottomSheet(context, idTour) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return TourDiscountBottom(idTour: idTour);
        }).then((value) => setState(() {
          discount = value;
        }));
  }

  Widget _ItemDate(DateTime date, int index, int slot, int booked) {
    return InkWell(
      onTap: () => {
        setState(() => {
              selectedDate = date,
              dateSelectedIndex = index,
              print(selectedDate),
              getSeatBySchedule(slot, booked)
            })
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child:
            // BlocBuilder<CinemaBloc, CinemaState>(
            //   builder: (context, state) =>
            Container(
          height: 100,
          width: 84,
          decoration: BoxDecoration(
              color:
                  dateSelectedIndex == index ? kPrimaryColor : kSecondaryColor,
              borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle,
                  color: const Color(0xff21242C).withOpacity(.8), size: 10),
              const SizedBox(height: 10.0),
              TextFrave(
                  text: DateFormat('EEEE')
                      .format(date)
                      .toString()
                      .substring(0, 3),
                  color: Colors.white,
                  fontSize: 8),
              Text(
                DateFormat("yyyy-MM-dd").format(date).toString(),
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
              const SizedBox(height: 5.0),
              // TextFrave(text: date.number, color: Colors.white, fontSize: 30),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
