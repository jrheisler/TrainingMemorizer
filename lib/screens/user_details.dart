import 'package:flutter/material.dart';

class UserDetailsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('User Information'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Name: John Doe'),
          Text('Email: john.doe@example.com'),
          Text('Role: Student'),
          // Add other TrainingUser details here
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
      ],
    );
  }
}
