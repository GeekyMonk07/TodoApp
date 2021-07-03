import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/api/firebase_api.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widgets/add_todo_widget.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/widgets/completed_list_widget.dart';
import 'package:todo_app/widgets/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      CompletedListWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: 'Completed',
          ),
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        // stream: FirebaseApi.readTodos(),
        builder: (context, snapshot) {
          return tabs[selectedIndex];
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Add Todo',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TodoFormWidget(
                    onChangedTitle: (title) =>
                        setState(() => this.title = title),
                    onChangedDescription: (description) =>
                        setState(() => this.description = description),
                    onSavedTodo: addTodo,
                  ),
                ],
              ),
            ),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

void addTodo() {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  final isValid = _formKey.currentState!.validate();

  if (!isValid) {
    return;
  } else {
    final todo = Todo(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      createdTime: DateTime.now(),
    );

    // final provider = Provider.of<TodosProvider>(context);
    // provider.addTodo(todo);

    // Navigator.of(context).pop();
  }
}
