import 'package:disiniwork/components/CustomButton.dart';
import 'package:flutter/material.dart';

import '../components/BuildInputDecoration.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class AddMorePortfolio extends StatefulWidget {
  const AddMorePortfolio({super.key});

  @override
  State<AddMorePortfolio> createState() => _AddMorePortfolioState();
}

class _AddMorePortfolioState extends State<AddMorePortfolio> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description  = TextEditingController();

  File? image; // Store the selected image

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadData() async {
    print('Clicked');
    //return;
    // Implement the logic to upload data (title, description, and image) to the server here
    if (image != null) {
      // You can use the http package to send data to the server
      final url = Uri.parse('your_server_endpoint_here');
      final request = http.MultipartRequest('POST', url);
      request.fields['title'] = title.text;
      request.fields['description'] = description.text;
      request.files.add(await http.MultipartFile.fromPath('image', image!.path));
      final response = await request.send();

      if (response.statusCode == 200) {
        // Successfully uploaded data
        print('Data uploaded successfully');
        // You can add further actions here
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add portfolio'),
        backgroundColor: Color(0xff031a38),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Description is required';
                              } else {
                                return null;
                              }
                            },
                            decoration: buildInputDecoration('Description', Icons.text_fields_outlined),
                            keyboardType: TextInputType.multiline, // Use TextInputType.multiline
                            maxLines: 5, // Set the number of lines you want to allow
                            controller: description,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              //padding: ,
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0xffecebeb),
                                //border: Border.all(color: Colors.grey),
                              ),
                              child: image != null
                                  ? Center(
                                child: Image.file(image!),
                              )
                                  : Icon(Icons.add_a_photo_outlined,color: Color(0xffff7519),size: 50,),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: double.infinity,
                          child: CustomButton(
                            onPressed: _uploadData,
                            btnText: 'ADD PORTFOLIO',
                          ),
                        )
                      ],
                    ),
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
