import 'dart:convert';
import 'package:disiniwork/Models/CateogoryModel.dart';
import 'package:disiniwork/Models/EducationModel.dart';
import 'package:disiniwork/Models/ExperienceModel.dart';
import 'package:disiniwork/components/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/SkillModel.dart';
import '../components/BuildInputDecoration.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

import 'PhoneNumberVeryfy.dart';


class ForceToAddBio extends StatefulWidget {
  const ForceToAddBio({super.key});

  @override
  State<ForceToAddBio> createState() => _UpdateProfilePageState();

}
class _UpdateProfilePageState extends State<ForceToAddBio> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username, fullName, categorySlug;

  TextEditingController dob = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController hourlyRate = TextEditingController();
  TextEditingController summary = TextEditingController();


  CategoryModel? selectedCategory;
  List<CategoryModel> categories = [];

  bool isLoading = false;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDetails();
  }

  void setDetails() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString('username').toString();
    });


    try{
      final Uri url = Uri.parse('$apiBaseUrl/getcategories');
      var response = await http.get(url);
      final responseData = json.decode(response.body);
      if(response.statusCode == 200){
        var _category = (responseData as List).map((item){
          return CategoryModel(item['id'], item['name'], item['slug']);
        }).toList();
        var _selectedCategory = _category.where((element) => element.slug == categorySlug);
        if(_selectedCategory.length > 0){
          setState(() {
            selectedCategory = _selectedCategory.first;
          });
        }
        setState(() {
          categories = _category;
        });
      }
    }catch(error){
      print('Error from category: ${error}');
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add biodata',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffF85301),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First name and last name
                        SizedBox(height: 20,),
                        // Profession
                        Container(
                          decoration:BoxDecoration(
                              color: Color(0xffffffff)
                          ),
                          child: TextFormField(
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Profession is required';
                              }else if(value.length < 10){
                                return 'Value should be more then 10 character';
                              }else if(value.length < 10){
                                return 'Value should be more then 10 character';
                              }else{
                                return null;
                              }
                            },
                            decoration: buildInputDecoration('Profession', Icons.book_outlined),
                            keyboardType: TextInputType.text,
                            controller: profession,
                          ),
                        ),
                        SizedBox(height: 20,),
                        // Category
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration:BoxDecoration(
                              color: Color(0xffffffff)
                          ),
                          child: DropdownButtonFormField<CategoryModel>(
                            validator: (CategoryModel? value) {
                              if (value == null) {
                                return 'Category is required';
                              }
                              return null; // Return null if the value is valid
                            },
                            decoration:buildInputDecoration('Category', Icons.category_outlined),
                            value: selectedCategory,
                            onChanged: (CategoryModel? newValue) {
                              setState(() {
                                selectedCategory = newValue;
                                print(jsonEncode(selectedCategory));
                                if (selectedCategory != null) {
                                  // Here, you can send selectedCategory.slug to the server
                                  //print("Selected Slug: ${selectedCategory!.slug}");
                                }
                              });
                            },
                            items: categories.map((CategoryModel category) {
                              return DropdownMenuItem<CategoryModel>(
                                value: category,
                                child: Text(category.name),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 20,),
                        // Hourly Rate
                        Container(
                          decoration:BoxDecoration(
                              color: Color(0xffffffff)
                          ),
                          child: TextFormField(
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Hourly rate is required';
                              }else{
                                return null;
                              }
                            },
                            decoration: buildInputDecoration('Hourly rate', Icons.hourglass_empty_outlined),
                            keyboardType: TextInputType.text,
                            controller: hourlyRate,
                          ),
                        ),
                        SizedBox(height: 20,),
                        // Summary
                        Container(
                          decoration:BoxDecoration(
                              color: Color(0xffffffff)
                          ),
                          child: TextFormField(
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Bio is required';
                              }else if(value.length < 100){
                                return 'Bio needs to be more the 100 character';
                              } else{
                                return null;
                              }
                            },
                            decoration: buildInputDecoration('Summary', Icons.text_fields_outlined),
                            keyboardType: TextInputType.text,
                            maxLines: 3,
                            controller: summary,
                          ),
                        ),
                        SizedBox(height: 20,),

                        SizedBox(height: 30,),
                        if (isLoading)
                          Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff031a38)), // Change this to your desired color
                              strokeWidth: 2,
                            ),
                          ),
                        const SizedBox(height: 10,),
                        Container(
                          height: 60,
                          child: CustomButton(
                            onPressed: () async{
                              setState(() {
                                isLoading = true;
                              });
                              if(_formKey.currentState!.validate()){
                                try{
                                  SharedPreferences pref = await SharedPreferences.getInstance();
                                  String token = pref.getString('token').toString();
                                  Map<String, dynamic> formData = {
                                    'overview':summary.text,
                                    'hourly_rate' : hourlyRate.text,
                                    'category_id' : selectedCategory!.slug,
                                    'professional_title' : profession.text,
                                  };
                                  print(formData);
                                  var response = await http.post(
                                    Uri.parse('$apiBaseUrl/updatebio'),
                                    body: formData,
                                    headers: {
                                      'Authorization': 'Bearer $token',
                                    },
                                  );
                                  if(response.statusCode == 400){
                                    final responseData = json.decode(response.body);
                                    //print(responseData['errors']['overview'][0]);
                                    _showSuccessDialog('Error', responseData['errors']['overview'][0]);
                                  }else{
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return PhoneNumberVerify();
                                        },
                                      ),
                                    );
                                  }
                                }catch(error){
                                  print('Profile update error: $error');
                                  _showSuccessDialog('error', '$error');
                                }
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                            btnText: 'SAVE BIO',
                          ),
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  )
              )

            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(String msgTitle, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msgTitle, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          content: Text(msg, style: TextStyle(fontSize: 16.0)),
          actions: [
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
}


