// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

class DialogBoxPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
DialogBoxPage({super.key, 
  required this.controller,
  required this.onCancel,
  required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Add a new task"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonWidget(text: "Save", onPressed:onSave),
                const SizedBox(
                  width: 4,
                ),
                ButtonWidget(text: "Cancel", onPressed:onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
