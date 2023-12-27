import 'dart:async';
import 'dart:convert';
import 'package:disiniwork/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../components/CustomButton.dart';
import '../constants.dart';

class PhoneNumberVerify extends StatefulWidget {
  const PhoneNumberVerify({Key? key}) : super(key: key);

  @override
  State<PhoneNumberVerify> createState() => _PhoneNumberVerifyState();
}

class _PhoneNumberVerifyState extends State<PhoneNumberVerify> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();
  String initialCountry = 'BD'; // Initial country selection
  int timerDuration = 120; // 2 minutes in seconds
  late Timer timer;
  String timerText = '';
  List<String> countryCode = [];
  String? phoneNumberWithPrefix, countryCodeStr;
  bool isTimerActive = false;
  String phoneNumber = '';
  int currentStep = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCountryAndCode();
  }

  getCountryAndCode() async {
    try {
      final Uri url = Uri.parse('$apiBaseUrl/countryandcode');
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token').toString();
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          countryCode.add(responseData.country_code);
          phoneNumberWithPrefix = responseData.telephonePrefix;
          countryCodeStr = responseData.country_code;
        });
      }
    } catch (error) {
      print('Error: ${error}');
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timerDuration > 0) {
          timerDuration--;
          int minutes = timerDuration ~/ 60;
          int seconds = timerDuration % 60;
          timerText = '$minutes:${seconds.toString().padLeft(2, '0')}';
        } else {
          timer.cancel();
          timerText = 'Time Expired';
          isTimerActive = false;
          currentStep = 1; // Move to the next step (OTP entry)
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verify Phone number',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffF85301),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (currentStep == 1)
            // Country dropdown, phone field, and send OTP button
              Column(
                children: [
                  InternationalPhoneNumberInput(
                    countries: countryCode,
                    onInputChanged: (PhoneNumber number) {
                      phoneNumber = number.phoneNumber ?? '';
                    },
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    initialValue: PhoneNumber(isoCode: initialCountry),
                  ),
                  SizedBox(height: 24.0),
                  !isLoading ? CustomButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (!isTimerActive) {
                        try {
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          String token = pref.getString('token').toString();
                          Map<String, dynamic> formData = {
                            'phone': phoneNumber.toString(),
                            'country_code': countryCodeStr.toString(),
                          };
                          var response = await http.post(
                              Uri.parse('$apiBaseUrl/verifyphone'),
                              headers: {
                                'Authorization': 'Bearer '+token.toString(),
                              },
                              body: formData
                          );
                          final responseData = json.decode(response.body);
                          if (response.statusCode == 200) {
                            print('Send message');
                            setState(() {
                              isTimerActive = true;
                              currentStep = 2; // Move to the next step (Timer active)
                            });
                            startTimer();
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            print('Server error ${responseData}');
                          }
                        } catch (error) {
                          setState(() {
                            isLoading = false;
                          });
                          print('Error on submit for verification: ${error}');
                        }
                      }
                    },
                    btnText: 'SEND OTP',
                  ) : const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xff031a38)), // Change this to your desired color
                    strokeWidth: 2,
                  ),
                ],
              ),
            if (currentStep == 2)
            // Timer display
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  timerText,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            if (currentStep == 2)
            // OTP entry input field and submit button
              Column(
                children: [
                  TextField(
                    controller: otpCodeController,
                    decoration: InputDecoration(labelText: 'Enter OTP'),
                  ),
                  SizedBox(height: 24.0),
                  CustomButton(
                    onPressed: () async{

                      try {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        String token = pref.getString('token').toString();
                        Map<String, dynamic> formData = {
                          'otp': otpCodeController.text,
                          'phone' : phoneNumber.toString(),
                          // Add any other data you need to submit
                        };
                        var response = await http.post(
                          Uri.parse('$apiBaseUrl/verifyOtpAndUpdatePhone'),
                          headers: {
                            'Authorization': 'Bearer ' + token.toString(),
                          },
                          body: formData,
                        );
                        final responseData = json.decode(response.body);
                        if (response.statusCode == 200) {
                          // Handle success, e.g., navigate to the next screen
                          print('OTP submitted successfully');
                          // Add any additional logic or navigation here
                        } else {
                          print('Server error ${responseData}');
                          // Handle the error, e.g., show an error message to the user
                        }
                      } catch (error) {
                        print('Error on OTP submission: ${error}');
                        // Handle the error, e.g., show an error message to the user
                      }

                    },
                    btnText: 'SUBMIT',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Validation is successful', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          content: const Text('Go to login page', style: TextStyle(fontSize: 16.0)),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(fontSize: 16.0, color: Colors.blue),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
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
}