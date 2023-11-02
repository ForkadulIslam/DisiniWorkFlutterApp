import 'dart:convert';

import 'package:disiniwork/pages/SubmitResetPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({super.key, required this.email });

  @override
  State<ResetPassword> createState() => _ResetPasswordOtpValidationState();
}

class _ResetPasswordOtpValidationState extends State<ResetPassword> {
  bool isLoading = false;
  String? serverMessage;
  void _showSuccessDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('OTP has been sent', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          content: const Text('Please check email for the instruction', style: TextStyle(fontSize: 16.0)),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(fontSize: 16.0, color: Colors.blue),),
              onPressed: () {
                Navigator.of(context).pop();
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
                      widget.email.toString(),
                      style: const TextStyle(color: Color(0xff1d1d1d), fontSize: 12),
                    ),
                    const SizedBox(width: 5,),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                          serverMessage  = null;
                        });
                        Map<String, dynamic> formData = {
                          'email': widget.email,
                        };
                        try{
                          final Uri url = Uri.parse('$apiBaseUrl/forgotpassword');
                          var response = await http.post(url, body: formData);
                          final Map<String, dynamic> responseData = json.decode(response.body);
                          if(response.statusCode == 200){
                            _showSuccessDialog();
                          }else{
                            setState(() {
                              serverMessage = responseData['msg'];
                            });
                          }
                        }catch(error){
                          print('API Error: $error');
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
                  ],
                ),
                const SizedBox(height: 50,),
                if(isLoading)
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xff031a38)), // Change this to your desired color
                    strokeWidth: 2,
                  ),
                if(!isLoading)
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SubmitResetPassword(email: widget.email,otp:verificationCode)),
                        );
                      }, // end onSubmit
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
