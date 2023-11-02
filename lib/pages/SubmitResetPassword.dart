import 'dart:convert';

import 'package:disiniwork/constants.dart';
import 'package:disiniwork/pages/PasswordRessetOtpValidation.dart';
import 'package:flutter/material.dart';
import 'package:disiniwork/components/CustomButton.dart';
import 'package:disiniwork/pages/LoginPage.dart';
import 'package:http/http.dart' as http;

class SubmitResetPassword extends StatefulWidget {
  String? email;
  String? otp;
  SubmitResetPassword({super.key,this.email, this.otp});

  @override
  State<SubmitResetPassword> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<SubmitResetPassword> {
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false ;
  String? serverResponse;

  void _showSuccessDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password Changed Successfully', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          content: const Text('You can now log in with your new password.', style: TextStyle(fontSize: 16.0)),
          actions: <Widget>[
            TextButton(
              child: const Text('Login', style: TextStyle(fontSize: 16.0, color: Colors.blue),),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        );
      },
    );
  }

  void _showFailedDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('OTP is wrong', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          content: const Text('Check your email and try aging', style: TextStyle(fontSize: 16.0)),
          actions: <Widget>[
            TextButton(
              child: const Text('INSERT OTP', style: TextStyle(fontSize: 16.0, color: Colors.blue),),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResetPassword(email: widget.email.toString()),
                  ),
                      (route) => false,
                );
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF85301),
      ),
      backgroundColor: const Color(0xfffefeff),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50,),
                  const Icon(
                    Icons.lock,
                    size: 90,
                  ),
                  const SizedBox(height: 10,),
                  const Text('Reset Your Password',style: TextStyle(
                      color: Color(0xFF434242),
                      fontSize: 30
                  )),
                  const SizedBox(height: 10,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text(
                        'Length of the password should be 6',
                        style: TextStyle(
                          color: Color(0xFF3a3b3b),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),

                  const SizedBox(height: 45,),

                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }else if(value.length <= 5){
                          return 'Password should at least 6 character long';
                        }
                        return null;
                      },
                      controller: passwordCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b))
                        ),
                        hintText: 'Password'
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your confirm password';
                        }else if (value != passwordCtrl.text) {
                          return 'Passwords do not match';
                        }else if(value.length < 5){
                          return 'Password should have minimum 6 character';
                        }
                        return null;
                      },
                      controller: confirmPasswordCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b))
                        ),
                        hintText: 'Confirm Password'
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),

                  if (isLoading)
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xff031a38)), // Change this to your desired color
                      strokeWidth: 2,
                    ),const SizedBox(height: 5,),

                  if(serverResponse != null)
                    Text(
                      textAlign: TextAlign.center,
                      serverResponse.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.deepOrangeAccent),
                    ), const SizedBox(height: 5,),
                  if(!isLoading)
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomButton(
                          onPressed: () async {
                            setState(() {
                              serverResponse = null;
                            });
                            if(_formKey.currentState!.validate()){
                              setState(() {
                                isLoading = true;
                              });
                              final Uri url = Uri.parse('$apiBaseUrl/resetpassword');
                              Map<String, dynamic> formData = {
                                'email': widget.email,
                                'otp' : widget.otp,
                                'newpassword': passwordCtrl.text,
                                'cpassword': confirmPasswordCtrl.text,
                              };
                              try {
                                final response = await http.post(
                                  url,
                                  body: formData,
                                );
                                if (response.statusCode == 200) {
                                  _showSuccessDialog();
                                } else {
                                  final Map<String, dynamic> responseData = json.decode(response.body);
                                  _showFailedDialog();
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              } catch (error) {
                                print('Error: $error');
                                setState(() {
                                  isLoading= false;
                                });
                              }
                            }
                          },
                          btnText: 'RESET',
                        )
                    ),
                  const SizedBox( height: 20,),
                ],
              ),
            ),
          ),
        )
      )
    );



  }
}


