import 'dart:convert';

import 'package:disiniwork/constants.dart';
import 'package:disiniwork/pages/EmailOtpValidation.dart';
import 'package:flutter/material.dart';
import 'package:disiniwork/components/CustomButton.dart';
import 'package:disiniwork/pages/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  bool isChecked = true;
  final _formKey = GlobalKey<FormState>();
  List<String> roles = ['user', 'client'];
  String? selectedRole;
  String? duplicateEmailError;
  bool isLoading = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Text('Create Account',style: TextStyle(
                      color: Color(0xFF434242),
                      fontSize: 30
                  )),
                  const SizedBox(height: 10,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text(
                        'Do you have a GIG, You have it - We need it',
                        style: TextStyle(
                          color: Color(0xFF3a3b3b),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15,),

                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: SocialButton(btnText: 'Continue with Facebook', path: 'lib/images/f_logo.png', onPressed: (){}),
                  // ),
                  //
                  // const SizedBox(height: 15,),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: SocialButton(btnText: 'Continue with Google', path: 'lib/images/google_logo.png', onPressed: (){}),
                  // ),
                  //
                  // const SizedBox(height: 15,),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: SocialButton(btnText: 'Continue with Apple ID', path: 'lib/images/apple_logo.png', onPressed: (){}),
                  // ),
                  //
                  // const SizedBox(height: 20,),
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
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: firstNameCtrl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b))
                        ),
                        hintText: 'First name'
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                      controller: lastNameCtrl,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b))
                        ),
                        hintText: 'Last name'
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b))
                        ),
                        hintText: 'Email'
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      //height: 60,
                      child: DropdownButtonFormField<String>(
                        value: selectedRole,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedRole = newValue;
                          });
                        },
                        items: roles.map((String role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b)),
                          ),
                          hintText: 'Select Role',
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a role';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
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
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your confirm password';
                        }else if (value != passwordCtrl.text) {
                          return 'Passwords do not match';
                        }else if(value.length < 5){
                          return 'Password length should atleast 6';
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
                          'I agree to the privacy policy', // Your privacy agreement text
                          style: TextStyle(
                            color: Color(0xff1d1c1c),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox( height: 5,),
                  if(duplicateEmailError != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(duplicateEmailError.toString(),textAlign: TextAlign.left,style: const TextStyle(fontSize: 12, color: Colors.redAccent),),
                    ),
                  if (isLoading)
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xff031a38)), // Change this to your desired color
                      strokeWidth: 2,
                    ),const SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: isChecked ? CustomButton(
                      onPressed: () async {
                        setState(() {
                          duplicateEmailError = '';
                        });
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            isLoading = true;
                          });
                          final Uri url = Uri.parse('$apiBaseUrl/register');
                          Map<String, dynamic> formData = {
                            'first_name':firstNameCtrl.text,
                            'last_name' : lastNameCtrl.text,
                            'email': emailCtrl.text,
                            'password': passwordCtrl.text,
                            'password_confirmation': confirmPasswordCtrl.text,
                            'role' : selectedRole,
                          };
                          try {

                            final response = await http.post(
                              url,
                              body: formData,
                            );
                            if (response.statusCode == 200) {
                              final Map<String, dynamic> responseData = json.decode(response.body);
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('token', responseData['data']['token']);
                              prefs.setString('email', emailCtrl.text);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailOtpValidation(emailAddress: emailCtrl.text),
                                ),
                              );
                            } else {
                              final Map<String, dynamic> responseData = json.decode(response.body);
                              if(responseData['data'].containsKey('email')){
                                setState(() {
                                  duplicateEmailError = responseData['data']['email'][0];
                                });
                              }
                            }
                            setState(() {
                              isLoading = false;
                            });
                          } catch (error) {
                            print('Error: $error');
                            setState(() {
                              isLoading= false;
                            });
                            // Handle any connection or request error here.
                          }

                          //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                        }
                      },
                      btnText: 'SIGN UP',
                    ) : const Text('Please agree with our tarms and cond'),
                  ),
                  const SizedBox( height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      InkWell(
                        onTap: () {
                          // Add navigation to the login page here
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                        },
                        child: Container(
                          child: const Text(
                            'Login',
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
      )
    );
  }
}
