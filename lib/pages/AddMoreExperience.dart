import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/BuildInputDecoration.dart';
import '../components/CustomButton.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
class AddMoreExperience extends StatefulWidget {
  const AddMoreExperience({super.key});

  @override
  State<AddMoreExperience> createState() => _AddMoreExperienceState();
}

class _AddMoreExperienceState extends State<AddMoreExperience> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController webSite = TextEditingController();
  TextEditingController description = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Experience'),
        backgroundColor: Color(0xff031a38),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Container(
                      decoration:BoxDecoration(
                          color: Color(0xffffffff)
                      ),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Job Title is required';
                          }else{
                            return null;
                          }
                        },
                        decoration: buildInputDecoration('Job Title', Icons.title_outlined),
                        //maxLength: 11,
                        keyboardType: TextInputType.text,
                        controller: title,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration:BoxDecoration(
                          color: Color(0xffffffff)
                      ),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Duration is required';
                          }else{
                            return null;
                          }
                        },
                        decoration: buildInputDecoration('Duration', Icons.title_outlined),
                        //maxLength: 11,
                        keyboardType: TextInputType.text,
                        controller: duration,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration:BoxDecoration(
                          color: Color(0xffffffff)
                      ),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Company Name is required';
                          }else{
                            return null;
                          }
                        },
                        decoration: buildInputDecoration('Company Name', Icons.title_outlined),
                        //maxLength: 11,
                        keyboardType: TextInputType.text,
                        controller: companyName,
                      ),
                    ),
                    // Website
                    SizedBox(height: 20,),
                    Container(
                      decoration:BoxDecoration(
                          color: Color(0xffffffff)
                      ),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Website is required';
                          } else {
                            final urlPattern = RegExp(
                              r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
                              caseSensitive: false,
                            );
                            if (!urlPattern.hasMatch(value)) {
                              return 'Enter a valid website URL';
                            }
                            return null;
                          }
                        },
                        decoration: buildInputDecoration('Website', Icons.title_outlined),
                        keyboardType: TextInputType.text,
                        controller: webSite,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration:BoxDecoration(
                          color: Color(0xffffffff)
                      ),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Description is required';
                          }else{
                            return null;
                          }
                        },
                        decoration: buildInputDecoration('Description', Icons.title_outlined),
                        //maxLength: 11,
                        keyboardType: TextInputType.text,
                        controller: description,
                      ),
                    ),
                    if(isLoading)
                      SizedBox(height: 20,),
                    if (isLoading)
                      Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff031a38)), // Change this to your desired color
                          strokeWidth: 2,
                        ),
                      ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      child: CustomButton(
                        btnText: 'Set Experience',
                        onPressed: () async{
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              isLoading = true;
                            });
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            String token = pref.getString('token').toString();
                            Map<String, dynamic> formData = {
                              'title': title.text,
                              'duration' : duration.text,
                              'company_name' : companyName.text,
                              'website' : webSite.text,
                              'description' : description.text
                            };
                            //print(formData);return;
                            try{
                              var response = await http.post(
                                  Uri.parse('$apiBaseUrl/addexperince'),
                                  headers: {
                                    'Authorization': 'Bearer $token',
                                  },
                                  body: formData
                              );
                              if(response.statusCode == 200){
                                Navigator.of(context).pop(true);
                              }else{
                                Navigator.of(context).pop(false);
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }catch(error){
                              setState(() {
                                print('Error: $error');
                                isLoading = false;
                              });
                            }

                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

}
