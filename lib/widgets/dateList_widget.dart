import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatelistWidget extends StatefulWidget {
  final int weekIdx;
  const DatelistWidget({
    super.key,
    required this.weekIdx,
  });

  @override
  State<DatelistWidget> createState() => _DatelistWidgetState();
}

class _DatelistWidgetState extends State<DatelistWidget> {
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        DateTime date = today
            .subtract(Duration(days: today.weekday + widget.weekIdx - index));
        String month = DateFormat('MM').format(date);
        String day = DateFormat('dd').format(date);
        String week = DateFormat('E').format(date);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Theme.of(context).focusColor,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  day,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18),
                ),
                Text(month),
                Text(week)
              ],
            ),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
    );
  }
}
