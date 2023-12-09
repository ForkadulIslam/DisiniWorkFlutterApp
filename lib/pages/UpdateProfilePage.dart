import 'dart:convert';
import 'package:disiniwork/Models/CateogoryModel.dart';
import 'package:disiniwork/Models/EducationModel.dart';
import 'package:disiniwork/Models/ExperienceModel.dart';
import 'package:disiniwork/components/CustomButton.dart';
import 'package:disiniwork/components/SkillBadge.dart';
import 'package:disiniwork/pages/AddMoreEducation.dart';
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
import 'package:intl/intl.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();

}
class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username, fullName, categorySlug;
  int identity = 0;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController zip = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController hourlyRate = TextEditingController();
  TextEditingController summary = TextEditingController();

  late Map<String, dynamic> portfolios;

  CategoryModel? selectedCategory;
  List<CategoryModel> categories = [];


  List<SkillModel> skills = [];
  bool isLoading = false;

  List<EducationModel> education = [];
  List<ExperienceModel> experience = [];


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
      final Uri url = Uri.parse('$apiBaseUrl/getuserdetails/$username');
      var response = await http.get(url);
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(username);
      if(response.statusCode == 200){
        firstName.text = responseData['data']['first_name'];
        lastName.text = responseData['data']['last_name'];
        email.text = pref.getString('email').toString();
        address.text = responseData['data']['address'] ?? '';
        zip.text = responseData['data']['zip'] ?? '';
        state.text = responseData['data']['state'] ?? '';
        city.text = responseData['data']['city'] ?? '';
        country.text = responseData['data']['country'] ?? '';
        dob.text = responseData['data']['dob'] ?? '';
        profession.text = responseData['data']['professional_title'] ?? '';
        hourlyRate.text = responseData['data']['hourly_rate'] ?? '';
        summary.text = responseData['data']['overview'] ?? '';
        var _skills = (responseData['data']['skills'] as List).map((item){
          return SkillModel(item['pivot']['skill_id'], item['name'], item['slug'],false);
        }).toList();
        setState(() {
          categorySlug = responseData['data']['category_id'];
          fullName = responseData['data']['fullname'];
          identity = int.parse(responseData['data']['identity']);
          skills = _skills;
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

    getEducation();
    getExperience();

  }

  getEducation() async{
    try{
      final Uri url = Uri.parse('$apiBaseUrl/geteducations/$username');
      var response = await http.get(url);
      if(response.statusCode == 200){
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> educationData = responseData['data'];
        List<EducationModel> _education = educationData.map((item){
          return EducationModel.fromJson(item);
        }).toList();
        setState(() {
          education = _education;
        });
      }

    }catch(error){
      print('Error from Get Education $error');
    }
  }

  getExperience() async{
    try{
      final Uri url = Uri.parse('$apiBaseUrl/getexperince/$username');
      var response = await http.get(url);
      if(response.statusCode == 200){
        Map<String, dynamic> jsonDecodedResponse = jsonDecode(response.body);
        List<dynamic> responseData = jsonDecodedResponse['data'];
        List<ExperienceModel> _experience = responseData.map((item){
          return ExperienceModel(
            id: item['id'],
            title: item['title'],
            companyName: item['company_name'],
            duration: item['duration'],
            description: item['description']
          );
        }).toList();

        setState(() {
          experience = _experience;
        });

      }

    }catch(error){
      print('Error from GetExperience: $error');
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
                              'https://api.disiniwork.com/uploads/profiles/avatar.jpg',
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
                      // First name and last name
                      Row(
                        children: [
                          Expanded(
                            child: Container(
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
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Container(
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
                          )
                        ],
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
                      SizedBox(height: 10,),

                      Divider(
                        color: Color(0xffa9a9a9),
                      ),
                      SizedBox(height: 10,),
                      // Address
                      Container(
                        decoration:BoxDecoration(
                            color: Color(0xffffffff)
                        ),
                        child: TextFormField(
                          validator: (value){
                            if (value!.isEmpty) {
                              return 'Address is required';
                            } else if (value.length < 5) {
                              return 'Address must be at least 5 characters';
                            }
                          },
                          decoration: buildInputDecoration('Address', Icons.location_city_outlined),
                          //maxLength: 11,
                          keyboardType: TextInputType.text,
                          controller: address,
                        ),
                      ),
                      SizedBox(height: 20,),
                      //State and zip
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Zip is required';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: buildInputDecoration('Zip', Icons.location_history_outlined),
                                keyboardType: TextInputType.text,
                                controller: zip,
                              ),
                            ),
                          ),
                          SizedBox(width: 20), // Add some space between the input fields
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'State is required';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: buildInputDecoration('State', Icons.location_history_outlined),
                                keyboardType: TextInputType.text,
                                controller: state,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      //City and country
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration:BoxDecoration(
                                  color: Color(0xffffffff)
                              ),
                              child: TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'City is required';
                                  }else{
                                    return null;
                                  }
                                },
                                decoration: buildInputDecoration('City', Icons.location_history_outlined),
                                //maxLength: 11,
                                keyboardType: TextInputType.text,
                                controller: city,
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          //Country
                          Expanded(
                            child: Container(
                              decoration:BoxDecoration(
                                  color: Color(0xffffffff)
                              ),
                              child: TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Country is required';
                                  }else{
                                    return null;
                                  }
                                },
                                decoration: buildInputDecoration('Country', Icons.location_history_outlined),
                                //maxLength: 11,
                                keyboardType: TextInputType.text,
                                controller: country,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      //DOB
                      Container(
                        decoration:BoxDecoration(
                            color: Color(0xffffffff)
                        ),
                        child: TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Date of birth is required';
                            }else{
                              return null;
                            }
                          },
                          decoration: buildInputDecoration('Date of birth', Icons.calendar_month_outlined),
                          //maxLength: 11,
                          keyboardType: TextInputType.text,
                          controller: dob,
                          onTap: () async{
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: Colors.blue, // Change the primary color to your desired color
                                    hintColor: Color(0xffff7519), // Change the accent color to your desired color
                                    colorScheme: ColorScheme.light(primary: Colors.blue), // Change primary color scheme
                                    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                dob.text = formattedDate;
                              });
                            } else {}
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Divider(
                        color: Color(0xffa9a9a9),
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

                      // Education
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'EDUCATION',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Color(0xffff7519)),
                                onPressed: () async{
                                  bool addEducationStatus = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMoreEducation()));
                                  if(addEducationStatus){
                                    getEducation();
                                  }
                                },
                              ),
                            ],
                          ),
                          // List of education details
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: education.length,
                            itemBuilder: (context, index) {
                              final _education = education[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                                child: Card(
                                  elevation: 3,
                                  child: ListTile(
                                    title: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(_education.title ?? '',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 2,),
                                        Text(_education.uni ?? '', style: TextStyle(fontSize: 12),),
                                        SizedBox(height: 2,),
                                        Text(_education.duration ?? '', style: TextStyle(fontSize: 12),),
                                        SizedBox(height: 10,)
                                      ],
                                    ),
                                    onTap: () {
                                      print(index);
                                      // Add onTap logic if needed
                                    },
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () async{
                                        try{
                                          SharedPreferences pref = await SharedPreferences.getInstance();
                                          String token = pref.getString('token').toString();
                                          int educationId = education[index].id!;
                                          print('$apiBaseUrl/delete-education/$educationId');
                                          final Uri url = Uri.parse('$apiBaseUrl/delete-education/$educationId');
                                          var response = await http.post(url,headers:{'Authorization':'Bearer $token'});
                                          if(response.statusCode == 200){
                                            setState(() {
                                              education.removeAt(index);
                                            });
                                          }
                                        }catch(error){
                                          print('Error: $error');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Divider(
                        color: Color(0xffa9a9a9),
                      ),

                      // Portfolio
                      // Column(
                      //   children: [
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         Text(
                      //           'PORTFOLIO',
                      //           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      //         ),
                      //         IconButton(
                      //           icon: Icon(Icons.add, color: Color(0xffff7519)),
                      //           onPressed: () {
                      //             Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMorePortfolio()));
                      //           },
                      //         ),
                      //       ],
                      //     ),
                      //     Column(
                      //         children: []
                      //     ),
                      //   ],
                      // ),
                      // Divider(
                      //   color: Color(0xffa9a9a9),
                      // ),
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
                                onPressed: () async{
                                  bool? addExperience =  await Navigator.push(context, MaterialPageRoute(builder: (context) => AddMoreExperience()));
                                  if(addExperience!){
                                    getExperience();
                                  }

                                },
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: experience.length,
                            itemBuilder: (context, index) {
                              final _expe = experience[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                                child: Card(
                                  elevation: 3,
                                  child: ListTile(
                                    title: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(_expe.title ?? '',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 2,),
                                        Text(_expe.companyName ?? '', style: TextStyle(fontSize: 12),),
                                        SizedBox(height: 2,),
                                        Text(_expe.duration ?? '', style: TextStyle(fontSize: 12),),
                                        SizedBox(height: 10,)
                                      ],
                                    ),
                                    onTap: () {
                                      print(index);
                                      // Add onTap logic if needed
                                    },
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () async{
                                        try{
                                          SharedPreferences pref = await SharedPreferences.getInstance();
                                          String token = pref.getString('token').toString();
                                          int experienceId = experience[index].id!;
                                          print('$apiBaseUrl/delete-education/$experienceId');
                                          final Uri url = Uri.parse('$apiBaseUrl/delete-experience/$experienceId');
                                          var response = await http.post(url,headers:{'Authorization':'Bearer $token'});
                                          if(response.statusCode == 200){
                                            setState(() {
                                              experience.removeAt(index);
                                            });
                                          }
                                        }catch(error){
                                          print('Error: $error');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
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
                                await http.post(
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
                                await http.post(
                                  Uri.parse('$apiBaseUrl/addSelectedSkills'),
                                  headers: {
                                    'Authorization': 'Bearer $token',
                                    'Content-Type': 'application/json',
                                  },
                                  body: skillDataJson,
                                );

                                Map<String, dynamic> personalProfileFormData = {
                                  'first_name': firstName.text,
                                  'last_name' : lastName.text,
                                  'address' : address.text,
                                  'zip' : zip.text,
                                  'state' : state.text,
                                  'city' : city.text,
                                  'country': country.text,
                                  'dob' : dob.text
                                };
                                await http.post(
                                  Uri.parse('$apiBaseUrl/updatepersonalprofile'),
                                  headers: {
                                    'Authorization': 'Bearer $token',
                                  },
                                  body: personalProfileFormData,
                                );
                                _showSuccessDialog('Profile update request is completed');
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


