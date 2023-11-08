import 'dart:convert';

import 'package:disiniwork/components/BuildInputDecoration.dart';
import 'package:disiniwork/constants.dart';
import 'package:disiniwork/pages/EmailOtpValidation.dart';
import 'package:disiniwork/pages/ForgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:disiniwork/pages/RegistrationPage.dart';
import 'package:disiniwork/components/CustomButton.dart';
import 'package:disiniwork/components/SocialButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'package:http/http.dart' as http;
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChecked = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String? authErrorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffefeff),
      body:SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 50,),
                    const Icon(
                      Icons.lock,
                      size: 90,
                    ),
                    const SizedBox(height: 10,),
                    const Text('Login',style: TextStyle(
                        color: Color(0xFF434242),
                        fontSize: 30
                    )),
                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Text(
                          'Do you have a GIG, You need it, We have it. Welcome to login',
                          style: TextStyle(
                            color: Color(0xFF3a3b3b),
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SocialButton(btnText: 'Continue with Facebook', path: 'lib/images/f_logo.png', onPressed: (){}),
                    ),

                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SocialButton(btnText: 'Continue with Google', path: 'lib/images/google_logo.png', onPressed: (){}),
                    ),

                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SocialButton(btnText: 'Continue with Apple ID', path: 'lib/images/apple_logo.png', onPressed: (){}),
                    ),

                    const SizedBox(height: 20,),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(child: Divider(
                            thickness: .9,
                            color: Color(0xff9e9f9f),
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text('OR'),
                          ),
                          Expanded(child: Divider(
                            thickness: .9,
                            color: Color(0xff9e9f9f),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    if (authErrorMessage != null)
                      Text(authErrorMessage.toString(),style: const TextStyle(fontSize: 15,color: Color(0xffe37070))),const SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email address';
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: buildInputDecoration('Email', Icons.email_outlined)
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: true,
                        decoration: buildInputDecoration('Password', Icons.password_outlined)
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () async{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(color: Color(0xff2e81ea))
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isChecked, // You can set the initial value as needed
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                          ),
                          const Text(
                            'Remember this device', // Your privacy agreement text
                            style: TextStyle(
                              color: Color(0xff1d1c1c),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox( height: 10,),
                    if (isLoading)
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xff031a38)), // Change this to your desired color
                        strokeWidth: 2,
                      ),
                    const SizedBox( height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomButton(onPressed:  () async{
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            isLoading = true;
                            authErrorMessage = null;
                          });
                          Map<String, dynamic> formData = {
                            'email': emailController.text,
                            'password':passwordController.text,
                          };
                          try{
                            final Uri url = Uri.parse('$apiBaseUrl/login');
                            var response = await http.post(url, body: formData);
                            final Map<String, dynamic> responseData = json.decode(response.body);

                            if(response.statusCode == 200){
                              if(responseData.containsKey('data')){
                                print(responseData['data']);
                                final prefs = await SharedPreferences.getInstance();
                                prefs.setString('token', responseData['data']['api_token'].toString());
                                prefs.setString('email', responseData['data']['email'].toString());
                                prefs.setString('username', responseData['data']['username'].toString());
                                prefs.setString('email_verified_at', responseData['data']['email_verified_at'].toString());
                                if(responseData['data']['email_verified_at'] == null){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EmailOtpValidation(emailAddress: responseData['data']['email'])));
                                }else{
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                                }
                              }
                            }else{
                              if(responseData.containsKey('data')){
                                print(responseData['data']['error']);
                                setState(() {
                                  authErrorMessage = responseData['data']['error'];
                                });
                              }
                            }
                          }catch(error){
                            print('API Error: $error');
                            setState(() {
                              authErrorMessage = error.toString();
                            });
                          }
                          setState(() {
                            isLoading = false;
                          });
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                        }
                      },btnText: 'LOGIN',),
                    ),
                    const SizedBox( height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Dont have an account?'),
                        InkWell(
                          onTap: () {
                            // Add navigation to the login page here
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationPage()));
                          },
                          child: Container(
                            child: const Text(
                              'Create New',
                              style: TextStyle(color: Color(0xff2e81ea)),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox( height: 20,),
                  ],
                ),
              ),
            ),
  )
      ),
    );
  }
}
