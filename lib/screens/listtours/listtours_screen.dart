import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/listtours_argument.dart';
import 'package:flutter_travelapp/components/tour_argument.dart';
import 'package:flutter_travelapp/screens/listtours/components/body.dart';

class ListToursScreen extends StatefulWidget {
  static String routeName = "/listtours";
  const ListToursScreen({Key? key}) : super(key: key);

  @override
  State<ListToursScreen> createState() => _ListToursScreenState();
}

class _ListToursScreenState extends State<ListToursScreen> {
  @override
  Widget build(BuildContext context) {
    ListToursArguments arguments =
        ModalRoute.of(context)!.settings.arguments as ListToursArguments;
    print('hello ${arguments.tours.length}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách tour'),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(arguments),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Body(
        listTour: arguments.tours,
      ),
    );
  }
}
