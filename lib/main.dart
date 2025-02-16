import 'package:flutter/material.dart';
import 'screens/formscreen.dart'; // Import the user input validation file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Set this to false to remove the debug banner
      home: FormInput(), // Set FormInput as the home screen
    );
  }
}
