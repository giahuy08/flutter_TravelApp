import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/screens/schedule_tour/seats_grid_page.dart';
import 'package:flutter_travelapp/screens/schedule_tour/widgets/flight_provider.dart';
import 'package:delayed_display/delayed_display.dart';

class ListFlights extends StatefulWidget {
  const ListFlights({Key? key}) : super(key: key);

  @override
  _ListFlightsState createState() => _ListFlightsState();
}

class _ListFlightsState extends State<ListFlights>
    with TickerProviderStateMixin {
  PageController _cardController = PageController(initialPage: 0);
  List<int> passengers = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ];
  int currentPassengers = 1;
  int currentIndex = 0;

  @override
  dispose() {
    super.dispose();
    _cardController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: flightsAvailable.length,
      itemBuilder: (context, index) {
        return DelayedDisplay(
          child: GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            child: AnimatedContainer(
              height: currentIndex == index ? 134 : 66,
              duration: Duration(milliseconds: 200),
              margin: EdgeInsets.fromLTRB(
                  16, 0, 16, index == flightsAvailable.length - 1 ? 80 : 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 4,
                  )
                ],
              ),
              child: PageView(
                controller: _cardController,
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            flightsAvailable[index].logo!,
                            width: 64,
                          ),
                          SizedBox(width: 16),
                          Container(
                            color: kLightColor,
                            height: 32,
                            width: 1,
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select',
                                style: TextStyle(
                                  color: kLightColor,
                                ),
                              ),
                              Text(
                                'Travel Date',
                                style: TextStyle(
                                  color: kLightColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: currentIndex == index ? 32 : 0,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return kLightColor;
                                return kPrimaryColor;
                              },
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Select Travel date',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.supervised_user_circle,
                            size: 32,
                          ),
                          SizedBox(width: 16),
                          Container(
                            color: kLightColor,
                            height: 32,
                            width: 1,
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Passengers',
                                style: TextStyle(
                                  color: kLightColor,
                                ),
                              ),
                              Text(
                                'Adults (12+)',
                                style: TextStyle(
                                  color: kLightColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 34,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed))
                                      return kLightColor;
                                    return kPrimaryColor;
                                  },
                                ),
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => SeatsGridPage(
                                //         flight: flightsAvailable[index]),
                                //   ),
                                // );
                              },
                              child: Text(
                                'next step',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: passengers.map((e) {
                            return Container(
                              margin: EdgeInsets.all(4),
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: currentPassengers == e
                                      ? kPrimaryColor
                                      : kLightColor.withOpacity(0.4),
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    currentPassengers = e;
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    e.toString(),
                                    style: TextStyle(
                                      color: currentPassengers == e
                                          ? kPrimaryColor
                                          : kLightColor.withOpacity(0.4),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
