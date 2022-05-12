import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/paint_chair.dart';
import 'package:provider/provider.dart';
import '../Bloc/cinema/cinema_bloc.dart';

class SeatsRow extends StatelessWidget {
  final int numSeats;
  final List<int> freeSeats;
  final String rowSeats;

  const SeatsRow(
      {Key? key,
      required this.rowSeats,
      required this.numSeats,
      required this.freeSeats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final cinemaBloc = Provider.of<CinemaBloc>(context);

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(numSeats, (i) {
          if (freeSeats.contains(i + 1)) {
            return InkWell(
                // onTap: () => cinemaBloc.add( OnSelectedSeatsEvent( '$rowSeats${i + 1}' ) ),
                child:
                    // BlocBuilder<CinemaBloc, CinemaState>(
                    // builder: (_, state) =>
                    PaintChair(color: Colors.white)
                // )
                );
          }

          return PaintChair();
        }),
      ),
    );
  }
}
