// main_screen.dart
import 'package:flutter/material.dart';
import 'db_helper.dart';

class MainScreen extends StatelessWidget {
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: FutureBuilder<User?>(
        future: dbHelper.getUserData(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user data found'));
          } else {
            // Display user information
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${snapshot.data!.username}'),
                  Text('Phone: ${snapshot.data!.phone}'),
                  Text('Email: ${snapshot.data!.email}'),
                  Text('Address: ${snapshot.data!.address}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
