import 'package:db_revision/db_controller.dart';
import 'package:db_revision/todo_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TodoController mutable = Provider.of<TodoController>(context);
    TodoController immutable =
        Provider.of<TodoController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO App"),
      ),
      body: mutable.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : mutable.allTODOs.isEmpty
              ? const Center(
                  child: Text("NO DATA"),
                )
              : ListView.builder(
                  itemCount: mutable.allTODOs.length,
                  itemBuilder: (c, i) => ListTile(
                    title: Text(mutable.allTODOs[i].title),
                    trailing: Checkbox(
                      value: mutable.allTODOs[i].status,
                      onChanged: (v) {},
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TODO todo = TODO(
            'demo',
            DateTime.now(),
            false,
          );

          showDialog(
            context: context,
            builder: (c) => AlertDialog(
              title: const Text("Add TODO"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (v) => todo.title = v,
                    decoration: InputDecoration(
                      hintText: "Enter title",
                      labelText: "Title",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Date: ${todo.dateTime.day}/${todo.dateTime.month}/${todo.dateTime.year}"),
                      IconButton(
                        onPressed: () async {
                          todo.dateTime = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 5),
                                ),
                              ) ??
                              todo.dateTime;
                        },
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    await immutable.addData(todo);
                    Navigator.pop(context);
                  },
                  child: const Text("SAVE"),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
