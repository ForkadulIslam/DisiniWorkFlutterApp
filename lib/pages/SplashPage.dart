// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:disiniwork/pages/EmailOtpValidation.dart';
import 'package:disiniwork/pages/HomePage.dart';
import 'package:disiniwork/pages/LoginPage.dart';
import 'package:disiniwork/pages/RegistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 4), () async{
      final sharedPreference = await SharedPreferences.getInstance();
      final String? token = sharedPreference.getString('token');
      final String? email = sharedPreference.getString('email');
      final String emailVerifiedAt = sharedPreference.getString('email_verified_at').toString();

      print('Email Verified at : $emailVerifiedAt');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (token != null) {
              if(emailVerifiedAt != 'null'){
                return const HomePage();
              }else{
                return EmailOtpValidation(emailAddress: email ?? 'no email found');
              }
            } else {
              return const RegistrationPage();
            }
          },
        ),
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         gradientStart,gradientEnd
        //       ],
        //       end: Alignment.bottomLeft,
        //       begin: Alignment.topCenter,
        //     )
        // ),
        child: Center(
          child: Image.asset('lib/images/splash_animation.gif'),
        ),
      ),
    );
  }
}
