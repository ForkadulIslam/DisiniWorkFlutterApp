import 'dart:convert';

import 'package:disiniwork/Models/EducationModel.dart';
import 'package:disiniwork/components/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/BuildInputDecoration.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
class AddMoreEducation extends StatefulWidget {
  const AddMoreEducation({super.key});

  @override
  State<AddMoreEducation> createState() => _AddMoreEducationState();
}

class _AddMoreEducationState extends State<AddMoreEducation> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController uni = TextEditingController();
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
        title: Text('Add education'),
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
                          return 'Title is required';
                        }else{
                          return null;
                        }
                      },
                      decoration: buildInputDecoration('Title', Icons.title_outlined),
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
                          return 'Institution is required';
                        }else{
                          return null;
                        }
                      },
                      decoration: buildInputDecoration('Institution', Icons.title_outlined),
                      //maxLength: 11,
                      keyboardType: TextInputType.text,
                      controller: uni,
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
                      btnText: 'Set Education',
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            isLoading = true;
                          });
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          String token = pref.getString('token').toString();
                          Map<String, dynamic> formData = {
                            'title': title.text,
                            'uni' : uni.text,
                            'duration' : duration.text,
                            'description' : description.text
                          };
                          try{
                            var response = await http.post(
                                Uri.parse('$apiBaseUrl/addeducations'),
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
