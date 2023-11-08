// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:disiniwork/Models/CateogoryModel.dart';
import 'package:disiniwork/components/CustomButton.dart';
import 'package:disiniwork/components/SkillBadge.dart';
import 'package:disiniwork/pages/AddMoreExperience.dart';
import 'package:disiniwork/pages/AddMorePortfolio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../Models/SkillModel.dart';
import '../components/BuildInputDecoration.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

import 'AddMoreSkills.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();

}
class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username, fullName, categorySlug;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController hourlyRate = TextEditingController();
  TextEditingController summary = TextEditingController();

  late Map<String, dynamic> portfolios;

  CategoryModel? selectedCategory;
  List<CategoryModel> categories = [];


  List<SkillModel> skills = [];
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
      final Uri url = Uri.parse('$apiBaseUrl/getuserdetails/${username}');
      var response = await http.get(url);
      final Map<String, dynamic> responseData = json.decode(response.body);
      if(response.statusCode == 200){
        firstName.text = responseData['data']['first_name'];
        lastName.text = responseData['data']['last_name'];
        email.text = pref.getString('email').toString();
        profession.text = responseData['data']['professional_title'] ?? '';
        hourlyRate.text = responseData['data']['hourly_rate'] ?? '';
        summary.text = responseData['data']['overview'] ?? '';
        setState(() {
          categorySlug = responseData['data']['category_id'];
          fullName = responseData['data']['fullname'];
          skills = (responseData['data']['skills'] as List).map((item){
            return SkillModel(item['pivot']['skill_id'], item['name'], item['slug'],false);
          }).toList();
        });
      }
    }catch(error){
      print('Error from user details: ${error}');
    }

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
        backgroundColor: Color(0xff031A38),
        title: Text('Manage profile information', style: TextStyle(fontSize: 15),),
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
                height: MediaQuery.of(context).size.height*0.2,
                decoration: BoxDecoration(
                    color: Color(0xff031A38),
                ),
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xffdfdfdfdf), // Add a border color if needed
                              width: 1.0, // Border width
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              'https://s3-alpha-sig.figma.com/img/496c/95c4/25fa5984f82805fb652f48c0ba21f7d4?Expires=1699228800&Signature=e5MDVR~sUTKnwrX3fIczqtqZ7ccsdWwxenxCz9pa90B6gvsOGpcLte67p4Z91GNxZMARWWRc-CJ6AIgYHiR4IYaoSbwg6CGERxPnhCCUi-uKh8De9uiY~i0pPGQw1yWhg~anoOQsplJUxPJ8UEYsBjsNORk3n~ZV401eCmzwj7qZVdfWu9pHjqRuQRfQ6TMz0d-F6VAhV67YTO293gapPtOf7QpMvPF2PLfBis1sP0I0ysfHbqzmq4MJBN6kGyrQm35JdptjGbCsgPFLPgpPTnnI0NfnrzMYj~UxHFEhgHPbGEQ7ZvF8VNUNy5rbSBchZ8OFO7QSbSjxs01bBbYAwA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4',
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                        : null,
                                  );
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text('Error loading image'),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "$fullName",
                              style:TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffffffff),
                                height: 15/12,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "Online",
                              style:TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffffffff),
                                height: 15/12,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 15,)
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 20, // Adjust the top position as needed
                      right: 0, // Adjust the right position as needed
                      child: Container(
                        width: 30, // Adjust the width of the container as needed
                        height: 30, // Adjust the height of the container as needed
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white12, // Border color
                            width: 5.0, // Border width
                          ),
                        ),
                        child: Icon(
                          Icons.photo_camera,
                          color: Colors.white,
                          size: 15, // Adjust the size of the camera icon as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First name
                      Container(
                        decoration:BoxDecoration(
                            color: Color(0xffffffff)
                        ),
                        child: TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'First name is required';
                            }else{
                              return null;
                            }
                          },
                          decoration: buildInputDecoration('First name', Icons.person),
                          //maxLength: 11,
                          keyboardType: TextInputType.text,
                          controller: firstName,
                        ),
                      ),
                      SizedBox(height: 20,),
                      // Lst Name
                      Container(
                        decoration:BoxDecoration(
                            color: Color(0xffffffff)
                        ),
                        child: TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Last name required';
                            }else{
                              return null;
                            }
                          },
                          decoration: buildInputDecoration('Last name', Icons.person_outline),
                          keyboardType: TextInputType.text,
                          controller: lastName,
                        ),
                      ),
                      SizedBox(height: 20,),
                      // Email
                      Container(
                        decoration:BoxDecoration(
                            color: Color(0xffffffff)
                        ),
                        child: TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Email is required';
                            }else{
                              return null;
                            }
                          },
                          decoration: buildInputDecoration('Email', Icons.email_outlined),
                          keyboardType: TextInputType.text,
                          controller: email,
                        ),
                      ),
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
                      Divider(
                        color: Color(0xffa9a9a9),
                      ),
                      // Skills
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'SKILLS',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Color(0xffff7519)),
                                onPressed: () async{
                                  List<SkillModel> _selectedSkills =  await Navigator.push(context, MaterialPageRoute(builder: (context) => AddMoreSkills(selectedSkills: skills,)));
                                  if (_selectedSkills != null) {
                                    setState(() {
                                      skills = _selectedSkills;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: skills.length,
                            itemBuilder: (context, index) {
                              final item = skills[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                                child: SkillBadge(
                                  name: item.name,
                                  onDelete: (itemName) {
                                    print(itemName);
                                  },
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      Divider(
                        color: Color(0xffa9a9a9),
                      ),

                      // Portfolio
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'PORTFOLIO',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Color(0xffff7519)),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMorePortfolio()));
                                },
                              ),
                            ],
                          ),
                          Column(
                              children: []
                          ),
                        ],
                      ),
                      Divider(
                        color: Color(0xffa9a9a9),
                      ),
                      // Experience
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'EXPERIENCE',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Color(0xffff7519)),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMoreExperience()));
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [

                            ],
                          ),
                        ],
                      ),

                      Divider(
                        color: Color(0xffa9a9a9),
                      ),
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
                                var response = await http.post(
                                  Uri.parse('$apiBaseUrl/updatebio'),
                                  body: formData,
                                  headers: {
                                    'Authorization': 'Bearer $token',
                                  },
                                );
                                final List<int> skillIds = skills.map((skill) => skill.id).toList();
                                final Map<String, dynamic> skillFormData = {
                                  "selectedSkills": skillIds,
                                };

                                final String skillDataJson = jsonEncode(skillFormData);
                                final saveSkillResponse = await http.post(
                                  Uri.parse('$apiBaseUrl/addSelectedSkills'),
                                  headers: {
                                    'Authorization': 'Bearer $token',
                                    'Content-Type': 'application/json', // Set the content type to JSON
                                  },
                                  body: skillDataJson, // Send JSON data
                                );
                                print(saveSkillResponse.body);
                                Map<String, dynamic> res = json.decode(saveSkillResponse.body);

                                if(saveSkillResponse.statusCode == 200){
                                  _showSuccessDialog('Profile request is successful');
                                }
                              }catch(error){
                                print('Profile update error: $error');
                                _showSuccessDialog('$error');
                              }
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          btnText: 'UPDATE PROFILE',
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

  void _showSuccessDialog(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Action successful', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
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
