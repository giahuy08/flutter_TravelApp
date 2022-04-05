import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/repository/discount_repository.dart';
import 'package:flutter_travelapp/screens/details_tour/components/discount_list_item.dart';
import 'package:flutter_travelapp/size_config.dart';

class DiscountList extends StatefulWidget {
  final Function(String) onSelect;
  final String idTour;

  const DiscountList({Key? key, required this.onSelect, required this.idTour})
      : super(key: key);

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<DiscountList> {
  List<dynamic> _listDiscount = [];
  // List<String> selected = [];
  String selected = '';

  @override
  void initState() {
    super.initState();
    getListDiscount();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getListDiscount() async {
    List<dynamic> listDiscount =
        await DiscountRepository().getListDiscountOfTourByEXP(widget.idTour);

    setState(() {
      _listDiscount.addAll(listDiscount);
    });
  }

  toggle(title) {
    // if (selected.contains(title)) {
    //   selected.remove(title);
    // } else {
    //   selected.add(title);
    // }
    // selected = title;

    setState(() {
      selected = title;
      widget.onSelect(selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _listDiscount.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              SpinKitSpinningLines(
                color: Colors.red,
              ),
              Text(
                "Không có mã giảm giá",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 14.0,
                ),
              ),
            ],
          )
        : Column(
            children: _listDiscount.map((o) {
              return DiscountListItem(
                selected: selected == o['code'],
                onTap: () {
                  toggle(o['code']);
                },
                code: o['code'],
                discount: o['discount'],
                endDiscount: o['endDiscount'],
              );
            }).toList(),
          );
  }
}
