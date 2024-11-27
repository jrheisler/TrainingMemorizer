import 'package:flutter/material.dart';
import 'package:training_memorizer/screens/user_details.dart';

import 'dashboard_grid.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // Show TrainingUser details dialog
            showDialog(
              context: context,
              builder: (_) => UserDetailsDialog(),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.purple, // Default purple
              backgroundImage: NetworkImage(
                'https://example.com/user-image.jpg', // Replace with actual user image URL
              ),
              child: Text(
                'J', // First initial as fallback
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.deepPurple,
        title: Text('Training Memorizer'),
      ),
      body: DashboardGrid(),
    );
  }
}
