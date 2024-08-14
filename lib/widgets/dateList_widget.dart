import 'package:flutter/material.dart';

class DatelistWidget extends StatefulWidget {
  const DatelistWidget({super.key});

  @override
  State<DatelistWidget> createState() => _DatelistWidgetState();
}

class _DatelistWidgetState extends State<DatelistWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            borderRadius: BorderRadius.circular(15)),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                '19',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18),
              ),
              Text('Month'),
              Text('Fri')
            ],
          ),
        ),
      ),
      scrollDirection: Axis.horizontal,
    );
  }
}
