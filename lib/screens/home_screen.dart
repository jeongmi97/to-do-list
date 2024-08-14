import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/models/todo_list_model.dart';
import 'package:to_do_list/widgets/comment_widget.dart';
import 'package:to_do_list/widgets/dateList_widget.dart';
import 'package:to_do_list/widgets/modal_widget.dart';
import 'package:to_do_list/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String formatToday = DateFormat("dd/MM/yyyy").format(DateTime.now());

  TextEditingController commentController = TextEditingController();

  bool isComment = false;
  bool isComplete = false;
  List<dynamic> commentList = [];
  List<dynamic> completeList = [];
  List<TodoListModel> commentModelList = [];
  List<TodoListModel> completeModelList = [];

  Future initPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    final comments = prefs.getStringList('comments');
    final completeCmts = prefs.getStringList('completeCmts');

    // 할 일 리스트 세팅
    if (comments != null) {
      setState(() {
        isComment = true;
        commentList = comments;
        for (var todo in commentList) {
          Map<String, dynamic> jsonData = jsonDecode(todo);
          commentModelList.add(TodoListModel.fromJson(jsonData));
        }
      });
    } else {
      await prefs.setStringList('comments', []);
    }

    // 완료 리스트 세팅
    if (completeCmts != null) {
      setState(() {
        isComplete = true;
        completeList = completeCmts;
        for (var todo in completeList) {
          Map<String, dynamic> jsonData = jsonDecode(todo);
          completeModelList.add(TodoListModel.fromJson(jsonData));
        }
      });
    } else {
      await prefs.setStringList('completeCmts', []);
    }
  }

  @override
  void initState() {
    super.initState();
    // 메모리 초기 설정
    initPrefs();
  }

  // 리스트 추가/완료 처리
  applyComment(String comment, bool isChecked, String date) async {
    var prefs = await SharedPreferences.getInstance();
    final comments = prefs.getStringList('comments');
    final completeCmts = prefs.getStringList('completeCmts');

    Map<String, dynamic> map = {};
    map['comment'] = comment;
    map['date'] = date;
    String jsonData = jsonEncode(map);

    // 할 일 추가
    if (!isChecked) {
      comments!.add(jsonData);

      setState(() {
        isComment = true;
        commentList = comments;
        commentModelList.add(TodoListModel.fromJson(map));
      });
    } else {
      // 완료 처리
      comments!.remove(jsonData);
      completeCmts!.add(jsonData);

      await prefs.setStringList('completeCmts', completeCmts);

      setState(() {
        if (comments.isEmpty) {
          isComment = false;
        }
        isComplete = true;
        commentList = comments;
        completeList = completeCmts;
        completeModelList.add(TodoListModel.fromJson(map));
        commentModelList.remove(TodoListModel.fromJson(map));
      });
    }

    await prefs.setStringList('comments', comments);
  }

  // 완료 -> 미완료
  unCompleteCmt(String comment, String date) async {
    var prefs = await SharedPreferences.getInstance();
    final comments = prefs.getStringList('comments');
    final completeCmts = prefs.getStringList('completeCmts');

    Map<String, dynamic> map = {};
    map['comments'] = comment;
    map['date'] = date;
    String jsonData = jsonEncode(map);

    comments!.add(jsonData);
    completeCmts!.remove(jsonData);

    await prefs.setStringList('comments', comments);
    await prefs.setStringList('completeCmts', completeCmts);

    setState(() {
      isComment = true;
      if (completeCmts.isEmpty) {
        isComplete = false;
      }
      commentList = comments;
      completeList = completeCmts;
      completeList.remove(TodoListModel.fromJson(map));
      commentModelList.add(TodoListModel.fromJson(map));
    });
  }

  // 리스트 삭제
  deleteComment(String comment, String type, String date) async {
    var prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> map = {};
    map['comment'] = comment;
    map['date'] = date;
    String jsonData = jsonEncode(map);

    // 미완료 항목 삭제
    if (type == 'incomplete') {
      final comments = prefs.getStringList('comments');
      comments!.remove(jsonData);
      await prefs.setStringList('comments', comments);

      setState(() {
        if (comments.isEmpty) {
          isComment = false;
        }
        commentList = comments;
        commentModelList.remove(TodoListModel.fromJson(map));
      });
    } else {
      // 완료 항목 삭제
      final completeCmts = prefs.getStringList('completeCmts');
      completeCmts!.remove(jsonData);
      await prefs.setStringList('completeCmts', completeCmts);

      setState(() {
        if (completeCmts.isEmpty) {
          isComplete = false;
        }
        completeList = completeCmts;
        commentModelList.remove(TodoListModel.fromJson(map));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // SafeArea : 상단바 침범문제로 사용
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF7F7F7),
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.15,
                      decoration: const BoxDecoration(),
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          // children: [
                          //   // Text(
                          //   //   'aaaaa',
                          //   //   style: TextStyle(color: Colors.black),
                          //   // ),
                          //   createDateList(),
                          // ],
                          children: [
                            Expanded(
                              child: DatelistWidget(),
                            ),
                            // const DatelistWidget(),
                            // Container(
                            //   margin:
                            //       const EdgeInsets.symmetric(horizontal: 10),
                            //   decoration: BoxDecoration(
                            //       color: Theme.of(context).focusColor,
                            //       borderRadius: BorderRadius.circular(15)),
                            //   child: const Padding(
                            //     padding: EdgeInsets.all(8.0),
                            //     child: Column(
                            //       children: [
                            //         Text(
                            //           '19',
                            //           style: TextStyle(
                            //               color: Colors.white,
                            //               fontWeight: FontWeight.w900,
                            //               fontSize: 18),
                            //         ),
                            //         Text('Month'),
                            //         Text('Fri')
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius: BorderRadius.circular(15)),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Column(
                            //       children: [
                            //         Text(
                            //           '20',
                            //           style: TextStyle(
                            //               color: Theme.of(context)
                            //                   .textTheme
                            //                   .bodyLarge!
                            //                   .color,
                            //               fontWeight: FontWeight.w900,
                            //               fontSize: 18),
                            //         ),
                            //         Text('Month',
                            //             style: TextStyle(
                            //               color: Theme.of(context)
                            //                   .textTheme
                            //                   .bodySmall!
                            //                   .color,
                            //             )),
                            //         Text('Fri',
                            //             style: TextStyle(
                            //               color: Theme.of(context)
                            //                   .textTheme
                            //                   .bodySmall!
                            //                   .color,
                            //             )),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          // 현재 날짜 / 완료된 수 view
                          TaskWidget(
                            size: size,
                            formatToday: formatToday,
                            completeList: completeList,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                comentTitle(context, "Incomplete"),
                                if (isComment)
                                  for (TodoListModel todo in commentModelList)
                                    CommentWidget(
                                      comment: todo.comment,
                                      date: todo.date,
                                      isChecked: false,
                                      type: "incomplete",
                                      deleteComment: deleteComment,
                                      unCompleteCmt: unCompleteCmt,
                                      applyComment: applyComment,
                                    ),
                                // commentView(
                                //     context, comment, false, "incomplete"),
                                if (!isComment) nothingMessage(context),
                                const SizedBox(
                                  height: 10,
                                ),
                                comentTitle(context, "Complete"),
                                if (isComplete)
                                  for (TodoListModel todo in completeModelList)
                                    CommentWidget(
                                      comment: todo.comment,
                                      date: todo.date,
                                      isChecked: true,
                                      type: "complete",
                                      deleteComment: deleteComment,
                                      unCompleteCmt: unCompleteCmt,
                                      applyComment: applyComment,
                                    ),
                                // commentView(
                                //     context, completeCmt, true, "complete"),
                                if (!isComplete) nothingMessage(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Spacer : 유연한 빈 공간을 만들기 위해 사용
            // const Spacer(),
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: const BoxDecoration(),
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  iconSize: 50,
                  color: Theme.of(context).cardColor,
                  onPressed: () {
                    // WriteModalWidget.wirteModal(context, size);
                    // writeModal(context, size);
                    // 모달 작성
                    writeModal(context, size, commentController, applyComment);
                  },
                  icon: const Icon(Icons.add_circle_rounded),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 카테고리 타이틀
  Container comentTitle(BuildContext context, String comentTitle) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        comentTitle,
        style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color,
            fontWeight: FontWeight.w900),
      ),
    );
  }

  // 아무것도 없을 때
  Container nothingMessage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 150),
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyMedium!.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'Nothing...',
        style: TextStyle(color: Theme.of(context).focusColor),
      ),
    );
  }
}
