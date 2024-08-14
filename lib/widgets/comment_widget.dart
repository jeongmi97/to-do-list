import 'package:flutter/material.dart';

// 할 일 목록 리스트
class CommentWidget extends StatelessWidget {
  final String comment, type, date;
  final bool isChecked;
  final Function deleteComment;
  final Function unCompleteCmt;
  final Function applyComment;

  const CommentWidget({
    super.key,
    required this.comment,
    required this.isChecked,
    required this.type,
    required this.date,
    required this.deleteComment,
    required this.unCompleteCmt,
    required this.applyComment,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        deleteComment(comment, type, date);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).textTheme.bodyMedium!.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  if (isChecked) {
                    unCompleteCmt(comment, date);
                  } else {
                    applyComment(comment, true, date);
                  }
                },
                icon: Icon(
                  isChecked ? Icons.circle : Icons.circle_outlined,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.alarm_outlined,
                        size: 13,
                        color: Theme.of(context).focusColor,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          date,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall!.color,
                            fontSize:
                                Theme.of(context).textTheme.bodySmall!.fontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      comment,
                      style: TextStyle(
                          color: Theme.of(context).cardColor,
                          fontWeight: FontWeight.w500),
                      // overflow : 위젯의 경계를 벗어나는 텍스트의 처리
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.flag,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
