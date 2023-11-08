import 'dart:convert';

import 'package:flutter/material.dart';

import '../Models/SkillModel.dart';
import '../components/BuildInputDecoration.dart';
import '../components/CustomButton.dart';
import '../components/SkillBadge.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
class AddMoreSkills extends StatefulWidget {

  final List<SkillModel> selectedSkills;

  const AddMoreSkills({required this.selectedSkills, Key? key}) : super(key: key);

  @override
  State<AddMoreSkills> createState() => _AddMoreSkillsState();
}

class _AddMoreSkillsState extends State<AddMoreSkills> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  List<SkillModel> skills = [];

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
        setState(() {
          skills = (responseData as List).map((item){
            bool isSelected = widget.selectedSkills.any((selectedSkill) => selectedSkill.id == item['id']);
            return SkillModel(item['id'], item['name'], item['slug'],isSelected);
          }).toList();
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
        title: Text('Add Skills'),
        backgroundColor: Color(0xff031a38),
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
                            child: CustomButton(
                              onPressed: _setSkill,
                              btnText: 'SET SKILL',
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
  void _setSkill(){
    List<SkillModel> _selectedSkill = skills.where((element) => element.isSelected == true).toList();
    Navigator.of(context).pop(_selectedSkill);
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
