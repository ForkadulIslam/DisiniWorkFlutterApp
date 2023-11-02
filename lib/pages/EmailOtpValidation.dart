import 'dart:convert';

import 'package:disiniwork/constants.dart';
import 'package:disiniwork/pages/HomePage.dart';
import 'package:disiniwork/pages/RegistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/CustomButton.dart';
import 'package:http/http.dart' as http;

import 'SplashPage.dart';
class EmailOtpValidation extends StatefulWidget {
  final String emailAddress;

  const EmailOtpValidation({super.key, required this.emailAddress} );

  @override
  State<EmailOtpValidation> createState() => _EmailOtpValidationState();
}

class _EmailOtpValidationState extends State<EmailOtpValidation> {
  String? serverMessage;
  bool isLoading = false;
  String? finalVeryficationCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffefeff),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                const Icon(
                  Icons.lock,
                  size: 90,
                ),
                const SizedBox(height: 10,),
                const Text(''
                    'Check Your Inbox',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 30
                    )
                ),
                const SizedBox(height: 20,),
                const Text(
                  'A six digit code has been sent to',
                  style: TextStyle(color: Color(0xff9d9d9d),fontSize: 12),
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.emailAddress.toString(),
                      style: const TextStyle(color: Color(0xff1d1d1d), fontSize: 12),
                    ),
                    const SizedBox(width: 5,),
                    InkWell(
                      onTap: () {
                        // Add navigation to the login page here
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationPage()));
                      },
                      child: Container(
                        child: const Text(
                          'Reset & Register Again',
                          style: TextStyle(color: Color(0xff3b87eb),fontSize: 12),
                        )
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: OtpTextField(
                      clearText: true,
                      numberOfFields: 6,
                      borderColor: const Color(0xff031a38),
                      //set to true to show as box or false to show as dash
                      showFieldAsBox: true,
                      //runs when a code is typed in
                      onCodeChanged: (String code) {
                        //handle validation or checks here
                      },
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode){
                        print(verificationCode);
                        setState(() {
                          finalVeryficationCode = verificationCode;
                        });
                      }, // end onSubmit
                    ),
                  ),
                ),
                const SizedBox(height: 100,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '- OTP Code will expire in 55 seconds',
                      style: TextStyle(color: Color(0xff9d9d9d),fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 2,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '- Did not receive this code?',
                          style: TextStyle(color: Color(0xff9d9d9d),fontSize: 12),
                        ),
                        const SizedBox(width: 2,),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                              serverMessage  = null;
                            });
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            String token = pref.getString('token').toString();
                            Map<String, dynamic> formData = {
                              'email':widget.emailAddress.toString()
                            };
                            try{
                              var response = await http.post(
                                Uri.parse('$apiBaseUrl/sendemlvericode'),
                                body: formData,
                                headers: {
                                  'Authorization': 'Bearer $token',
                                },
                              );
                              Map<String, dynamic> responseData = jsonDecode(response.body);
                              print(responseData);
                              setState(() {
                                serverMessage = responseData['msg'];
                              });
                            }catch(error){
                              setState(() {
                                serverMessage = error.toString();
                              });
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: const Text(
                            'Resend',
                            style: TextStyle(color: Color(0xff3b87eb),fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 2,),
                        const Text(
                          'OR',
                          style: TextStyle(color: Color(0xff9d9d9d),fontSize: 12),
                        ),
                        const SizedBox(width: 2,),
                        InkWell(
                          onTap: ()async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.remove('token');
                            prefs.remove('email');
                            prefs.remove('email_verified_at');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (BuildContext ctx) => const SplashPage())
                            );
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Color(0xff3b87eb),fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                const SizedBox(height: 40,),
                if (isLoading)
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xff031a38)), // Change this to your desired color
                    strokeWidth: 2,
                  ),
                  const SizedBox(height: 10,),
                if(serverMessage != null)
                  Text(serverMessage.toString(), style: const TextStyle(fontSize: 15, color: Color(0xffe37070)),),const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomButton(onPressed: ()async{
                    setState(() {
                      isLoading = true;
                      serverMessage = null;
                    });
                    try{
                      Map<String, dynamic> formData = {
                        'code':finalVeryficationCode
                      };
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      String token = pref.getString('token').toString();
                      var response = await http.post(
                        Uri.parse('$apiBaseUrl/verifyemailcode'),
                        body:formData,
                        headers: {
                          'Authorization': 'Bearer $token',
                        },
                      );
                      Map<String, dynamic> responseData = jsonDecode(response.body);
                      if(response.statusCode == 200){
                        setState(() {
                          serverMessage = responseData['msg'];
                        });

                        Future.delayed(const Duration(seconds: 2),() async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove('token');
                          prefs.remove('email');
                          prefs.remove('email_verified_at');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const HomePage();
                              },
                            ),
                          );
                        });

                      }else{
                        print(responseData);
                        setState(() {
                          serverMessage = responseData['msg'];
                        });
                      }
                    }catch(error){
                      setState(() {
                        serverMessage = error.toString();
                      });
                    }

                    setState(() {
                      isLoading = false;
                    });

                  },btnText: 'VALIDATE',),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
