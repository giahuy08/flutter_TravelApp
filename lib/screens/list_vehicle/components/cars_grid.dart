import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_travelapp/models/cars.dart';
import 'package:flutter_travelapp/models/vehicle.dart';
import 'package:flutter_travelapp/repository/vehicle_repository.dart';
import 'package:flutter_travelapp/screens/bookedtour_booking/bookedtour_app_theme.dart';
import 'package:sizer/sizer.dart';

import '../../../size_config.dart';

class CarsGrid extends StatefulWidget {
  const CarsGrid({Key? key}) : super(key: key);

  @override
  State<CarsGrid> createState() => _CarsGridState();
}

class _CarsGridState extends State<CarsGrid> {
  List<VehicleModel> _listVehicle = [];
  initialController() {
    _listVehicle = [];
  }

  @override
  void initState() {
    super.initState();
    getListVehicle();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getListVehicle() async {
    List<VehicleModel> listVehicle = await VehicleRepository().getListVehicle();
    setState(() {
      _listVehicle.addAll(listVehicle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _listVehicle.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10.h),
              Image.asset('assets/images/airline.png',
                  width: getProportionateScreenHeight(50.w),
                  height: getProportionateScreenHeight(20.h)),
              SizedBox(height: 5.h),
              const SpinKitSpinningLines(
                color: Colors.red,
              )
            ],
          )
        : GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: _listVehicle.length,
            itemBuilder: (ctx, i) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (ctx) => CarDetail(
                  //           title: allCars.cars[i].title,
                  //           brand: allCars.cars[i].brand,
                  //           fuel: allCars.cars[i].fuel,
                  //           price: allCars.cars[i].price,
                  //           path: allCars.cars[i].path,
                  //           gearbox: allCars.cars[i].gearbox,
                  //           color: allCars.cars[i].color,
                  //         )));
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * .48,
                    padding:
                        EdgeInsets.all(getProportionateScreenHeight(10.sp)),
                    margin: EdgeInsets.only(
                        top: i.isEven ? 0 : 20, bottom: i.isEven ? 20 : 0),
                    decoration: BoxDecoration(
                        color: BookedTourAppTheme.buildLightTheme()
                            .backgroundColor,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 1)
                        ]),
                    child: Column(
                      children: [
                        Hero(
                            tag: _listVehicle[i].name,
                            child: Image.network(
                                _listVehicle[i].imagesVehicle[0])),
                        Text(
                          _listVehicle[i].vehicleNumber,
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          _listVehicle[i].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          maxLines: 1,
                        ),
                      ],
                    )),
              ),
            ),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          );
  }
}
