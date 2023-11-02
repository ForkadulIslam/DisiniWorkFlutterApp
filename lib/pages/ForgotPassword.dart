import 'dart:convert';

import 'package:disiniwork/pages/PasswordRessetOtpValidation.dart';
import 'package:flutter/material.dart';

import '../components/CustomButton.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;
  String? serverErrorResp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffefeff),
      body: SafeArea(
        child: SingleChildScrollView(
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
                const Text('Forgot Password?',style: TextStyle(
                    color: Color(0xFF434242),
                    fontSize: 30
                )),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Please provide us your email address, we will send you the instruction',
                    style: TextStyle(
                        color: Color(0xFF434242),
                        fontSize: 12
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 100,),
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
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8b8b8b))
                        ),
                        hintText: 'Your email address'
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                if (isLoading)
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xff031a38)), // Change this to your desired color
                    strokeWidth: 2,
                  ),
                if(isLoading)
                  const SizedBox( height: 20,),
                if(serverErrorResp != null)
                  Text(serverErrorResp!,style: const TextStyle(fontSize: 13),), const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(onPressed:  () async{
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        isLoading = true;
                      });
                      Map<String, dynamic> formData = {
                        'email': emailController.text,
                      };
                      try{
                        final Uri url = Uri.parse('$apiBaseUrl/forgotpassword');
                        var response = await http.post(url, body: formData);
                        final Map<String, dynamic> responseData = json.decode(response.body);

                        if(response.statusCode == 200){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ResetPassword(email: emailController.text)),
                          );
                        }else{
                          print(responseData['data']['error']);
                          setState(() {
                            serverErrorResp = responseData['data']['error'];
                          });
                        }
                      }catch(error){
                        print('API Error: $error');
                        setState(() {
                          serverErrorResp = error.toString();
                        });
                      }
                      setState(() {
                        isLoading = false;
                      });
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                    }
                  },btnText: 'SUBMIT',),
                ),
                const SizedBox( height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
