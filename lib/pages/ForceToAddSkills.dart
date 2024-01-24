import 'dart:convert';

import 'package:disiniwork/pages/ForceToAddBio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/SkillModel.dart';
import '../components/BuildInputDecoration.dart';
import '../components/CustomButton.dart';
import '../components/SkillBadge.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
class ForceToAddSkills extends StatefulWidget {

  const ForceToAddSkills({super.key});

  @override
  State<ForceToAddSkills> createState() => _AddMoreSkillsState();
}

class _AddMoreSkillsState extends State<ForceToAddSkills> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  List<SkillModel> skills = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllSkills();
  }

  void getAllSkills() async{
    try{

      final Uri url = Uri.parse('$apiBaseUrl/getskils');
      var response = await http.get(url);
      final responseData = json.decode(response.body);
      if(response.statusCode == 200){
         var _skills = (responseData as List).map((item){
          bool isSelected = false;
          return SkillModel(item['id'], item['name'], item['slug'],isSelected);
        }).toList();
        setState(() {
          skills = _skills;
        });
      }
    }catch(error){
      print('Error from skill: ${error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add skill',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffF85301),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body:SafeArea(
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    //alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 3,),
                          Container(
                            height: MediaQuery.of(context).size.height*0.8,
                            child: ListView.builder(
                              itemCount: skills.length,
                              itemBuilder: (context, index) {

                                return CheckboxListTile(
                                  title: Text(skills[index].name),
                                  value: skills[index].isSelected,
                                  onChanged: (bool? value){
                                    int maxSkillSet = getMaxSkillSet();
                                    if(maxSkillSet < 5 || value == false){
                                      setState(() {
                                        skills[index].isSelected = value ?? false;
                                      });
                                    }else{
                                      showSkillLimitAlert(context);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: !isLoading ? CustomButton(
                              onPressed: _setSkill,
                              btnText: 'SET SKILL',
                            ) : Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff031a38)), // Change this to your desired color
                                strokeWidth: 2,
                              ),
                            ),
                          ),
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
  void _setSkill() async{
    try{
      setState(() {
        isLoading = true;
      });
      List<SkillModel> _selectedSkill = skills.where((element) => element.isSelected == true).toList();
      final List<int> skillIds = _selectedSkill.map((skill) => skill.id).toList();
      final sharedPreference = await SharedPreferences.getInstance();
      final String? token = sharedPreference.getString('token');
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ForceToAddBio();
          },
        ),
      );
    }catch(error){
      print('Error from force skill add page: ${error}');
    }
    setState(() {
      isLoading = false;
    });
    //Navigator.of(context).pop(_selectedSkill);
  }
  getMaxSkillSet(){
    return skills.where((element) => element.isSelected == true).length;
  }
  void showSkillLimitAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Skill Limit Exceeded'),
          content: Text('You can only add up to 5 skills.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
