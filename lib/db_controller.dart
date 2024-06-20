import 'package:db_revision/db_helper.dart';
import 'package:db_revision/todo_modal.dart';
import 'package:flutter/material.dart';

class TodoController extends ChangeNotifier {
  List<TODO> allTODOs = [];
  bool loading = true;

  TodoController() {
    initData();
  }

  Future<void> initData() async {
    await DbHelper.dbHelper.initDb();
    allTODOs = await DbHelper.dbHelper.getData();
    loading = false;
    notifyListeners();
  }

  Future<void> addData(TODO todo) async {
    await DbHelper.dbHelper.addTodo(todo: todo);
    await initData();
  }
}
