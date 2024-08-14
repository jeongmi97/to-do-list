import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatefulWidget {
  final Function setSelectDate;

  const CalenderWidget({
    super.key,
    required this.setSelectDate,
  });

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  // 초기 선택 날짜를 현재 날짜로 설정
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2024, 01, 01),
      lastDay: DateTime.utc(2030, 12, 31),
      onDaySelected: onDaySelected,
      selectedDayPredicate: (day) {
        return isSameDay(selectedDate, day);
      },
      calendarStyle: const CalendarStyle(
        defaultTextStyle: TextStyle(
          color: Color.fromARGB(255, 104, 104, 104),
        ),
        weekendTextStyle: TextStyle(
          color: Color.fromARGB(255, 224, 136, 136),
        ),
        outsideDaysVisible: true,
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(color: Colors.black),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDay) {
    widget.setSelectDate(selectedDate);
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
