import 'package:flutter/material.dart';
import 'package:to_do_list/models/todo_list_model.dart';

class TaskWidget extends StatelessWidget {
  final Size size;
  final String formatToday;
  final List<dynamic> completeList;

  const TaskWidget(
      {super.key,
      required this.size,
      required this.formatToday,
      required this.completeList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.15,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(formatToday),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          // 완료 된 리스트 수 보여주기
                          '${completeList.length} task',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 150,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.edit_calendar_outlined,
                    size: 100,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
