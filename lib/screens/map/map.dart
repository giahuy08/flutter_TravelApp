import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_travelapp/models/coffee_model.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController _controller;

  List<Marker> allMarkers = [];

  late PageController _pageController;

  int prevPage = 1;
  List<TourModel> _listTour = [];

  initialController() {
    _listTour = [];
  }

  void getListTour() async {
    List<TourModel> tours = await TourRepository().getListTour(1, 15);

    setState(() {
      _listTour.addAll(tours);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListTour();
    _listTour.forEach((element) async {
      Uint8List bytes =
          (await NetworkAssetBundle(Uri.parse(element.imagesTour[0]))
                  .load(element.imagesTour[0]))
              .buffer
              .asUint8List();
      allMarkers.add(Marker(
          markerId: MarkerId(element.name),
          draggable: false,
          icon: BitmapDescriptor.fromBytes(bytes),
          infoWindow: InfoWindow(title: element.name, snippet: element.place),
          position: LatLng(double.parse(element.latitude),
              double.parse(element.longtitude))));
      setState(() {});
    });
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page?.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      moveCamera();
    }
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 0;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 700.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          _listTour[index].imagesTour[0]),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Flexible(
                            child: Container(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _listTour[index].name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      _listTour[index].place,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      width: 170.0,
                                      child: Text(
                                        _listTour[index].detail,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  ]),
                            ),
                          )
                        ]))))
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bản đồ tour'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: _listTour.length == 0
            ? SpinKitSpinningLines(
                color: Colors.red,
              )
            : Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height - 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(double.parse(_listTour[0].latitude),
                              double.parse(_listTour[0].longtitude)),
                          zoom: 15.0),
                      markers: Set.from(allMarkers),
                      onMapCreated: mapCreated,
                    ),
                  ),
                  Positioned(
                    bottom: 20.0,
                    child: Container(
                      height: 150.0,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _listTour.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _coffeeShopList(index);
                        },
                      ),
                    ),
                  )
                ],
              ));
    ;
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            double.parse(_listTour[_pageController.page!.toInt()].latitude),
            double.parse(_listTour[_pageController.page!.toInt()].longtitude)),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}
