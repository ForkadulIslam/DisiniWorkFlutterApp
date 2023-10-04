import 'package:flutter/material.dart';
import 'pages/RegistrationPage.dart';
import 'pages/LoginPage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disini Work',
      debugShowCheckedModeBanner: false,
      home:RegistrationPage(),
    );
  }
}

