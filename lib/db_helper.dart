import 'package:db_revision/todo_modal.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper dbHelper = DbHelper._();

  late Database database;

  String dbName = "all_todo.db";
  String tableName = "TodoTable";
  String query = "";

  Logger logger = Logger();

  Future<void> initDb() async {
    String path = await getDatabasesPath();

    database = await openDatabase(
      "$path/$dbName",
      version: 1,
      onCreate: (db, v) {
        query =
            "CREATE TABLE IF NOT EXISTS $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,dateTime INTEGER,status BOOLEAN);";

        db
            .execute(query)
            .then((value) => logger.i("Table created..."))
            .onError((error, stackTrace) => logger.e("Error: $error"));
      },
    );
  }

  Future<void> addTodo({required TODO todo}) async {
    Map<String, dynamic> data = todo.toSQL;
    data.remove('id');
    await database
        .insert(tableName, data)
        .then((value) => logger.i("Inserted..."))
        .onError((error, stackTrace) => logger.e("ERROR: $error"));
  }

  Future<List<TODO>> getData() async {
    List<TODO> allData = [];

    List data = await database.query(tableName);
    logger.i("ALL DATA: $data");

    allData = data.map((e) => TODO.fromSQL(sql: e)).toList();

    return allData;
  }
}
