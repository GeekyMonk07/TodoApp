import 'package:flutter/material.dart';
import 'package:todo_app/pages/home_page.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;

  const TodoFormWidget({
    Key? key,
    this.description = '',
    this.title = '',
    required this.onChangedDescription,
    required this.onChangedTitle,
    required this.onSavedTodo,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            SizedBox(
              height: 8,
            ),
            buildDescription(),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => addTodo,
                child: Text(
                  'Save',
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
            ),
          ],
        ),
      );
}

Widget buildTitle() => TextFormField(
      maxLines: 1,
      validator: (title) {
        if (title!.isEmpty) {
          return 'Title Cannot be Empty';
        }
        return null;
      },
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Title',
      ),
    );

Widget buildDescription() => TextFormField(
      maxLines: 3,
      validator: (title) {
        if (title!.isEmpty) {
          return 'Description Cannot be Empty';
        }
        return null;
      },
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Description',
      ),
    );
