// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:disiniwork/pages/EmailOtpValidation.dart';
import 'package:disiniwork/pages/ForceToAddBio.dart';
import 'package:disiniwork/pages/ForceToAddSkills.dart';
import 'package:disiniwork/pages/HomePage.dart';
import 'package:disiniwork/pages/LoginPage.dart';
import 'package:disiniwork/pages/RegistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'PhoneNumberVeryfy.dart';

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
      final String? username = sharedPreference.getString('username');
      final String emailVerifiedAt = sharedPreference.getString('email_verified_at').toString();
      //print(username);
      if(username != null){

        try{
          final Uri url = Uri.parse('${apiBaseUrl}/getuserdetails/${username}');
          var response = await http.get(url);
          if(response.statusCode == 200){
            final responseData = json.decode(response.body);
            //print(responseData['data']['skills']);
            List<dynamic> _skills = responseData['data']['skills'];
            String? professional_title = responseData['data']['professional_title'];
            String? phone = responseData['data']['phone'];
            if(_skills.length == 0){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ForceToAddSkills();
                  },
                ),
              );
            }else if(professional_title == null){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ForceToAddBio();
                  },
                ),
              );
            }else if(phone == null){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PhoneNumberVerify();
                  },
                ),
              );
            } else{
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
            }
          }
        }catch(error){
          print('Error: ${error}');
        }
      }else{
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
      }

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
