import 'package:flutter/material.dart';
import 'pages/RegistrationPage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Disini Work',
      debugShowCheckedModeBanner: false,
      home:RegistrationPage(),
    );
  }
}

