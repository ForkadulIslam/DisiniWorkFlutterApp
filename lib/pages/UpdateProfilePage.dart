// ignore_for_file: prefer_const_constructors

import 'package:disiniwork/components/PortfolioUploader.dart';
import 'package:disiniwork/pages/AddMoreExperience.dart';
import 'package:disiniwork/pages/AddMorePortfolio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ColorSupport.dart';
import '../components/BuildInputDecoration.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();

}
class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  String? username;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController hourlyRate = TextEditingController();
  TextEditingController summary = TextEditingController();

  late Map<String, dynamic> portfolios;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDetails();
  }

  void setDetails() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String username = pref.getString('username').toString();
    try{
      final Uri url = Uri.parse('$apiBaseUrl/');
      var response = await http.post(url, body: formData);
      final Map<String, dynamic> responseData = json.decode(response.body);
    }catch(error){
      print('Error: ${error}');
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
                              "Kelly Clarkson",
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
                          controller: firstName,
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
                              return 'Email is required';
                            }else{
                              return null;
                            }
                          },
                          decoration: buildInputDecoration('Email', Icons.email_outlined),
                          keyboardType: TextInputType.text,
                          controller: firstName,
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
                              return 'Profession is required';
                            }else{
                              return null;
                            }
                          },
                          decoration: buildInputDecoration('Profession', Icons.book_outlined),
                          keyboardType: TextInputType.text,
                          controller: firstName,
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
                              return 'Hourly rate is required';
                            }else{
                              return null;
                            }
                          },
                          decoration: buildInputDecoration('Hourly rate', Icons.hourglass_empty_outlined),
                          keyboardType: TextInputType.text,
                          controller: firstName,
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
                              return 'Summary is required';
                            }else{
                              return null;
                            }
                          },
                          decoration: buildInputDecoration('Summary', Icons.text_fields_outlined),
                          keyboardType: TextInputType.text,
                          controller: firstName,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Divider(
                        color: Color(0xffa9a9a9),
                      ),
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
}
