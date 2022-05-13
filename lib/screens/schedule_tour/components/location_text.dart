import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';

class LocationText extends StatelessWidget {
  const LocationText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.location_on,color: kTextColor,size: 30,),
          const SizedBox(
            width: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Carnival Cinemas',style: TextStyle(
                color: kTextColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),),
              Text('Kodungallur, Kerala, India',style: TextStyle(
                color: kTextColor.withOpacity(0.5),
                fontSize: 16.0,
              ),),
            ],
          )
        ],
      ),
    );
  }
}
