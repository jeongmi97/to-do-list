import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/widgets/calender_widget.dart';

Future writeModal(BuildContext context, Size size,
    TextEditingController commentController, Function applyComment) {
  bool isSelectDate = false;
  String selectDate = DateFormat("dd/MM/yyyy").format(DateTime.now());

  setSelectDate(DateTime usrSelectDate) {
    isSelectDate = true;
    selectDate = DateFormat("dd/MM/yyyy").format(usrSelectDate);
  }

  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    // isScrollControlled : 일정 높이 이상 설정할 때
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          height: size.height * 0.7,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  child: Text(
                    'Create task',
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                TextField(
                  // controller : TextField에 입력된 값을 사용
                  controller: commentController,
                  decoration: const InputDecoration(
                    labelText: "To Do",
                    // floatingLabelBehavior : 라벨 위치 설정
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CalenderWidget(setSelectDate: setSelectDate),

                // GestureDetector : 사용자의 제스처 감지
                GestureDetector(
                  onTap: () {
                    String comment = commentController.text;
                    if (comment.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Alert',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color),
                          ),
                          content: Text(
                            '메모를 입력해주세요',
                            style:
                                TextStyle(color: Theme.of(context).cardColor),
                          ),
                        ),
                      );
                    } else {
                      Navigator.of(context).pop();
                      commentController.text = '';
                      applyComment(comment, false, selectDate);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).focusColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Add To Do !',
                      style: TextStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
