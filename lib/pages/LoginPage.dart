import 'package:flutter/material.dart';
import 'package:disiniwork/pages/RegistrationPage.dart';
import 'package:disiniwork/components/CustomButton.dart';
import 'package:disiniwork/components/SocialButton.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffefeff),
      body:SafeArea(
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
                  Text('Login',style: TextStyle(
                      color: Color(0xFF434242),
                      fontSize: 30
                  )),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Lorium Spun doller sit amit This is a sample text decription for registration process',
                        style: TextStyle(
                          color: Color(0xFF3a3b3b),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SocialButton(btnText: 'Continue with Facebook', path: 'lib/images/f_logo.png', onPressed: (){}),
                  ),

                  const SizedBox(height: 15,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SocialButton(btnText: 'Continue with Google', path: 'lib/images/google_logo.png', onPressed: (){}),
                  ),

                  const SizedBox(height: 15,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SocialButton(btnText: 'Continue with Apple ID', path: 'lib/images/apple_logo.png', onPressed: (){}),
                  ),

                  const SizedBox(height: 20,),
                  Padding(
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff8b8b8b))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff8b8b8b))
                          ),
                          hintText: 'Email Or User Name'
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
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
                  const SizedBox(height: 5,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: Color(0xff2e81ea))
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
                        Text(
                          'Remember this device', // Your privacy agreement text
                          style: TextStyle(
                            color: Color(0xff1d1c1c),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox( height: 30,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(onTap: (){
                      print('test');
                    },btnText: 'LOGIN',),
                  ),
                  const SizedBox( height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont have an account?'),
                      InkWell(
                        onTap: () {
                          // Add navigation to the login page here
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                        },
                        child: Container(
                          child: Text(
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
  )
      ),
    );
  }
}