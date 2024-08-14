class TodoListModel {
  String comment;
  String date;

  TodoListModel(this.comment, this.date);

  TodoListModel.fromJson(Map<String, dynamic> json)
      : comment = json['comment'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'comment': comment,
        'date': date,
      };
}
