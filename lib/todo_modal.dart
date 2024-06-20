class TODO {
  int id = 0;
  String title;
  DateTime dateTime;
  bool status;

  TODO(this.title, this.dateTime, this.status, {this.id = 0});

  factory TODO.fromSQL({required Map sql}) {
    return TODO(
      sql['title'],
      DateTime.fromMillisecondsSinceEpoch(sql['dateTime']),
      sql['status'] == 1,
      id: sql['id'],
    );
  }

  Map<String, dynamic> get toSQL => {
        'id': id,
        'title': title,
        'dateTime': dateTime.millisecondsSinceEpoch,
        'status': status,
      };
}
