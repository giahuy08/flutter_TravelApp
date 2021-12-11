import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  static String routeName = "/map";
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  LatLng initPosition =
      const LatLng(0, 0); //initial Position cannot assign null values
  LatLng currentLatLng = const LatLng(0.0, 0.0);
  late Marker _markers;
  final Completer<GoogleMapController> _controller = Completer();
  LocationPermission permission = LocationPermission.denied;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    checkPermission();
  }

  void checkPermission() async {
    permission = await Geolocator.checkPermission();
  }

  void getCurrentLocation() async {
    await Geolocator.getCurrentPosition().then((currLocation) {
      print(currLocation);
      setState(() {
        _markers = Marker(
            infoWindow: const InfoWindow(title: 'Vị trí của bạn'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            markerId: const MarkerId('marker'),
            position: LatLng(currLocation.latitude, currLocation.longitude));

        currentLatLng = LatLng(currLocation.latitude, currLocation.longitude);
      });
    });
  }

  //call this onPress floating action button
  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    getCurrentLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: currentLatLng,
        zoom: 15,
      ),
    ));
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.849988462697008, 106.77167645509252),
    zoom: 14.4746,
  );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);
  static const Marker _kGooglePlexMarker = Marker(
      markerId: MarkerId('kGooglePlex'),
      infoWindow: InfoWindow(title: 'Google Plex'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(10.849988462697008, 106.77167645509252));

  // static final Marker _kLakePlexMarker = Marker(
  //     markerId: MarkerId('kLakePlex'),
  //     infoWindow: InfoWindow(title: 'Lake'),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //     position: LatLng(37.42796133580664, -122.085749656992));
  // static final Polyline _kPolyline = new Polyline(
  //     polylineId: PolylineId('_kPolyline'),
  //     points: [
  //       LatLng(37.43296265331129, -122.08832357078792),
  //       LatLng(37.42796133580664, -122.085749655962)
  //     ],
  //     width: 5);
  // static final Polygon _kPolygon = Polygon(
  //     polygonId: PolygonId('_kPolygon'),
  //     points: [
  //       LatLng(37.43296265331129, -122.08832357078792),
  //       LatLng(37.42796133580664, -122.085749655962),
  //       LatLng(37.418, -122.092),
  //       LatLng(37.435, -122.092),
  //     ],
  //     strokeWidth: 5,
  //     fillColor: Colors.transparent);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                // polylines: {_kPolyline},
                markers: {_kGooglePlexMarker},
                // markers: _markers,
                // polygons: _polygons,
                initialCameraPosition: _kGooglePlex,
                // polygons: {_kPolygon},
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _currentLocation,
        label: const Text('Đến vị trí của bạn!'),
        icon: const Icon(Icons.location_on),
      ),
    );
  }

  Future<void> _goToThePlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
